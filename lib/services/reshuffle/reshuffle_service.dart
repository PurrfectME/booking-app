import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:dartx/dartx.dart';

class ReshuffleService {
  const ReshuffleService();

  //только id заведения
  Future makeReshuffle(int placeId) async {
    //TODO: столы которые имеют статус активной брони или ожидание гостя
    //TODO: делать им excludeReshuffle = true

    final tables = await DbProvider.db.getTables(placeId);

    final shufflingMap = <int, Map<int, List<TableReservation>>>{};

    for (final table in tables) {
      if (!shufflingMap.containsKey(table.guests)) {
        final map = {table.guests: <int, List<TableReservation>>{}};

        shufflingMap.addAll(map);
      }
    }

    for (final table in tables) {
      final reservations =
          await DbProvider.db.getTableReservations(placeId, table.id);

      if (reservations.isEmpty) {
        shufflingMap[table.guests]?.update(
          0,
          (value) {
            final result = <TableReservation>[];
            value.map(result.add).toList();
            result.add(TableReservation(table: table, reservation: null));
            return result;
          },
          ifAbsent: () => [TableReservation(table: table, reservation: null)],
        );

        continue;
      }

      for (final reservation in reservations) {
        final tableReservation =
            TableReservation(table: table, reservation: reservation);

        if (!shufflingMap[table.guests]!.containsKey(reservation.guests)) {
          shufflingMap[table.guests]?.addAll(
            {
              reservation.guests: [tableReservation]
            },
          );
        } else {
          shufflingMap[table.guests]!.update(
            reservation.guests,
            (value) {
              final result = <TableReservation>[];
              value.map(result.add).toList();
              result.add(tableReservation);
              return result;
            },
          );
        }
      }
    }

    final maxTableCapacity = shufflingMap.keys.max()!;
    for (var i = maxTableCapacity; i >= 2; i--) {
      for (var j = i - 1; j >= 1; j--) {
        if (shufflingMap[i] == null || shufflingMap[i]![j] == null) {
          continue;
        }

        if (shufflingMap[j]![0]!.isNotEmpty) {
          final reservationToMove = shufflingMap[i]![j]!.first;

          //remove from [i][j]
          shufflingMap[i]!.update(j, (value) {
            value.removeAt(0);
            return value;
          });

          //add to [i][0]
          shufflingMap[i]!.update(0, (value) {
            final localReservation = reservationToMove.copyWith(
                table: reservationToMove.table, reservation: null);
            value.add(localReservation);
            return value;
          });

          final a = shufflingMap[j]![0]!.first;

          //database update
          await DbProvider.db.updateReservation(
            placeId,
            reservationToMove.reservation!.id!,
            {'tableId': a.table.id},
          );

          //remove from [j][0]
          shufflingMap[j]!.update(0, (value) {
            value.removeAt(0);
            return value;
          });

          //add to [j][j]
          shufflingMap[j]!.update(j, (value) {
            value.add(reservationToMove);
            return value;
          }, ifAbsent: () => [reservationToMove]);
        }
      }
    }

    //  if(map[j][0] != null){

    //           map[i][j].remove(x => x.tableId && reservationId)
    //           map[i][0].add(x.tableId && reservationId)

    //           map[j][0].remove(x => tables.first)
    //           map[j][j].add(x.tableId && reservationId)
    //         }

/*
  6: {
    4: [table 1(res 1), table 1(res 2)]
  },

  4: {
    4: [table 2(res 1)]
    0: []
  }
 */

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
