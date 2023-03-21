import 'package:flutter/material.dart';
import 'package:flutterwork/Screens/full_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  String title, description, image, author, publishedAt, url, content;
  DetailScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      required this.author,
      required this.publishedAt,
      required this.url,
      required this.content});

  @override
  State<DetailScreen> createState() => _DetailScreenState(
      title, description, image, author, publishedAt, url, content);
}

class _DetailScreenState extends State<DetailScreen> {
  String title, description, image, author, publishedAt, url, content;
  _DetailScreenState(this.title, this.description, this.image, this.author,
      this.publishedAt, this.url, this.content);

  Future<void> urlBroswer(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      throw "Your Browser does Not Support http";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInImage(
              width: MediaQuery.of(context).size.width,
              placeholder: NetworkImage(image),
              image: NetworkImage(image),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Text(title,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                child: SingleChildScrollView(
                  child: Text(description,
                      style: const TextStyle(
                          color: Color(0xFF575E67), fontSize: 16.0)),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 40),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(author),
                    Text(publishedAt),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 100 * 25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FullDetailScreen(
                                    title: title,
                                    description: description,
                                    images: image,
                                    content: content,
                                  )));
                          // urlBroswer(url);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Read More",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Icon(Icons.ads_click),
                                ],
                              )),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          urlBroswer(url);
         

        },
         child:Icon(Icons.web,color: Colors.white,),
         
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
