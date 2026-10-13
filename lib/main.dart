import 'package:flutter/material.dart';

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
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('TokSave'),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Tempel link TikTok di sini',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Paste'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
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
        ),
      ),
      );
    }
  }

  