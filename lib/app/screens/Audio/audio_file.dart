import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pack_app/app/models/index.dart';
import 'package:pack_app/app/router/export.dart';

class Player extends StatefulWidget {
  final AudioPlayer player;
  final Session session;

  const Player({Key? key, required this.player, required this.session}) : super(key: key);

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

  @override
  void initState() {
    super.initState();

    widget.player.setSourceUrl(widget.session.track);

    widget.player.onDurationChanged.listen((Duration d) {
      setState(() {
        isShowZaglushka = false;
        _duration = d;
        print('_duration => $_duration');
      });
    });

    widget.player.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
        print('_position => $_position');
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
              isPlaying ? widget.player.pause() : widget.player.play(UrlSource(widget.session.track));
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
    return WillPopScope(
      onWillPop: () async {
        widget.player.stop();
        return true;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Expanded(child: Text(widget.session.track))],
            )
          ],
        ),
      ),
    );
  }
}
