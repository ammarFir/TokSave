import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('TokSave'),
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
        
        body: Padding(
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
  child: FilledButton(
    onPressed: () {
      final error = validateUrl(urlController.text);
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        return;
      }
      setState(() {
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
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text('Thumbnail'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('@username'),
                  const SizedBox(height: 4),
                  const Text('Caption video TikTok di sini...'),
                  const SizedBox(height: 4),
                  const Text('Durasi: 00:45'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          child: const Text('Download SD'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          child: const Text('Download HD'),
                        ),
                      ),
                    ],
                  ),
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
      );
    }
  }

  