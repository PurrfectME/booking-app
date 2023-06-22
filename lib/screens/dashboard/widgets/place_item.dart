// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/constants/constants.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  final String name;
  final String address;
  final String city;
  final bool allowBooking;

  const PlaceItem({
    Key? key,
    required this.name,
    required this.address,
    required this.city,
    required this.allowBooking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: 596,
        height: 243,
        // margin: const EdgeInsets.only(bottom: 20),
        // constraints: const BoxConstraints(
        //     maxWidth: 300, maxHeight: 243, minHeight: 243, minWidth: 250),
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
                          name,
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
                      'г. ${city.capitalize()}, ул. ${address.capitalize()}',
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
                          onChanged: (bool value) {},
                          value: allowBooking,
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
