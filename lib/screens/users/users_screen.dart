import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/db/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatefulWidget {
  final UserBloc uBloc;
  const UsersScreen({
    super.key,
    required this.uBloc,
  });

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) => BlocConsumer<UserBloc, UserState>(
        bloc: widget.uBloc,
        listener: (context, state) {
          if (state is UsersSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Сохранено')),
            );
          }
        },
        builder: (context, state) {
          if (state is UsersLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Сотрудники'),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder()),
                    onPressed: _createUser,
                    child: const Text('Добавить пользователя'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder()),
                    onPressed: _createRole,
                    child: const Text('Добавить роль'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder()),
                    onPressed: _saveUsers,
                    child: const Text('Сохранить'),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Пользователи',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        DataTable(
                          columns: const [
                            DataColumn(
                                label: Text(
                              'Имя',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              'Роль',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataColumn(
                              label: Text(''),
                            ),
                          ],
                          rows: state.users
                              .map((user) => DataRow(cells: [
                                    DataCell(TextField(
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                      controller: TextEditingController(
                                          text: user.name),
                                      onChanged: (value) {
                                        widget.uBloc.add(EditUser(
                                          id: user.id,
                                          role: user.role,
                                          name: value,
                                        ));
                                      },
                                    )),
                                    DataCell(
                                      Container(
                                        width: 150,
                                        child: DropdownButton<Role>(
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                          selectedItemBuilder: (context) =>
                                              state.roles
                                                  .map(
                                                    (value) => Text(value.name,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15)),
                                                  )
                                                  .toList(),
                                          value: state.roles.firstWhere(
                                              (x) => x.name == user.role),
                                          items: state.roles
                                              .map((value) =>
                                                  DropdownMenuItem<Role>(
                                                    value: value,
                                                    child: Text(value.name,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15)),
                                                  ))
                                              .toList(),
                                          onChanged: (newValue) {
                                            widget.uBloc.add(EditUser(
                                                id: user.id,
                                                role: newValue!.name,
                                                name: user.name));
                                          },
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete_forever,
                                            color: Colors.white),
                                        onPressed: () {
                                          widget.uBloc
                                              .add(RemoveUser(user: user));
                                        },
                                      ),
                                    ),
                                  ]))
                              .toList(),
                        ),
                      ],
                    ),
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
                    Column(
                      children: [
                        const Text(
                          'Роли',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        DataTable(
                          columns: const [
                            DataColumn(
                                label: Text(
                              'Роль',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataColumn(
                              label: Text(''),
                            ),
                          ],
                          rows: state.roles
                              .map((role) => DataRow(cells: [
                                    DataCell(TextField(
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                      controller: TextEditingController(
                                          text: role.name),
                                      onChanged: (value) {
                                        widget.uBloc.add(EditRole(
                                          id: role.id,
                                          name: value,
                                        ));
                                      },
                                    )),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete_forever,
                                            color: Colors.white),
                                        onPressed: () {
                                          widget.uBloc
                                              .add(RemoveRole(role: role));
                                        },
                                      ),
                                    ),
                                  ]))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  void _createRole() {
    widget.uBloc.add(AddRole());
  }

  void _createUser() {
    widget.uBloc.add(AddUser());
  }

  void _saveUsers() {
    widget.uBloc.add(SaveUsers());
  }
}
