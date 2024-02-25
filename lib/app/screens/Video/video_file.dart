import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '/app/imports/all_imports.dart';

class VideoFile extends StatefulWidget {
  final Session session;
  final bool isFileExists;
  final String filePath;
  final bool isTrackImgExists;
  final String trackImgPath;

  const VideoFile({
    Key? key,
    required this.session,
    required this.isFileExists,
    required this.filePath,
    required this.isTrackImgExists,
    required this.trackImgPath,
  }) : super(key: key);

  @override
  State<VideoFile> createState() => _VideoFileState();
}

class _VideoFileState extends State<VideoFile> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    if (widget.isFileExists) {
      controller = VideoPlayerController.file(
        File(widget.filePath),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
    } else {
      controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.session.track),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
    }

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(6),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(controller),
                  _ControlsOverlay(
                    controller: controller,
                    session: widget.session,
                    isTrackImgExists: widget.isTrackImgExists,
                    trackImgPath: widget.trackImgPath,
                    isFileExists: widget.isFileExists,
                    filePath: widget.filePath,
                    videoController: controller,
                  ),
                  VideoProgressIndicator(controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({
    required this.controller,
    required this.session,
    required this.isTrackImgExists,
    required this.trackImgPath,
    required this.isFileExists,
    required this.filePath,
    required this.videoController,
  });

  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;
  final Session session;
  final bool isFileExists;
  final String filePath;
  final bool isTrackImgExists;
  final String trackImgPath;
  final VideoPlayerController videoController;

  dynamic getFileTrack() {
    if (isTrackImgExists) {
      return FileImage(File(trackImgPath));
    } else {
      return NetworkImage(session.trackImg);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(getFileTrack());

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: getFileTrack(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 70.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return [
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: ColoredBox(
                color: AppColors.playerColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text('${controller.value.playbackSpeed}x'),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.playerColor,
              child: IconButton(
                icon: const Icon(Icons.open_in_new),
                onPressed: () {
                  Navigator.push<_PlayerVideoAndPopPage>(
                    context,
                    MaterialPageRoute<_PlayerVideoAndPopPage>(
                      builder: (BuildContext context) => _PlayerVideoAndPopPage(
                        isFileExists: isFileExists,
                        filePath: filePath,
                        videoController: videoController,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlayerVideoAndPopPage extends StatefulWidget {
  final bool isFileExists;
  final String filePath;
  final VideoPlayerController videoController;

  const _PlayerVideoAndPopPage({
    required this.isFileExists,
    required this.filePath,
    required this.videoController,
  });

  @override
  _PlayerVideoAndPopPageState createState() => _PlayerVideoAndPopPageState();
}

class _PlayerVideoAndPopPageState extends State<_PlayerVideoAndPopPage> {
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    widget.videoController.addListener(() {
      if (startedPlaying && !widget.videoController.value.isPlaying) {
        if (mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> started() async {
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: FutureBuilder<bool>(
          future: started(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data ?? false) {
              return AspectRatio(
                aspectRatio: widget.videoController.value.aspectRatio,
                child: VideoPlayer(widget.videoController),
              );
            } else {
              return const Text('waiting for video to load');
            }
          },
        ),
      ),
    );
  }
}
