// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/blocs/dashboard/dashboard_bloc.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceItem extends StatefulWidget {
  final int id;
  final String name;
  final String address;
  final String city;
  final bool allowBooking;
  final int onwerId;
  const PlaceItem({
    Key? key,
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.allowBooking,
    required this.onwerId,
  }) : super(key: key);

  @override
  State<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
  bool canBook = false;

  @override
  void initState() {
    canBook = widget.allowBooking;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: 596,
        height: 243,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              width: 2, color: const Color.fromARGB(255, 45, 45, 45)),
          color: const Color.fromARGB(255, 23, 23, 23),
        ),
        child: Row(
          children: [
            Container(
              width: 222,
              height: 239,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                image: DecorationImage(
                    opacity: 1,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/neft.jpg')),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                        const Icon(
                          Icons.arrow_right_alt_outlined,
                          color: Colors.white,
                          size: 45,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'г. ${widget.city.capitalize()}, ул. ${widget.address.capitalize()}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 73),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Доступен для бронирования',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        Switch(
                          inactiveTrackColor: Colors.grey,
                          activeColor: Colors.white,
                          activeTrackColor: Constants.mainPurple,
                          onChanged: (bool value) {
                            setState(() {
                              canBook = !canBook;
                            });
                            context.read<DashboardBloc>().add(ChangeBookingType(
                                  placeId: widget.id,
                                  ownerId: widget.onwerId,
                                ));
                          },
                          value: canBook,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
