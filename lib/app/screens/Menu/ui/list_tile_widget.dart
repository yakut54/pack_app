import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class ListTileWidget extends StatelessWidget {
  final int index;
  final double width;
  final List<Session> sessions;

  late final String title;
  late final String subtitle;
  late final String type;

  ListTileWidget({
    super.key,
    required this.sessions,
    required this.width,
    required this.index,
  }) {
    title = sessions[index].title.trim().replaceAll("\\n", "\n");
    subtitle = sessions[index].subtitle.trim().replaceAll("\\n", "\n");
    type = sessions[index].type;
  }

  @override
  Widget build(BuildContext context) {
    BaseResponsiveSizing responsiveSizes = BaseResponsiveSizing(width);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      leading: SizedBox(
        width: 50,
        child: Image.asset(
          'assets/images/__${type}__.png',
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
      ),
      title: _TitleWidget(
        title: title,
        responsiveSizes: responsiveSizes,
      ),
      subtitle: _SubtitleWidget(
        subtitle: subtitle,
        responsiveSizes: responsiveSizes,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Description(session: sessions[index])),
        );
      },
    );
  }
}

class _TitleWidget extends StatelessWidget {
  final String title;
  final BaseResponsiveSizing responsiveSizes;

  const _TitleWidget({required this.title, required this.responsiveSizes});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: FontFamily.semiFont,
        fontSize: responsiveSizes.fontSizeTileLarge,
        height: 1.4,
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}

class _SubtitleWidget extends StatelessWidget {
  final String subtitle;
  final BaseResponsiveSizing responsiveSizes;

  const _SubtitleWidget({
    required this.subtitle,
    required this.responsiveSizes,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: TextStyle(
        fontFamily: FontFamily.regularFont,
        fontSize: responsiveSizes.fontSizeTileMedium,
        height: 1.2,
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
