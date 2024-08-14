import 'dart:io';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchSupplementImage(String imageUrl) async {
  final url = Uri.parse(imageUrl);

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return {'statusCode': response.statusCode, 'imageUrl': imageUrl};
    } else {
      throw HttpException('Invalid statusCode: ${response.statusCode}', uri: url);
    }
  } catch (e) {
    return {'statusCode': 500, 'imageUrl': imageUrl};
  }
}
