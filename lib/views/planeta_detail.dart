import 'package:flutter/material.dart';
import 'package:myapp/%20models/planeta.dart';

class PlanetaDetail extends StatelessWidget {
  final Planeta planeta;

  const PlanetaDetail({super.key, required this.planeta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(planeta.nome)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${planeta.nome}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (planeta.apelido != null && planeta.apelido!.isNotEmpty)
              Text(
                'Apelido: ${planeta.apelido}',
                style: TextStyle(fontSize: 16),
              ),
            Text(
              'Distância do Sol: ${planeta.distanciaDoSol} UA',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Tamanho: ${planeta.tamanho} km',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
