import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final String title;
  final String subtitle;
  final String type;
  final String description;
  final String trackImg;
  final String sessionImg;
  final String track;
  final String subscribe;
  final String recomendation;

  const Session({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.description,
    required this.trackImg,
    required this.sessionImg,
    required this.track,
    required this.subscribe,
    required this.recomendation,
  });

  // Convert a Session instance into a Map.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'type': type,
      'description': description,
      'trackImg': trackImg,
      'sessionImg': sessionImg,
      'track': track,
      'subscribe': subscribe,
      'recomendation': recomendation,
    };
  }

  @override
  List<Object?> get props => [
        title,
        subtitle,
        type,
        trackImg,
        sessionImg,
        track,
        subscribe,
        recomendation,
      ];
}
