import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 82, 232, 82),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(top: 50, left: 50, bottom: 50, right: 25),
    );
  }
}
