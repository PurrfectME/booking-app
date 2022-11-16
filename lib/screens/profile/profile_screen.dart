import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatefulWidget {
  static const pageRoute = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("АРТЁМ ЕБОШИТ"),
    );
  }
}
