import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '/app/imports/all_imports.dart';

class TextDescriptionWidget extends StatefulWidget {
  const TextDescriptionWidget({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  State<TextDescriptionWidget> createState() => _TextDescriptionWidgetState();
}

class _TextDescriptionWidgetState extends State<TextDescriptionWidget> {
  late Widget htmlDescription;
  late Widget htmlRecomendation;

  get recomendation =>
      '<strong>Рекомендации:</strong> ${widget.session.recomendation == '' ? '<br>Сеанс принимай в наушниках. <span style="color: red;">Это важно</span>.' : widget.session.recomendation}';

  initHtml() {
    htmlDescription = Html(
      data: widget.session.description,
      style: {
        'html': Style(
          fontSize: FontSize(20.0),
          color: Colors.black,
          fontFamily: FontFamily.regularFont,
        ),
        'strong': Style(
          fontWeight: FontWeight.bold,
          fontFamily: FontFamily.extraboldFont,
        ),
        'em': Style(
          fontStyle: FontStyle.italic,
          fontFamily: FontFamily.semiFont,
        ),
      },
    );

    htmlRecomendation = Html(
      data: recomendation,
      style: {
        'html': Style(
          fontSize: FontSize(20.0),
          color: Colors.black,
          fontFamily: FontFamily.regularFont,
        ),
        'em': Style(
          fontStyle: FontStyle.italic,
          fontFamily: FontFamily.semiFont,
        ),
        'span': Style(
          textDecoration: TextDecoration.underline,
        )
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHtml();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      color: Colors.white.withOpacity(0.8),
      padding: const EdgeInsets.all(0.0),
      child: Column(children: [
        htmlDescription,
        htmlRecomendation,
      ]),
    );
  }
}
