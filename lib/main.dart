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
                color: const Color(0xff1e1e1e),
                border: Border.all(color: const Color(0xff25f4ee).withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      color:  const Color(0xff2a2a2a),
                      child: const Center(
                        child: Icon(
                          Icons.icecream_outlined,
                          color: Colors.white24,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '@username',
                    style: TextStyle(
                      color: Color(0xff25f4ee),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    ),
                  const SizedBox(height: 6),
                  const Text(
                    'Caption video TikTok di sini...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(Icons.access_time, size: 14, color: Colors.white54),
                      SizedBox(width: 4,),
                      Text(
                        '00:45',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
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
      );
    }
  }

  