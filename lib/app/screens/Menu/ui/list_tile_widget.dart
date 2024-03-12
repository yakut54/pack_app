import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class ListTileWidget extends StatelessWidget {
  final double width;
  final Session session;

  late final String title;
  late final String subtitle;
  late final String type;

  ListTileWidget({
    super.key,
    required this.session,
    required this.width,
  }) {
    title = session.title.trim().replaceAll("\\n", "\n");
    subtitle = session.subtitle.trim().replaceAll("\\n", "\n");
    type = session.type;
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Description(session: session),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.4);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    BaseResponsiveSizing responsiveSizes = BaseResponsiveSizing(width);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      shadowColor: const Color.fromARGB(255, 153, 153, 153),
      child: ListTile(
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Description(session: session)),
          // );
          Navigator.of(context).push(_createRoute());
        },
      ),
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
