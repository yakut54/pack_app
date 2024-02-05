import 'package:dio/dio.dart';
import '/app/router/export.dart';

class PackRepo implements APackRepo {
  @override
  Future<Pack> getPackWrapper() async {
    const String apiUrl = 'http://192.168.88.236/?id=2';

    final response = await Dio().get(apiUrl);

    final Map<String, dynamic> jsonData = response.data;

    if (response.statusCode == 200) {
      return getPack(jsonData);
    } else {
      throw Exception('Failed to load pack');
    }
  }

  @override
  Future<Pack> getPacksFromJson(dynamic data) async {
    final response = data;
    return getPack(response);
  }

  Pack getPack(Map<String, dynamic> jsonData) {
    // final Map<String, dynamic> jsonData = jsonDecode(response);
    final Map<String, dynamic> packWrapper = jsonData['packWrapper'];
    final List<dynamic> sessions = jsonData['sessionsList'];

    return Pack(
      title: packWrapper['title'],
      subtitle: packWrapper['subtitle'],
      backgroundImg: packWrapper['background_img'],
      sessions: sessions
          .map((session) => Session(
                type: session['type'],
                title: session['title'],
                subtitle: session['subtitle'],
                description: session['description'],
                sessionImg: session['session_img'],
                track: session['track'],
                subscribe: session['subscribe'],
              ))
          .toList(),
    );
  }
}
