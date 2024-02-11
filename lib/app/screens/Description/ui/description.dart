import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '/app/router/export.dart';

class Description extends StatefulWidget {
  final Session session;
  const Description({super.key, required this.session});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  Session get session => widget.session;
  bool fileExists = false;
  bool isBarrierDismissible = true;

  void toggleFileExist() {
    setState(() {
      fileExists = true;
    });
  }

  String getFileName(track) {
    RegExp regex = RegExp(r'\/([^\/]+)\.(mp3|mp4)$');
    Match? match = regex.firstMatch(track);

    if (match != null) {
      String fileName = match.group(1)!;
      return fileName;
    }

    return 'file_name';
  }

  String getFileExtantion(track) {
    RegExp regex = RegExp(r'\.([a-zA-Z0-9]+)$');
    Match? match = regex.firstMatch(track);

    if (match != null) {
      String extantion = match.group(1)!;
      return extantion;
    }

    return 'mp3';
  }

  String get fileName => '${getFileName(session.track)}.${getFileExtantion(session.track)}';

  void init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName';
    fileExists = isFileExists(filePath);
    setState(() {});
  }

  bool isFileExists(String filePath) {
    File file = File(filePath);
    return file.existsSync();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    print('description.dart fileExists >> $fileExists');

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(
                packTitle: session.title.trim().replaceAll("\\n", "\n"),
                packSubtitle: session.subtitle.trim().replaceAll("\\n", "\n"),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.96,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.47),
                      blurRadius: 4,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        _imgBlockWidget(session: session),
                        const SizedBox(height: 15),
                        _contentBlockWidget(session: session),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => _controllerRouteWidget()),
                            );
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 15,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                            elevation: MaterialStateProperty.all<double>(0),
                            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xffFF8700),
                                  Color(0xffF8C740),
                                  Color(0xffFF8700),
                                ],
                                stops: [0.0, 0.56, 1.04],
                                transform: GradientRotation(135 * 3.14 / 180),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(2, 2),
                                  blurRadius: 3,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 220),
                              alignment: Alignment.center,
                              child: const Text(
                                'НАЧАТЬ',
                                style: TextStyle(
                                  fontFamily: FontFamily.regularFont,
                                  fontSize: 24,
                                  letterSpacing: 6,
                                  height: 2,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!fileExists)
                      Positioned(
                        right: 10,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 2, 52, 99),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.all(0.0),
                            iconSize: 40,
                            icon: const Icon(
                              Icons.download_for_offline_outlined,
                            ),
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return PopupDialog(
                                    fileName: fileName,
                                    session: session,
                                    toggleParentFileExist: toggleFileExist,
                                  );
                                },
                              );
                            },
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _controllerRouteWidget() {
    if (session.type == 'audio') {
      return AudioScreen(session: session);
    } else {
      return VideoScreen(session: session);
    }
  }
}

class _imgBlockWidget extends StatelessWidget {
  const _imgBlockWidget({
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.47),
            blurRadius: 4,
            offset: const Offset(2, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.darkColor,
      ),
      child: Center(
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.7,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(session.sessionImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              session.subscribe.trim().replaceAll("\\n", "\n"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: FontFamily.regularFont,
                fontSize: 16,
                height: 1.3,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _contentBlockWidget extends StatelessWidget {
  const _contentBlockWidget({
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      color: Colors.white.withOpacity(0.8),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        session.description.trim().replaceAll("\\n", "\n"),
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20.0,
          fontFamily: FontFamily.regularFont,
        ),
      ),
    );
  }
}
