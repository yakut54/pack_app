import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '/app/imports/all_imports.dart';

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
    isFileExists = FileApi.isFileExists(filePath);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    toggleFileExists();
  }

  @override
  Widget build(BuildContext context) {
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
                        ImgBlockWidget(session: session),
                        const SizedBox(height: 15),
                        TextDescriptionWidget(session: session),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => _controllerRouteWidget(isFileExists)),
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
                            right: 0,
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
                                        filePath: filePath,
                                        session: session,
                                      );
                                    },
                                  ).then((value) {
                                    toggleFileExists();
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

  Widget _controllerRouteWidget(isFileExists) {
    if (session.type == 'audio') {
      return AudioScreen(session: session, isFileExists: isFileExists);
    } else {
      return VideoScreen(session: session, isFileExists: isFileExists);
    }
  }
}
