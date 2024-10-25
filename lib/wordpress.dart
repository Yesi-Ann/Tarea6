import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LatestNewsPage extends StatefulWidget {
  const LatestNewsPage({super.key});

  @override
  _LatestNewsPageState createState() => _LatestNewsPageState();
}

class _LatestNewsPageState extends State<LatestNewsPage> {
  List<Map<String, String>> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLatestArticles();
  }

  Future<void> fetchLatestArticles() async {
    try {
      // Hacer la solicitud a la API de WordPress
      final response = await http.get(Uri.parse('https://www.houstonzoo.org/wp-json/wp/v2/posts'));

      if (response.statusCode == 200) {
        // Parsear el JSON de la respuesta
        List<dynamic> jsonResponse = jsonDecode(response.body);

        List<Map<String, String>> fetchedArticles = [];

        // Tomar solo las últimas 3 noticias
        for (var i = 0; i < 3; i++) {
          var article = jsonResponse[i];
          String title = article['title']['rendered'] ?? 'No Title';
          String excerpt = article['excerpt']['rendered'] ?? 'No Summary';
          String link = article['link'] ?? '';

          fetchedArticles.add({
            'title': title,
            'excerpt': excerpt.replaceAll(RegExp(r'<[^>]*>'), ''), // Eliminar etiquetas HTML del resumen
            'link': link
          });
        }

        setState(() {
          articles = fetchedArticles;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching articles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Últimas Noticias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mostrar el logo de la página (ejemplo: Houston Zoo)
            Image.network(
              'https://www.houstonzoo.org/wp-content/uploads/2021/08/Houston-Zoo-Logo.jpg',
              height: 100,
            ),
            const SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  articles[index]['title']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  articles[index]['excerpt']!,
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    final url = articles[index]['link']!;
                                    // Abre la noticia original en el navegador
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewPage(url: url),
                                      ),
                                    );
                                  },
                                  child: const Text('Visitar'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// Página para mostrar la noticia en un WebView
class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticia Original'),
      ),
      body: Center(
        child: Text('Aquí iría el WebView para mostrar el contenido de: $url'),
        // Para cargar la página real puedes usar un paquete como webview_flutter
      ),
    );
  }
}
