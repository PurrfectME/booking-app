import 'dart:developer';

import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:dartx/dartx.dart';

class ReshuffleService {
  const ReshuffleService();

//  Map<int, Map<int, TableModel>>{
//    'tableCapacity': {
//      'reservationGuestsCount': [table] - занятые или свободные столы если ключ 0
//    },

  Future makeReshuffle(int placeId) async {
    //TODO: столы которые имеют статус активной брони или ожидание гостя
    //TODO: делать им excludeReshuffle = true

    final tables = await DbProvider.db.getTables(placeId);

    final shufflingMap = <int, Map<int, List<TableReservation>>>{};

    for (final table in tables) {
      if (!shufflingMap.containsKey(table.guests)) {
        final map = {
          table.guests: <int, List<TableReservation>>{0: []}
        };

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
      if (shufflingMap[i] == null) {
        continue;
      }
      for (var j = i - 1; j >= 1; j--) {
        if (shufflingMap[i]![j] == null) {
          continue;
        }

        //если бронь на 4 человека на 6 местный столы, а столов на 4 нет, есть только свободный на 5,
        //то нужно ету бронь кидать на 5 местный свободный стол

        if (shufflingMap[j + 1] != null) {
          var k = j + 1;
          if (shufflingMap[k]![0]!.isNotEmpty) {
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

            final newTableIdForReservation =
                shufflingMap[k]![0]!.first.table.id;

            //database update
            await DbProvider.db.updateReservation(
              placeId,
              reservationToMove.reservation!.id!,
              {'tableId': newTableIdForReservation},
            );

            log('BEFORE update: ${shufflingMap[k]!}');

            //remove from [j][0]
            shufflingMap[k]!.update(0, (value) {
              value.removeAt(0);
              return value;
            });

            log('AFTER update: ${shufflingMap[k]!}');

            //add to [j][j]
            shufflingMap[k]!.update(j, (value) {
              value.add(reservationToMove);
              return value;
            }, ifAbsent: () => [reservationToMove]);
          }
        } else {
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

            final newTableIdForReservation =
                shufflingMap[j]![0]!.first.table.id;

            //database update
            await DbProvider.db.updateReservation(
              placeId,
              reservationToMove.reservation!.id!,
              {'tableId': newTableIdForReservation},
            );

            log('BEFORE update: ${shufflingMap[j]!}');

            //remove from [j][0]
            shufflingMap[j]!.update(0, (value) {
              value.removeAt(0);
              return value;
            });

            log('AFTER update: ${shufflingMap[j]!}');

            //add to [j][j]
            shufflingMap[j]!.update(j, (value) {
              value.add(reservationToMove);
              return value;
            }, ifAbsent: () => [reservationToMove]);
          }
        }
      }
    }

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
