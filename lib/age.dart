import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgePredictionPage extends StatefulWidget {
  const AgePredictionPage({super.key});

  @override
  _AgePredictionPageState createState() => _AgePredictionPageState();
}

class _AgePredictionPageState extends State<AgePredictionPage> {
  String _ageMessage = '';
  int _age = 0;

  void _predictAge(String name) async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _age = data['age'];
        if (_age < 18) {
          _ageMessage = 'Eres joven';
        } else if (_age < 60) {
          _ageMessage = 'Eres adulto';
        } else {
          _ageMessage = 'Eres anciano';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predicción de Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Nombre'),
              onSubmitted: (value) {
                _predictAge(value);
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Edad: $_age',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              _ageMessage,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
