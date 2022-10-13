import 'package:flutter/material.dart';

class SlamMap extends StatefulWidget {
  const SlamMap({Key? key}) : super(key: key);

  @override
  State<SlamMap> createState() => _SlamMapState();
}

class _SlamMapState extends State<SlamMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(top: 12.5, left: 12.5, bottom: 50, right: 12.5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 144, 251, 144),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Map',
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Expanded(
              child: Center(child: CircularProgressIndicator.adaptive()))
        ],
      ),
    );
  }
}
