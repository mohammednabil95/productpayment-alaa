import 'package:http/http.dart' as http;

class BackendService {
  static Future<String> postToken(String token, String hostEmail) async {
    final responseBody = (await http.get(
        'realurlomitted/.../Meets/RegisterDevice?token=$token&hostEmail=$hostEmail')).body;
    print(" Response: " + responseBody.toString());

    return responseBody.toString();
  }
}