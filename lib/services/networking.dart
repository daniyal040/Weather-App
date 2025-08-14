import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      // Successfully got data
      return jsonDecode(response.body);
    } else {
      // Failed to get data
      print('Error: ${response.statusCode}');
      return null;
    }
  }
}
