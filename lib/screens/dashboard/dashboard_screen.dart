import 'dart:ui';

import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/blocs/edit_scheme/edit_scheme_bloc.dart';
import 'package:booking_app/blocs/kitchen/kitchen_bloc.dart';
import 'package:booking_app/models/db/user.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/dashboard/widgets/place_item.dart';
import 'package:booking_app/screens/kitchen/kitchen_screen.dart';
import 'package:booking_app/screens/products/products_screen.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/create_place_form.dart';

class DashboardScreen extends StatefulWidget {
  static const pageRoute = '/dashboard';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is DashboardLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('UReserve'),
                centerTitle: false,
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.user.email,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(width: 30),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    backgroundColor: Colors.black,
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                            color: Colors.red, width: 2))),
                                onPressed: () {},
                                child: const SizedBox(
                                    height: 35,
                                    width: 90,
                                    child: Center(
                                        child: Text('Выйти',
                                            style: TextStyle(fontSize: 20)))))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 140),
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 69),
                            width: 3,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 23, 23, 23),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 42),
                    Expanded(
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 4,
                        children: [
                          InkWell(
                            onTap: () {
                              final kBloc = context.read<KitchenBloc>()
                                ..add(KitchenLoad());
                              Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          KitchenScreen(kBloc: kBloc)));
                            },
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.all(4),
                              child: const Center(
                                child: Text(
                                  '[Кухня]',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final pBloc = context.read<ProductBloc>()
                                ..add(ProductsLoad());
                              Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductsScreen(pBloc: pBloc)));
                            },
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.all(4),
                              child: const Center(
                                child: Text(
                                  '[Продукты]',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final dBloc = context.read<DishBloc>()
                                ..add(const DishLoad());
                              Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DishScreen(
                                            dBloc: dBloc,
                                            isSelectable: false,
                                          )));
                            },
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.all(4),
                              child: const Center(
                                child: Text(
                                  '[Блюда]',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final tBloc = context.read<TablesBloc>();
                              final oBloc = context.read<OrderBloc>();
                              final trBloc = context
                                  .read<TableReservationsBloc>()
                                ..add(TableReservationsLoad());
                              final rBloc = context.read<ReservationsBloc>();
                              Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TablesScreen(
                                            tBloc: tBloc,
                                            trBloc: trBloc,
                                            rBloc: rBloc,
                                            oBloc: oBloc,
                                          )));
                            },
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.all(4),
                              child: const Center(
                                child: Text(
                                  '[Столы]',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final oBloc = context.read<OrderBloc>();
                              Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                EditSchemeBloc()
                                                  ..add(EditSchemeLoad()),
                                            child: TablesSchemeScreen(
                                                oBloc: oBloc),
                                          )));
                            },
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.all(4),
                              child: const Center(
                                child: Text(
                                  '[Схема]',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final oBloc = context.read<OrderBloc>()
                                ..add(OrderLoad(orderId: 0));

                              final dBloc = context.read<DishBloc>();

                              Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderScreen(
                                          oBloc: oBloc,
                                          tableNumber: 1,
                                          dBloc: dBloc)));
                            },
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.all(4),
                              child: const Center(
                                child: Text(
                                  '[Счета]',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final uBloc = context.read<UserBloc>()
                                ..add(UsersLoad());

                              Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UsersScreen(uBloc: uBloc)));
                            },
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.all(4),
                              child: const Center(
                                child: Text(
                                  '[Пользователи]',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
}
