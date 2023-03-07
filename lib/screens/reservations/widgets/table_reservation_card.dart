import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/reservations/widgets/reservation_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TableReservationCard extends StatefulWidget {
  final TableModel tableModel;
  final DateTime selectedDateTime;
  final List<UserReservationModel> reservations;
  final UserReservationModel? nextReservation;

  const TableReservationCard({
    super.key,
    required this.tableModel,
    required this.selectedDateTime,
    required this.reservations,
    required this.nextReservation,
  });

  @override
  State<TableReservationCard> createState() => _TableReservationCardState();
}

class _TableReservationCardState extends State<TableReservationCard> {
  @override
  Widget build(BuildContext context) => Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: const Color.fromARGB(255, 59, 59, 59),
        child: SizedBox(
          height: 190,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async => await _onCardTap(widget.reservations),
                child: Container(
                  width: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    image: DecorationImage(
                        opacity: 1,
                        image: AssetImage("assets/images/neft.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Столик ${widget.tableModel.number}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      if (widget.nextReservation != null) const Spacer(),
                      if (widget.nextReservation == null)
                        Text('Гостей: ${widget.tableModel.guests}',
                            style: const TextStyle(color: Colors.white)),
                      if (widget.nextReservation != null)
                        Text(
                            'Гостей: ${widget.nextReservation!.reservation.guests}',
                            style: const TextStyle(color: Colors.white)),
                      if (widget.nextReservation != null)
                        Text(
                            'Дата: ${DateFormat('E, d MMM yyyy HH:mm', 'RU').format(DateTime.fromMillisecondsSinceEpoch(widget.nextReservation!.reservation.start))}',
                            style: const TextStyle(color: Colors.white)),
                      if (widget.nextReservation != null)
                        RichText(
                          text: TextSpan(
                              text:
                                  'Гость: ${widget.nextReservation!.user.name} ',
                              children: [
                                TextSpan(
                                    text: widget.nextReservation!.user.login,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => _onPhoneTap(
                                          widget.nextReservation!.user.login))
                              ]),
                        ),
                      const Spacer(),
                      SizedBox(
                        height: 32,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.yellow),
                          ),
                          onPressed: () async => await _reserveTable(
                              widget.tableModel.id, widget.tableModel.placeId),
                          child: const Text(
                            'Забронировать',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Future _onCardTap(List<UserReservationModel> reservations) async {
    final filteredReservations = reservations
        .where((reserv) =>
            reserv.reservation.start >=
            widget.selectedDateTime.millisecondsSinceEpoch)
        .toList();

    await showBarModalBottomSheet<void>(
        context: context,
        builder: (context) => filteredReservations.isNotEmpty
            ? SizedBox(
                height: 500,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    itemCount: filteredReservations.length,
                    itemBuilder: (context, index) {
                      final reservationModel = filteredReservations[index];
                      return Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        color: const Color.fromARGB(255, 59, 59, 59),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Столик ${widget.tableModel.number}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Гостей: ${reservationModel.reservation.guests}',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      Text(
                                          'Дата: ${DateFormat('E, d MMM yyyy HH:mm', 'RU').format(DateTime.fromMillisecondsSinceEpoch(reservationModel.reservation.start))}',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      Text(
                                          'Гость: ${reservationModel.user.name}(${reservationModel.user.login})',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.yellow),
                                          ),
                                          onPressed: () {
                                            //TODO: delete reservation from bottom sheet
                                            _removeReservation(
                                                reservationModel
                                                    .reservation.id!,
                                                reservationModel
                                                    .reservation.placeId,
                                                widget.tableModel.number);
                                            filteredReservations
                                                .removeAt(index);
                                          },
                                          child: const Text(
                                            'Редактировать',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.yellow),
                                          ),
                                          onPressed: () {
                                            //TODO: delete reservation from bottom sheet
                                            _removeReservation(
                                                reservationModel
                                                    .reservation.id!,
                                                reservationModel
                                                    .reservation.placeId,
                                                widget.tableModel.number);
                                            filteredReservations
                                                .removeAt(index);
                                          },
                                          child: const Text(
                                            'Отменить',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              )
            : const SizedBox(
                height: 100,
                width: 100,
                child: Center(
                    child: Text(
                  'Нет броней',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                )),
              ));
  }

  Future _reserveTable(int tableId, int placeId) => showDialog<void>(
      context: context,
      // ignore: prefer_expression_function_bodies
      builder: (context) {
        return ReservationDialog(
            placeId: placeId,
            tableId: tableId,
            maxGuests: widget.tableModel.guests,
            selectedDateTime: widget.selectedDateTime);
      });

  void _removeReservation(int reservationId, int placeId, int tableNumber) {
    context.read<ReservationsBloc>().add(RemoveReservation(
        reservationId: reservationId,
        placeId: placeId,
        tableNumber: tableNumber));
  }

  Future _editReservation() async {}

  void _onPhoneTap(String phone) {
    launchUrlString('tel:${phone.replaceAll(' ', '')}');
  }
}
