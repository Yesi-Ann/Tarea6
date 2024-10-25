import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenderPredictionPage extends StatefulWidget {
  const GenderPredictionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GenderPredictionPageState createState() => _GenderPredictionPageState();
}

class _GenderPredictionPageState extends State<GenderPredictionPage> {
  String _gender = '';
  Color _bgColor = Colors.white;

  void _predictGender(String name) async {
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _gender = data['gender'];
        _bgColor = (_gender == 'male') ? Colors.blue : Colors.pink;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
      ),
      body: Container(
        color: _bgColor,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Nombre'),
              onSubmitted: (value) {
                _predictGender(value);
              },
            ),
            SizedBox(height: 20),
            Text('Género: $_gender', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
