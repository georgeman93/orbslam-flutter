import 'package:flutter/material.dart';
import './controls.dart';
import './console.dart';
import './slam_map.dart';
import './frame_viewer.dart';
import './dashboard_header.dart';
import './infobar.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 195, 255, 204).withRed(100),
                const Color.fromARGB(255, 175, 255, 183)
              ]),
        ),
        child: Row(
          children: [
            // Expanded(flex: 1, child: SideBar()),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(flex: 1, child: DashboardHeader()),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Expanded(
                                flex: 4,
                                child: FrameViewer(),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Expanded(flex: 2, child: Controls()),
                                          Expanded(flex: 4, child: Console()),
                                        ],
                                      ),
                                    ),
                                    const Expanded(flex: 1, child: SlamMap()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(flex: 1, child: InfoBar()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

      // const Text(
      //             'Shi-Tomasi Corner Detection',
      //           )o
