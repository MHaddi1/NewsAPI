import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Screens/detail_screen.dart';
import 'Screens/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => const MyHomePage(),
        
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _articles = [];
  dynamic url;
  String? title;
  String? description;

  @override
  void initState() {
    super.initState();
    fetchData();
   
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=YourAPI'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final articles = json['articles'];

      title = articles[0]['title'];
      description = articles[0]['description'];
      url = articles[0]['url'];
      String author = articles[0]['author'];
  
      // publishedAt = articles[0]['publishedAt'];



      print('Title: $title');
      print('Description: $description');

      setState(() {
        _articles = articles;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.05;
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Container(
        color: Colors.white,
        child: _articles.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index];

                  return Card(
                    elevation: 5.0,
                    shadowColor: Colors.blueAccent,
                    color: Colors.grey[100],
                    child: Container(
                      child: SingleChildScrollView(
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      title: article["title"]?.toString() ??
                                          "Loading....",
                                      description:
                                          article['description']?.toString() ??
                                              "Loadin.....",
                                      image: article['urlToImage']
                                              ?.toString() ??
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Blue_question_mark_icon.svg/2048px-Blue_question_mark_icon.svg.png',
                                      author: article['author']?.toString() ??
                                          "Unknown Person",
                                          publishedAt: article['publishedAt'],
                                        url: article['url'],
                                        content: article['content']?.toString()??"There is No For this News",
                                    )));
                          }),
                          child: Container(
                            child: Row(
                              children: [
                                FadeInImage(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    placeholder: const NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Blue_question_mark_icon.svg/2048px-Blue_question_mark_icon.svg.png'),
                                    image: NetworkImage(article['urlToImage']
                                            ?.toString() ??
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Blue_question_mark_icon.svg/2048px-Blue_question_mark_icon.svg.png')),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            article['title']?.toString() ??
                                                "Loading.....",
                                            style: TextStyle(
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            article['description']
                                                    ?.toString() ??
                                                'Loading......',
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
