import 'package:flutter/material.dart';

class ToolBoxPage extends StatelessWidget {
  const ToolBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caja de Herramientas'),
      ),
      body: Center(
        child: Image.network('https://example.com/imagen-caja-de-herramientas.png'), // Usa una URL válida o un asset local
      ),
    );
  }
}
