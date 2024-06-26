import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/place_info/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableWrapper extends StatelessWidget {
  final VoidCallback onDateTimeTap;
  final DateTime selectedDateTime;
  final List<TableReservationDto?> data;
  final void Function(TableModel) showTableReserveDialog;
  final int? reservedTableId;

  const TableWrapper({
    super.key,
    required this.onDateTimeTap,
    required this.selectedDateTime,
    required this.data,
    required this.showTableReserveDialog,
    required this.reservedTableId,
  });

  @override
  Widget build(BuildContext context) => Column(
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
                  .map(
                    (tableVm) => CarouselSlider.builder(
                      itemCount: data.length, //COUNT OF PHOTOS
                      itemBuilder: (context, index, realIndex) =>
                          tableVm!.table.id != reservedTableId
                              ? InkWell(
                                  onTap: () =>
                                      showTableReserveDialog(tableVm.table),
                                  child: Container(
                                      margin: const EdgeInsets.only(bottom: 50),
                                      child: TableInfo(
                                        isReservedByUser:
                                            tableVm.isReservedByUser,
                                        table: tableVm.table,
                                      )),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(bottom: 50),
                                  child: TableInfo(
                                    isReservedByUser: tableVm.isReservedByUser,
                                    table: tableVm.table,
                                  ),
                                ),
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
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      );
}
