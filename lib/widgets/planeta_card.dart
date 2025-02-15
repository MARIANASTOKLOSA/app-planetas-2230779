import 'package:flutter/material.dart';
import 'package:myapp/%20models/planeta.dart';
import '../views/planeta_detail.dart';

class PlanetaCard extends StatelessWidget {
  final Planeta planeta;

  const PlanetaCard({super.key, required this.planeta});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Icon(Icons.public, size: 40),
        title: Text(
          planeta.nome,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Distância do Sol: ${planeta.distanciaDoSol} milhões de km',
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlanetaDetail(planeta: planeta),
            ),
          );
        },
      ),
    );
  }
}
