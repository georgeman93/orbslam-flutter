import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoBar extends StatefulWidget {
  const InfoBar({Key? key}) : super(key: key);

  @override
  State<InfoBar> createState() => _InfoBarState();
}

class _InfoBarState extends State<InfoBar> {
  List<List<dynamic>> links = [
    [
      'keypoints vs descriptors',
      Uri.parse(
          'https://answers.opencv.org/question/37985/meaning-of-keypoints-and-descriptors/')
    ],
    [
      'live coding session',
      Uri.parse('https://www.youtube.com/watch?v=7Hlb8YX2-W8')
    ],
    ['orbslam paper', Uri.parse('https://arxiv.org/pdf/1502.00956.pdf')],
    [
      'harris corners',
      Uri.parse(
          'https://medium.com/data-breach/introduction-to-harris-corner-detector-32a88850b3f6')
    ],
    [
      'opencv orb intro',
      Uri.parse('https://docs.opencv.org/3.4/d1/d89/tutorial_py_orb.html')
    ],
    [
      'opencv orb class reference',
      Uri.parse('https://docs.opencv.org/3.4/db/d95/classcv_1_1ORB.html')
    ],
    [
      'the essential matrix',
      Uri.parse(
          'https://www.cs.cmu.edu/~16385/s17/Slides/12.2_Essential_Matrix.pdf')
    ],
    [
      'methodology comparison',
      Uri.parse(
          'https://etd.ohiolink.edu/apexprod/rws_etd/send_file/send?accession=ouhonors1461320700&disposition=inline')
    ],
    [
      'shi-tomasi corner detection in opencv',
      Uri.parse(
          'https://docs.opencv.org/3.4/d4/d8c/tutorial_py_shi_tomasi.html')
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      margin:
          const EdgeInsets.only(top: 12.5, left: 12.5, bottom: 50, right: 50),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Learning Links',
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Material(
                color: Theme.of(context).colorScheme.primary,
                child: ListView.separated(
                    itemCount: links.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        shape: ShapeBorder.lerp(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            1.0),
                        tileColor: Theme.of(context).colorScheme.secondary,
                        style: ListTileStyle.list,
                        title: Text(links[index][0]),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          launchUrl(links[index][1]);
                        },
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
