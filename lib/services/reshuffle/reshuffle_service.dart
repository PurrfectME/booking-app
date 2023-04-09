import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';

class ReshuffleService {
  const ReshuffleService();

  //только id заведения
  Future makeReshuffle(int placeId) async {
    //TODO: столы которые имеют статус активной брони или ожидание гостя
    //TODO: делать им excludeReshuffle = true

    final tables = await DbProvider.db.getTables(placeId);

    final shufflingMap = <int, Map<int, List<TableModel>>>{};

    for (final table in tables) {
      if (!shufflingMap.containsKey(table.guests)) {
        final map = {table.guests: <int, List<TableModel>>{}};

        shufflingMap.addAll(map);
      }
    }

    for (final table in tables) {
      final tableReservations =
          await DbProvider.db.getTableReservations(placeId, table.id);

      if (tableReservations.isEmpty) {
        shufflingMap[table.guests]?.update(
          0,
          (value) {
            final result = <TableModel>[];
            value.map(result.add).toList();
            result.add(table);
            return result;
          },
          ifAbsent: () => [table],
        );

        continue;
      }

      for (final reservation in tableReservations) {
        if (!shufflingMap[table.guests]!.containsKey(reservation.guests)) {
          shufflingMap[table.guests]?.addAll(
            {
              reservation.guests: [table]
            },
          );
        } else {
          shufflingMap[table.guests]!.update(
            reservation.guests,
            (value) {
              final result = <TableModel>[];
              value.map(result.add).toList();
              result.add(table);
              return result;
            },
          );
        }
      }
    }

    /*
      Map<int, Map<int, TableModel>>{
        'tableCapacity': {
          'reservationGuestsCount': [table] - занятые или свободные столы если ключ 0
        },

      makeShuffle(){
        for(int i = 4; i < maxTableCapacity (6); i++){
          for(int j = i - 1; j >= 1; j--){
if(map[i][j] == null){
  continue;
}


            if(map[j][0] != null){

              map[i][j].remove(x => x.tableId && reservationId)

              map[i][0].add(x.tableId && reservationId)


              map[j][0].remove(x => tables.first)
              map[j][j].add(x.tableId && reservationId)
            }
          }
        }
      }

      '4': {
        0: [1]
      },
      

      '6': {
        4: [5]
        0: [6, 4]
      },



    
    */
  }
}
