import 'package:flutter/material.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({Key? key}) : super(key: key);

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 25, bottom: 12.5),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Welcome to the',
            textScaleFactor: 1.5,
          ),
          Text('ORBSLAM Interactive Learning Dashboard',
              textScaleFactor: 2.5,
              style: TextStyle(fontWeight: FontWeight.bold, shadows: [
                Shadow(
                    color: Color.fromARGB(255, 186, 186, 186),
                    offset: Offset(1, 1),
                    blurRadius: 1)
              ])),
        ],
      ),
    );
  }
}
