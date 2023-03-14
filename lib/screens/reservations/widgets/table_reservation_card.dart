import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/reservations/widgets/reservation_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TableReservationCard extends StatefulWidget {
  final ReservationsBloc reservationsBloc;
  final TableModel tableModel;
  final DateTime selectedDateTime;
  final List<UserReservationModel> reservations;
  final UserReservationModel? nextReservation;

  const TableReservationCard({
    super.key,
    required this.reservationsBloc,
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
                                  'Гость: ${widget.nextReservation!.reservation.name} ',
                              children: [
                                TextSpan(
                                    text: widget.nextReservation!.reservation
                                        .phoneNumber,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => _onPhoneTap(widget
                                          .nextReservation!
                                          .reservation
                                          .phoneNumber!))
                              ]),
                        ),
                      const Spacer(),
                      Builder(builder: (context) {
                        final availableReservation = () {
                          if (widget.nextReservation == null) return true;
                          return widget.selectedDateTime
                                  .difference(
                                      DateTime.fromMillisecondsSinceEpoch(widget
                                          .nextReservation!.reservation.start))
                                  .inMinutes
                                  .abs() >
                              180;
                        }();
                        return SizedBox(
                          height: 32,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                disabledBackgroundColor: Colors.grey),
                            onPressed: availableReservation
                                ? () => _reserveTable(widget.tableModel.id,
                                    widget.tableModel.placeId)
                                : null,
                            child: const Text(
                              'Забронировать',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Future _onCardTap(List<UserReservationModel> reservations) async {
    await showBarModalBottomSheet<void>(
        context: context,
        builder: (context) => BlocBuilder<ReservationsBloc, ReservationsState>(
            bloc: widget.reservationsBloc,
            builder: (context, state) {
              if (state is ReservationsLoaded) {
                final filteredReservations = state.data
                    .firstWhere((e) => e.table.id == widget.tableModel.id)
                    .reservations
                    .where((reserv) =>
                        reserv.reservation.start >=
                        widget.selectedDateTime.millisecondsSinceEpoch)
                    .toList();
                return filteredReservations.isNotEmpty
                    ? SizedBox(
                        height: 500,
                        child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            itemCount: filteredReservations.length,
                            separatorBuilder: (context, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final reservationModel =
                                  filteredReservations[index];
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 24),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromARGB(255, 59, 59, 59),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Столик ${widget.tableModel.number}',
                                      style:
                                          const TextStyle(color: Colors.white),
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
                                            'Гость: ${reservationModel.reservation.name} (${reservationModel.reservation.phoneNumber})',
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              _editReservation(
                                                  reservationModel
                                                      .reservation.placeId,
                                                  reservationModel
                                                      .reservation.tableId,
                                                  reservationModel
                                                      .reservation.phoneNumber!,
                                                  reservationModel
                                                      .reservation.name!,
                                                  reservationModel
                                                      .reservation.guests,
                                                  reservationModel
                                                      .reservation.id!,
                                                  reservationModel
                                                      .reservation.start,
                                                  reservationModel
                                                      .reservation.end);
                                              // widget.reservations.removeAt(index);
                                            },
                                            child: const Text(
                                              'Редактировать',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
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
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )),
                      );
              } else {
                // TODO
                return const CupertinoActivityIndicator();
              }
            }));
  }

  void _reserveTable(int tableId, int placeId) => showDialog<void>(
      context: context,
      // ignore: prefer_expression_function_bodies
      builder: (context) => ReservationDialog(
            reservationsBloc: widget.reservationsBloc,
            placeId: placeId,
            tableId: tableId,
            maxGuests: widget.tableModel.guests,
            selectedDateTime: widget.selectedDateTime,
            phoneNumber: '',
            name: '',
            guestsCount: 1,
            isEdit: false,
          ));

  void _removeReservation(int reservationId, int placeId, int tableNumber) {
    widget.reservationsBloc.add(RemoveReservation(
        reservationId: reservationId,
        placeId: placeId,
        tableNumber: tableNumber));
  }

  Future _editReservation(int placeId, int tableId, String phone, String name,
          int guests, int reservationId, int start, int end) =>
      showDialog<void>(
          context: context,
          builder: (context) => ReservationDialog(
              reservationsBloc: widget.reservationsBloc,
              placeId: placeId,
              tableId: tableId,
              maxGuests: widget.tableModel.guests,
              selectedDateTime: widget.selectedDateTime,
              phoneNumber: phone,
              name: name,
              guestsCount: guests,
              isEdit: true,
              reservationId: reservationId,
              start: start,
              end: end));

  void _onPhoneTap(String phone) {
    launchUrlString('tel:${phone.replaceAll(' ', '')}');
  }
}
