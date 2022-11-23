import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/place_info/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableWrapper extends StatelessWidget {
  final onDateTimeTap;
  final DateTime selectedDateTime;
  final List<TableModel> data;
  final void Function(TableModel) showTableReserveDialog;
  final int? reservedTableId;

  const TableWrapper(
      {super.key,
      required this.onDateTimeTap,
      required this.selectedDateTime,
      required this.data,
      required this.showTableReserveDialog,
      required this.reservedTableId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: onDateTimeTap,
            child: Text(DateFormat('E, d MMM yyyy HH:mm', 'RU')
                .format(selectedDateTime))),
        Expanded(
          child: GridView.count(
              primary: false,
              crossAxisCount: 1,
              children: data
                  .map((table) => CarouselSlider.builder(
                      itemCount: data.length, //COUNT OF PHOTOS
                      itemBuilder: (context, index, realIndex) {
                        return table.id != reservedTableId
                            ? InkWell(
                                onTap: () => showTableReserveDialog(table),
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 50),
                                    child: const TableInfo(isReserved: false)),
                              )
                            : Container(
                                margin: const EdgeInsets.only(bottom: 50),
                                child: const TableInfo(isReserved: true));
                      },
                      options: CarouselOptions(
                        aspectRatio: 1,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        enlargeCenterPage: false,
                        onPageChanged: null,
                        scrollDirection: Axis.horizontal,
                      )))
                  .toList()),
        )
      ],
    );
  }
}
