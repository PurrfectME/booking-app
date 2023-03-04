import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/table_reservation_vm.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableCard extends StatefulWidget {
  final TableReservationViewModel model;
  final DateTime selectedDateTime;
  const TableCard(
      {super.key, required this.model, required this.selectedDateTime});

  @override
  State<TableCard> createState() => _TableCardState();
}

class _TableCardState extends State<TableCard> {
  int currentGuestsCount = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final images = [
      'assets/images/table1.PNG',
      'assets/images/table2.PNG',
      'assets/images/table3.PNG'
    ];

    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: const Color.fromARGB(255, 59, 59, 59),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) => Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  image: DecorationImage(
                      opacity: 1,
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover),
                ),
              ),
              options: CarouselOptions(
                aspectRatio: 5 / 3,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                enlargeCenterPage: false,
                onPageChanged: null,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Столик ${widget.model.table.number}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Мест: ${widget.model.table.guests}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Text(
                    'Депозит(VIP): 200руб.',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        height: 60,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          color: const Color.fromARGB(255, 85, 85, 85),
                          child: Row(
                            children: [
                              IconButton(
                                  splashColor:
                                      const Color.fromARGB(160, 85, 85, 85),
                                  onPressed: _canDescrease(currentGuestsCount)
                                      ? _onGuestsCountDecrease
                                      : null,
                                  icon: Icon(Icons.remove,
                                      color: _canDescrease(currentGuestsCount)
                                          ? Colors.white
                                          : Colors.black)),
                              Text('$currentGuestsCount'),
                              IconButton(
                                splashColor:
                                    const Color.fromARGB(160, 85, 85, 85),
                                onPressed: _canIncrease(currentGuestsCount,
                                        widget.model.table.guests)
                                    ? _onGuestsCountIncrease
                                    : null,
                                icon: Icon(Icons.add,
                                    color: _canIncrease(currentGuestsCount,
                                            widget.model.table.guests)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.yellow),
                            ),
                            onPressed: () => context
                                .read<PlaceInfoBloc>()
                                .add(UserTableReserve(
                                    widget.model.table.id,
                                    currentGuestsCount,
                                    widget.selectedDateTime,
                                    //дефолтное время брони 3 часа
                                    widget.selectedDateTime.add(
                                      const Duration(hours: 3),
                                    ))),
                            child: const Text(
                              'Забронировать',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  bool _canIncrease(int reservedGuests, int maxGuests) =>
      reservedGuests < maxGuests;

  bool _canDescrease(int reservedGuests) => reservedGuests > 1;

  void _onGuestsCountDecrease() {
    setState(() {
      currentGuestsCount--;
    });
  }

  void _onGuestsCountIncrease() {
    setState(() {
      currentGuestsCount++;
    });
  }
}
