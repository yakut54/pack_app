import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '/app/router/export.dart';

class Description extends StatefulWidget {
  final Session session;
  const Description({super.key, required this.session});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  Session get session => widget.session;
  bool isFileExists = true;
  String filePath = '';

  void toggleFileExists() async {
    filePath = await FileApi().getFilePath(session.track);

    print('3 isFileExists $isFileExists filePath $filePath');
    isFileExists = FileApi.isFileExists(filePath);
    print('4 isFileExists $isFileExists filePath $filePath');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    toggleFileExists();
    print('1 isFileExists $isFileExists filePath $filePath');
  }

  @override
  Widget build(BuildContext context) {
    print('2 isFileExists $isFileExists filePath $filePath');
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
              Text(
                isFileExists ? 'true' : 'false',
                style: const TextStyle(
                  fontSize: 26,
                ),
              ),
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
                        imgBlockWidget(session: session),
                        const SizedBox(height: 15),
                        contentBlockWidget(session: session),
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
                    isFileExists
                        ? const SizedBox()
                        : Positioned(
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
                                      print('5 isFileExists $isFileExists filePath $filePath');
                                      return PopupDialog(
                                        filePath: filePath,
                                        session: session,
                                      );
                                    },
                                  ).then((value) {
                                    toggleFileExists();
                                    print('6 isFileExists $isFileExists filePath $filePath');
                                  });
                                },
                                color: AppColors.mainColor,
                              ),
                            ),
                          )
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



  // bool fileExists = false;

  // late bool isNotVisible;
  // late String fileName;
  // late Box<dynamic> box;

  // void toggleFileExist() {
  //   setState(() {
  //     fileExists = true;
  //   });
  // }

  // void init() async {
  //   fileName = DownloadFile().getFileExt(widget.session.track); // name.ext
  //   Directory appDocDir = await appDocumentDir();
  //   String filePath = '${appDocDir.path}/$fileName';
  //   fileExists = DownloadFile().isFileExists(filePath);
  //   setState(() {});
  // }

  // void initHive() async {
  //   box = await HiveBoxVisible().getBox();

  //   setState(() {
  //     isNotVisible = box.get('isNotVisible', defaultValue: false);
  //     print('initHive init $isNotVisible setState after');
  //   });

  //   await box.close();
  // }

  // void toggleIsNotVisible(boolean) async {
  //   box = await HiveBoxVisible().getBox();

  //   print('Проверка связи!');
  //   isNotVisible = boolean;
  //   await box.put('isNotVisible', boolean);
  //   setState(() {});
  //   print('Проверка связи! isNotVisible $isNotVisible');

  //   await box.close();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   init();
  //   initHive();
  // }