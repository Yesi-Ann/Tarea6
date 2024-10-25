import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('This is the About Page.'),
            SizedBox(height: 10),
            CircleAvatar(
              backgroundImage: AssetImage('1.jpg'), // Cambia la ruta de tu imagen
              radius: 50,
            ),
            SizedBox(height: 10),
            Text('Yesica De Los Santos'),
            Text('yesicadls33@gmail.com'),
          ],
        ),
      ),
    );
  }
}
