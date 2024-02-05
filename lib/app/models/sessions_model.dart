import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final String title;
  final String subtitle;
  final String type;
  final String description;
  final String sessionImg;
  final String track;
  final String subscribe;

  const Session(
      {required this.title,
      required this.subtitle,
      required this.type,
      required this.description,
      required this.sessionImg,
      required this.track,
      required this.subscribe});

  // Convert a Session instance into a Map.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'type': type,
      'description': description,
      'sessionImg': sessionImg,
      'track': track,
      'subscribe': subscribe,
    };
  }

  @override
  List<Object?> get props => [title, subtitle, type, sessionImg, track, subscribe];
}
