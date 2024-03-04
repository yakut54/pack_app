import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pack_app/app/widgets/button.dart';
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
  bool isSessionImgExists = true;
  String filePath = '';
  String sessionImgPath = '';

  void toggleFileExists() async {
    filePath = await FileApi().getFilePath(session.track);
    isFileExists = FileApi.isFileExists(filePath);
    setState(() {});
  }

  void toggleIsSessionImg() {
    FileApi().getFilePath(session.sessionImg).then((value) {
      sessionImgPath = value;
      isSessionImgExists = FileApi.isFileExists(sessionImgPath);

      if (!isSessionImgExists) {
        Dio dio = Dio();

        try {
          dio.download(
            session.sessionImg,
            sessionImgPath,
          );
        } catch (e) {
          print('Произошла ошибка при загрузке файла: $e');
        }
      }
      setState(() {});
    });
  }

  Future<List<File>> getDownloadedFiles() async {
    Directory directory = await appDocumentDir();

    List<File> files = directory
        .listSync(
          recursive: true,
          followLinks: false,
        )
        .where((file) =>
            file.path.endsWith('.mp3') ||
            file.path.endsWith('.mp4') ||
            file.path.endsWith('.png') ||
            file.path.endsWith('.jpg') ||
            file.path.endsWith('.jpeg'))
        .map((file) => File(file.path))
        .toList();

    return files;
  }

  @override
  void initState() {
    super.initState();
    toggleFileExists();
    toggleIsSessionImg();
    getDownloadedFiles().then((value) => print(value));
    setState(() {});
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
                        ImgBlockWidget(
                          session: session,
                          sessionImgPath: sessionImgPath,
                          isSessionImgExists: isSessionImgExists,
                        ),
                        const SizedBox(height: 15),
                        TextDescriptionWidget(session: session),
                        const SizedBox(height: 10),
                        YButton(
                          title: 'НАЧАТЬ',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => _controllerRouteWidget()),
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backButtonColor,
        onPressed: () => Navigator.pop(context),
        child: const Icon(
          color: AppColors.headerTitleColor,
          size: 50,
          Icons.keyboard_arrow_left,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget _controllerRouteWidget() {
    if (session.type == 'audio') {
      return AudioScreen(
        session: session,
        filePath: filePath,
      );
    } else {
      return VideoScreen(
        session: session,
        filePath: filePath,
      );
    }
  }
}
