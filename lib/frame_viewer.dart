import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:typed_data';

class FrameViewer extends StatefulWidget {
  const FrameViewer({Key? key}) : super(key: key);

  @override
  State<FrameViewer> createState() => _FrameViewerState();
}

class _FrameViewerState extends State<FrameViewer> {
  late WebSocketChannel channel;
  late Stream videoStream;
  @override
  void initState() {
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));
    videoStream = channel.stream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 12.5, top: 12.5),
      // padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.transparent, //const Color.fromARGB(255, 144, 251, 144),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.topCenter,
      child: StreamBuilder(
          stream: videoStream,
          builder: (context, socket) {
            if (socket.hasData) {
              return Expanded(
                child: Image.memory(
                  Uint8List.fromList(socket.data as Uint8List),
                  gaplessPlayback: true,
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          }),
    );
  }
}
