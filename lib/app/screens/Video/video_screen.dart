import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class VideoScreen extends StatefulWidget {
  final Session session;
  final bool isFileExists;
  final String filePath;

  const VideoScreen({
    super.key,
    required this.session,
    required this.isFileExists,
    required this.filePath,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool isTrackImgExists = true;
  String trackImgPath = '';

  void toggleIsTrackImg() {
    FileApi().getFilePath(widget.session.trackImg).then((value) {
      trackImgPath = value;
      isTrackImgExists = FileApi.isFileExists(trackImgPath);

      if (!isTrackImgExists) {
        Dio dio = Dio();

        try {
          dio.download(
            widget.session.trackImg,
            trackImgPath,
          );
        } catch (e) {
          print('Произошла ошибка при загрузке файла: $e');
        }
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    toggleIsTrackImg();
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
              packTitle: widget.session.title.trim().replaceAll("\\n", "\n"),
              packSubtitle: widget.session.subtitle.trim().replaceAll("\\n", "\n"),
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
              child: Center(
                child: Column(
                  children: [
                    Text(
                      widget.session.title.trim().replaceAll("\\n", "\n"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: FontFamily.regularFont,
                        fontSize: 28,
                        height: 1.3,
                      ),
                    ),
                    VideoFile(
                      session: widget.session,
                      isFileExists: widget.isFileExists,
                      filePath: widget.filePath,
                      isTrackImgExists: isTrackImgExists,
                      trackImgPath: trackImgPath,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        )),
      ),
    );
  }
}
