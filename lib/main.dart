import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const ComicVerseApp());
}

class ComicVerseApp extends StatelessWidget {
  const ComicVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ComicVerse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ComicPage(),
    );
  }
}

class ComicPage extends StatefulWidget {
  const ComicPage({super.key});

  @override
  State<ComicPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  final PageController _controller = PageController();
  late Timer _timer;
  int currentPage = 0;

  final List<Map<String, dynamic>> comics = [
    {
      "title": "Sword Reign",
      "image":
          "https://raw.githubusercontent.com/Eliziel-Camperos/imagesGOD/refs/heads/main/comics.jpg",
      "rating": 4.5,
      "description":
          "Un guerrero maldito despierta en un mundo sin memoria... y sin límites.",
    },
    {
      "title": "Dark Pulse",
      "image":
          "https://raw.githubusercontent.com/Eliziel-Camperos/imagesGOD/refs/heads/main/comics1.jpg",
      "rating": 4.7,
      "description":
          "La oscuridad no solo consume... también obedece. Descubre el poder del pulso negro.",
    },
    {
      "title": "Chrome Angels",
      "image":
          "https://raw.githubusercontent.com/Eliziel-Camperos/imagesGOD/refs/heads/main/comics2.jpg",
      "rating": 4.3,
      "description":
          "Ángeles cibernéticos luchan en las ruinas del mañana. ¿Quién salvará la ciudad?",
    },
    {
      "title": "Mythos X",
      "image":
          "https://raw.githubusercontent.com/Eliziel-Camperos/imagesGOD/refs/heads/main/comics3.jpg",
      "rating": 4.8,
      "description":
          "Los dioses antiguos vuelven a caminar entre nosotros… y esta vez, no vienen en paz.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      int nextPage = (currentPage + 1) % comics.length;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: comics.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final comic = comics[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                comic['image'],
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 60,
                right: 20,
                child: Text(
                  "${index + 1}/${comics.length}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 120,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comic['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const Icon(Icons.star_half,
                            color: Colors.amber, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          "${comic['rating']} (1.2k)",
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      comic['description'],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // Acción al presionar "LEER MÁS"
                      },
                      child: const Text(
                        "LEER MÁS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
