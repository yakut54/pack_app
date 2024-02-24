// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pack_app/app/screens/Audio/audio_file.dart';
import '/app/imports/all_imports.dart';

class AudioScreen extends StatefulWidget {
  final Session session;
  final bool isFileExists;

  const AudioScreen({
    super.key,
    required this.session,
    required this.isFileExists,
  });

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final player = AudioPlayer();

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
                    FractionallySizedBox(
                      widthFactor: 0.4,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.session.sessionImg),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.session.title.trim().replaceAll("\\n", "\n"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: FontFamily.regularFont,
                        fontSize: 28,
                        height: 1.3,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 1.0,
                          color: Colors.white.withOpacity(0.8),
                          padding: const EdgeInsets.all(8.0),
                          child: Player(
                            player: player,
                            session: widget.session,
                            isFileExists: widget.isFileExists,
                          ),
                        )
                      ],
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
