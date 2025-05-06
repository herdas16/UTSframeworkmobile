import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Jogja',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Destination {
  final String name;
  final String location;
  final String imagePath;
  final String description;

  const Destination({
    required this.name,
    required this.location,
    required this.imagePath,
    required this.description,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  //bagian untuk data yang tampil
  final List<Destination> destinations = const [
    Destination(
      name: 'Malioboro',
      location: 'Yogyakarta, Indonesia',
      imagePath: 'images/malioboro.jpg',
      description:
          'Malioboro adalah jantung Kota Jogja. Tak heran bila banyak penginapan murah dekat Malioboro, meskipun sekarang banyak hotel berbintang.',
    ),
    Destination(
      name: 'Pantai Parangtritis',
      location: 'Yogyakarta, Indonesia',
      imagePath: 'images/parangtritis.png',
      description:
          'Pantai Parangtritis adalah salah satu pantai paling terkenal di Yogyakarta dengan ombak yang kuat dan legenda Nyi Roro Kidul.',
    ),
    Destination(
      name: 'Heha Sky View',
      location: 'Yogyakarta, Indonesia',
      imagePath: 'images/heha.jpg',
      description:
          'HeHa Sky View sangat populer dan bisa dijangkau dalam 30 menit saja dari Kota Jogja. HeHa Sky View berisi tempat selfie, food stall, dan resto. Tempatnya sangat instagramable, banyak spot foto keren dengan pemandangan langit dan Kota Jogja dari ketinggian',
    ),
    Destination(
      name: 'Obelix Sea View',
      location: 'Yogyakarta, Indonesia',
      imagePath: 'images/obelix.jpg',
      description:
          'Obelix Sea View mudah dijangkau dari Kota Jogja karena hanya terletak di timur Pantai Parangtritis. Ini adalah tempat terbaik untuk merayakan sunset di Jogja.',
    ),
  ];

  //bagian judul atas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wisata Jogja"), centerTitle: true),
      body: GridView.count(
        padding: const EdgeInsets.all(12),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
        children:
            destinations.map((destination) {
              return DestinationCard(destination: destination);
            }).toList(),
      ),
    );
  }
}

//membuat tampilan card di home
class DestinationCard extends StatelessWidget {
  final Destination destination;

  const DestinationCard({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              "assets/${destination.imagePath}",
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              destination.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              destination.location,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(destination: destination),
                  ),
                );
              },
              icon: const Icon(Icons.info_outline),
              label: const Text("Detail"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(36),
                textStyle: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//menampilkan detail dari kartu wisata
class DetailPage extends StatefulWidget {
  final Destination destination;

  const DetailPage({super.key, required this.destination});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> comments = [];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.destination;

    return Scaffold(
      appBar: AppBar(title: Text(d.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset(d.imagePath,width: 600, height: 200, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                d.imagePath,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(d.location, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text(d.description, textAlign: TextAlign.justify),
            const SizedBox(height: 16),
            //menampilkan gambar
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue.shade100),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              //menampilkankolom komentar
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: "Tulis komentar",
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final text = _commentController.text.trim();
                      if (text.isNotEmpty) {
                        setState(() {
                          comments.add(text);
                          _commentController.clear();
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (comments.isNotEmpty) ...[
              const Text(
                "Komentar:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...comments.map(
                (c) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(c),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
