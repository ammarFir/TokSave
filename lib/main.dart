import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'services/api_service.dart';

void main() {
  runApp(const TokSaveApp());
}

class TokSaveApp extends StatelessWidget {
  const TokSaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TokSave',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff25f4ee),
          brightness: Brightness.dark
          ),
          scaffoldBackgroundColor: const Color(0xf121212),
          appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff1a1a1a),
          elevation: 0,
          centerTitle: false,
       ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
  class _HomeScreenState extends State<HomeScreen> {
    final TextEditingController urlController = TextEditingController();
    //bikin var urlController bertipe TextEditingController, yg isinya objek baru dari TextEditingController
    bool showPreview = false;

    //nyimpan data video dari Api 
    //Map yg bisa berisi apa saja dan boleh null
    Map<String, dynamic>? videoData;

    //fungsi bernama validateUrl ,menerima param bernama input bertipe String
    //String? : hasil fungsi / return boleh berupa String atau null
    String? validateUrl(String input) {

      //menyimpan hasil input
      //trim() : hapus spasi dibagian awal dan akhir
      final trimmed = input.trim();
      if (trimmed.isEmpty) {
        return input.isEmpty
        // ? bentuk singkat if else
        //jika kosong Maka Pesan pertama ,
            ? 'Masukkan link Tiktok terlebih dahulu'
            : 'Link tidak valid';
      }

      //membuat variable uri yg berisi hasil parsing teks dari trimmed
      //menjadi objek Uri , agar bagian url bisa  diperika
      //Uri.tryParse() akan mengembalikan null jika parsing gagal
      final uri = Uri.tryParse(trimmed);

      if (uri == null || !uri.host.contains('tiktok.com')) {
        return 'Link tidak valid';
      }
      return null;
    }

    String _formatDuration(dynamic duration) {
      if (duration == null || duration is! int) return '-';
      final minutes = duration ~/ 60;
      final seconds = duration % 60;
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text.rich(
            TextSpan(
            children: [
              TextSpan(
              text: 'Tok',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
          ) ,
          TextSpan (
            text: 'Save',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff25f4ee),
              fontSize: 20,
            ),
          ),
          ],
          ),
        ),

    

          actions: [
            IconButton(
              icon: const  Icon (Icons.refresh),
              onPressed: () {
                setState(() {
                  showPreview = false;
                  urlController.clear();
                });
              },
              ),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {}, 
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
          //body bisa di scroll
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                hintText: 'Tempel link TikTok di sini',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                         icon: const Icon(Icons.content_paste),
                         tooltip: 'Paste',
                         onPressed: () async {
                          final data = await Clipboard.getData('text/plain');
                          if (data?.text != null) {
                            setState(() {
                              urlController.text = data!.text!;
                            });
                          }
                        }
                      )
                    ),
                  ),

                  const SizedBox(height: 12),
SizedBox(
  width: double.infinity,
  height: 52,
  child: FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xff25f4ee),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      ),
    onPressed: () async {
      final error = validateUrl(urlController.text);
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        return;
      }


      //2. panggil api metadata
      final result = await ApiService.fetchMetadata(urlController.text);

      //3 cek hhhasilnya
      if (result == null || result['success'] != true) {
        if(!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal Mengambil Data')),

        );
      return;
      }

      

      setState(() {
        videoData = result['data'] as Map<String, dynamic>;
        showPreview = true;
      });
    },

    child: const Text('Download'),
  ),
),
      
              
            const SizedBox(height: 24),
              if (showPreview) ...[
              Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xff1e1e1e),
                border: Border.all(color: const Color(0xff25f4ee).withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      videoData?['thumbnail'] ?? '',
                      fit:  BoxFit.cover,
                      errorBuilder: (context, error, StackTrace) {
                        return const Center(
                          child: Text(
                            'Thumbnail tidak tersedia',
                            style: TextStyle(color: Colors.white38, fontSize: 12),
                          ),
                        );
                      }
                    )
                  ),

                  //const username
                  const SizedBox(height: 12),
                   Text(
                    videoData?['username'] ?? '-',
                    style: const TextStyle(
                      color: Color(0xff25f4ee),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    ),
                    
                    //const username
                  const SizedBox(height: 6),
                  Text(
                    videoData?['caption'] ?? '-',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Colors.white54),
                      const SizedBox(width: 4),
                      Text(
                        _formatDuration(videoData?['duration']),
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),

                  //tombol sd
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                        height: 44,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xff25f4ee),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('SD'),
                          ),
                        ),
                      ),

                      //tombol hd
                      const SizedBox(width: 10,),
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xff25f4ee),
                              side: const BorderSide(color: Color(0xff25f4ee),
                              width: 1.5,          
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('HD'),
                            ),
                          ) 
                        )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            const LinearProgressIndicator(value: 0.4),
            const SizedBox(height: 4),
            const Text('12.5 MB / 28.4 MB'),
            ],
          ],
        ),
      ),
        ),
      bottomNavigationBar: Container(
        height: 50,
        color: const Color(0xff1a1a1a),
        child: const Center(
          child: Text(
            'Banner AdMob',
            style: TextStyle(color: Colors.white24, fontSize: 12),
          ),
        ),
      ),
      );
    }
  }

  