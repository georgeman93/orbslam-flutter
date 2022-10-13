import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Controls extends StatefulWidget {
  const Controls({Key? key}) : super(key: key);

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  int fps = 30;
  late WebSocketChannel channel;
  late Stream controlStream;
  @override
  void initState() {
    // channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));
    // controlStream = channel.stream;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(top: 12.5, left: 25, bottom: 12.5, right: 12.5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 144, 251, 144),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ButtonBar(
        buttonPadding: const EdgeInsets.only(left: 20),
        alignment: MainAxisAlignment.start,
        children: [
          const Text('Controls  ',
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 186, 186, 186),
                    offset: Offset(1, 1))
              ],
              color: const Color.fromARGB(255, 82, 232, 82),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
                onPressed: () {
                  channel.sink.add('play');
                },
                icon: const Icon(
                  Icons.play_arrow,
                  shadows: [
                    Shadow(
                        color: Color.fromARGB(255, 186, 186, 186),
                        offset: Offset(1, 1))
                  ],
                )),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 186, 186, 186),
                    offset: Offset(1, 1))
              ],
              color: const Color.fromARGB(255, 82, 232, 82),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
                onPressed: () {
                  channel.sink.add('restart');
                },
                icon: const Icon(
                  Icons.restart_alt,
                  shadows: [
                    Shadow(
                        color: Color.fromARGB(255, 186, 186, 186),
                        offset: Offset(1, 1))
                  ],
                )),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 186, 186, 186),
                      offset: Offset(1, 1))
                ],
                color: const Color.fromARGB(255, 82, 232, 82),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text('$fps FPS '),
                  SizedBox(
                    width: 21,
                    child: IconButton(
                        iconSize: 20,
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          channel.sink.add('');
                        },
                        icon: const Icon(
                          Icons.remove,
                        )),
                  ),
                  SizedBox(
                    width: 21,
                    child: IconButton(
                        iconSize: 20,
                        onPressed: () {
                          channel.sink.add('');
                        },
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(
                          Icons.add,
                        )),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
