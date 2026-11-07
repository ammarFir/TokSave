import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  //baseUrl : alamat backend
  static  const String baseUrl = 'http://localhost/toksave-api';

  //fungsi buat ambil metadat video dari backend
  static Future<Map<String , dynamic>?> fetchMetadata(String url)async {
    //kirim gget request ke endpoint , balikin Map atau null kalo gagal 
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/metadata.php?url=${Uri.encodeComponent(url)}'),

      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}