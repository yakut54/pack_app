import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  /* Определяем наличие файла */

  late String filePath; // path/audio.mp3

  void toggleFileExists() async {
    filePath = await DownloadFileApi().getFilePath(widget.session.track); // name.ext
    setState(() {});
    DownloadFileApi().isFileExists(filePath); // Проверяем наличие файла
  }

  /* Значение checkbox записываем в localstorage */

  late Box<dynamic> box; // Have box

  void initHive() async {
    DownloadFileApi desc = context.read<DownloadFileApi>();
    box = await HiveBoxVisible().getBox();
    desc.toggleIsNotVisible(box.get('isNotVisible', defaultValue: false));
    print('init have ${box.get('isNotVisible', defaultValue: false)}');
    setState(() {});
    await box.close();
  }

  bool a = true;
  @override
  void initState() {
    super.initState();
    toggleFileExists();
    initHive();
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
                    DescriptionContentWidget(session: session),
                    Positioned(
                      right: 10,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 17, 73, 3),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: const EdgeInsets.all(0.0),
                          iconSize: 50,
                          icon: const Icon(
                            Icons.download_for_offline_outlined,
                          ),
                          onPressed: () {
                            showDialog(
                              barrierDismissible: !context.read<DescriptionApi>().isLoading,
                              context: context,
                              builder: (context) {
                                return PopupDialog(session: session);
                              },
                            );
                          },
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    Text(
                      '${context.watch<DownloadFileApi>().fileExists}',
                      style: const TextStyle(fontSize: 34, color: AppColors.btnColor),
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
}

class DescriptionContentWidget extends StatelessWidget {
  const DescriptionContentWidget({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imgBlockWidget(session: session),
        const SizedBox(height: 15),
        contentBlockWidget(session: session),
        const SizedBox(height: 10),
        GradientButtonWidget(session: session),
      ],
    );
  }
}

class GradientButtonWidget extends StatelessWidget {
  const GradientButtonWidget({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DescriptionApi().getScreenWidgetBySessionType(session);
            },
          ),
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
    );
  }
}
