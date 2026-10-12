import 'package:flutter/material.dart';
//biar bisa pake widget kek Text, Container , AppBar dll

void main() {
  //main itu entry point
  runApp(const TokSaveApp());
  //fungsi runApp untuk nyalain app  
  //TokSaveApp wigdet rootnya 
}


  class TokSaveApp extends StatelessWidget {
    const TokSaveApp({super.key});

    @override 
    //fungsi build() : method wajib yg ngashh tau widget ini mau nampilin apa 
    Widget build(BuildContext context) {
    return MaterialApp (
      title: 'TokSave',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

  
class HomeScreen extends StatelessWidget {
  
  const HomeScreen({super.key});
  //constructor bernama HomeScreen 
  //menerima parameter bernama key
  //dan meneruskan key/parameter ke parent class / super
  @override
  //method dibawah ini menimpa method dari parent class
  Widget build(BuildContext context) {
    //Widget : tipe retuurn : method ini bakal mengembalikan sebuah widgert
    //nama fungsinya build dan berparameter context
    //
    // TODO: implement build
    return Scaffold(
      //scaffold : kerangka halaman (app baar + body)
      appBar: AppBar(
        title: const Text('TokSave'),
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),//kasih jarak 16px
        child: Column( //susun widget dari atas ke bawah
          crossAxisAlignment: CrossAxisAlignment.stretch,//anak2nya melebar penuh
          children: [

           TextField(
            decoration: InputDecoration(
              hintText: 'Tempel link Tiktok di sini',
              border: OutlineInputBorder(),
            ),
           ),

          const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                    onPressed: () {}, 
                    child: const Text('Paste')
                    ),
                    ),
     

            const SizedBox(width: 12),
            Expanded(child: OutlinedButton(
                    onPressed: () {}, 
                    child: const Text('Download'),
                    ),
                  ),
                ],
            ),


            const SizedBox(height: 24),
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
                const Text('Caption video Tiktok di sini....'),
                const SizedBox(height: 4),
                const Text('Durasi: 00:45'),
              ],
            ),
            )





              
             ],
            ),
          )
        );
  }
}


//main() → runApp → TokSaveApp → MaterialApp → HomeScreen → Scaffold
//├─ AppBar → Text 'TokSave'
//└─ body → Center → Text 'Home TokSave'