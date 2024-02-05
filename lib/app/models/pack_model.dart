import 'package:equatable/equatable.dart';
import './sessions_model.dart';

class Pack extends Equatable {
  final String title;
  final String subtitle;
  final String backgroundImg;
  final List<Session> sessions;

  const Pack({
    required this.title,
    required this.subtitle,
    required this.backgroundImg,
    required this.sessions,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'backgroundImg': backgroundImg,
      'sessions': sessions.map((session) => session.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [title, subtitle, backgroundImg, sessions];
}
