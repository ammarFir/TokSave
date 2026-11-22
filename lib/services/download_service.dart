
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class DownloadService { 
  static const String baseUrl = 'http://localhost/toksave-api';

  //download video dari backend
  //return kalau berhasil
  static Future<bool> downloadVideo(
    String tiktokUrl,
    String quality,{
    int? duration,
    }
    ) async {
    try {
      //minta user pilih folder
 //download dari backend
      final url = Uri.parse(
        '$baseUrl/api/download.php?url=${Uri.encodeComponent(tiktokUrl)}&quality=$quality$duration=${duration ?? 0}',
        
      );
      final response = await http.get(url);

      if(response.statusCode != 200) {
      print('Status Code: ${response.statusCode}');
      print('Body: ${response.body}');
      return false;
      }

      final savedUri = await FilePicker.saveFile(
        dialogTitle: 'Simpan video',
        fileName: 'TokSave_${DateTime.now().millisecondsSinceEpoch}.mp4',
        bytes: response.bodyBytes,
        mimeType: 'video/mp4',
        );

        return savedUri != null;
    } catch (e) {
      print('Dwonload error: $e');
      return false;
    }
  }
}