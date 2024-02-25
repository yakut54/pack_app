import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class Player extends StatefulWidget {
  final AudioPlayer player;
  final Session session;
  final bool isFileExists;
  final String filePath;

  const Player({
    Key? key,
    required this.player,
    required this.session,
    required this.isFileExists,
    required this.filePath,
  }) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final List<IconData> _icons = [Icons.play_circle_fill, Icons.pause_circle_filled];
  Duration _duration = const Duration();
  Duration _position = const Duration();

  bool isPlaying = false;
  bool isRepeat = false;
  bool isShowZaglushka = true;

  void setFile() {
    if (widget.isFileExists) {
      widget.player.setSourceDeviceFile(widget.filePath);
    } else {
      widget.player.setSourceUrl(widget.session.track);
    }
  }

  @override
  void initState() {
    super.initState();
    setFile();

    widget.player.onDurationChanged.listen((Duration d) {
      setState(() {
        isShowZaglushka = false;
        _duration = d;
      });
    });

    widget.player.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });
  }

  Widget slider() {
    return Expanded(
      child: Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        },
      ),
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.player.seek(newDuration);
  }

  Widget btnStart(isShowZaglushka) {
    return isShowZaglushka
        ? const Icon(
            Icons.lock_clock,
            color: AppColors.btnColor,
            size: 80,
          )
        : IconButton(
            padding: const EdgeInsets.only(bottom: 10),
            onPressed: () {
              print(widget.isFileExists ? 'Запуск с файла' : 'Запуск с интернета');

              isPlaying
                  ? widget.player.pause()
                  : widget.player.play(
                      widget.isFileExists ? DeviceFileSource(widget.filePath) : UrlSource(widget.session.track),
                    );
              isPlaying = !isPlaying;
              widget.player.setPlaybackRate(1.0);
              setState(() {});
            },
            icon: Icon(_icons[isPlaying ? 1 : 0], size: 80, color: AppColors.btnColor),
          );
  }

  TextStyle _fontStyle() {
    return const TextStyle(fontSize: 19, fontFamily: FontFamily.regularFont);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          widget.player.stop();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isShowZaglushka
                      ? Text(
                          '...Loading',
                          style: _fontStyle(),
                        )
                      : Text(_position.toString().split('.')[0], style: _fontStyle()),
                  isShowZaglushka ? btnStart(isShowZaglushka) : btnStart(isShowZaglushka),
                  isShowZaglushka
                      ? Text('...Loading', style: _fontStyle())
                      : Text(_duration.toString().split('.')[0], style: _fontStyle())
                ],
              ),
            ),
            Row(
              children: [slider()],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
