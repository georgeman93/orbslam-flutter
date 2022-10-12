import 'dart:typed_data';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

/// General layout of the dashboard.
/// In the middle is an image display to get each frame from the camera.
/// below it will be a row of buttons to play/pause, restart and maybe change some aspects of what the slam server is doing
///
/// It would be nice if there was a fancy border and a stylized heading for the dashboard

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('ORBSLAM Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: videoStream,
                builder: (context, socket) {
                  if (socket.hasData) {
                    return Image.memory(
                      Uint8List.fromList(socket.data as Uint8List),
                      gaplessPlayback: true,
                    );
                  } else {
                    return const Text('No data');
                  }
                }),
            const Text(
              'Shi-Tomasi Corner Detection',
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    channel.sink.add('play');
                  },
                  child: const Text('Play'),
                ),
                ElevatedButton(
                  onPressed: () {
                    channel.sink.add('pause');
                  },
                  child: const Text('Pause'),
                ),
                ElevatedButton(
                  onPressed: () {
                    channel.sink.add('restart');
                  },
                  child: const Text('Restart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
