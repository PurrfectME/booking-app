import 'package:booking_app/models/local/table_vm.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  final TableViewModel model;
  final int currentGuestsCount;
  final Function() increaseCallback;
  final Function() decreaseCallback;

  const TableCard(
      {super.key,
      required this.model,
      required this.currentGuestsCount,
      required this.increaseCallback,
      required this.decreaseCallback});

  @override
  Widget build(BuildContext context) {
    final images = [
      "assets/images/table1.PNG",
      "assets/images/table2.PNG",
      "assets/images/table3.PNG"
    ];

    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: const Color.fromARGB(255, 95, 95, 95),
        child: Column(
          children: [
            CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: ((context, index, realIndex) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        image: DecorationImage(
                            opacity: 1,
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover)),
                  );
                }),
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
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text('Столик ${model.table.number}'),
                  ),
                  Container(
                    child: Text('Мест: ${model.table.guests}'),
                  ),
                  Row(
                    children: [
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        color: const Color.fromARGB(255, 61, 58, 58),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: _canDescrease(currentGuestsCount)
                                    ? decreaseCallback
                                    : null,
                                icon: Icon(Icons.remove,
                                    color: _canDescrease(currentGuestsCount)
                                        ? Colors.white
                                        : Colors.black)),
                            Text('$currentGuestsCount'),
                            IconButton(
                                onPressed: _canIncrease(
                                        currentGuestsCount, model.table.guests)
                                    ? increaseCallback
                                    : null,
                                icon: Icon(Icons.add,
                                    color: _canIncrease(currentGuestsCount,
                                            model.table.guests)
                                        ? Colors.white
                                        : Colors.black)),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.yellow)),
                          onPressed: null,
                          child: const Text(
                            'Забронировать',
                            style: TextStyle(color: Colors.black),
                          )),
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
}
