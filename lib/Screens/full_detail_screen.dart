import 'package:flutter/material.dart';


class FullDetailScreen extends StatefulWidget {
  String title, description, images, content;
  FullDetailScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.images,
      required this.content});

  @override
  State<FullDetailScreen> createState() =>
      _FullDetailScreenState(title, description, images, content);
}

class _FullDetailScreenState extends State<FullDetailScreen> {
  String title, description, images, content;
  _FullDetailScreenState(
      this.title, this.description, this.images, this.content);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
FadeInImage(
              width: MediaQuery.of(context).size.width,
              placeholder: NetworkImage(images),
              image: NetworkImage(images),
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
                  Text(content)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
