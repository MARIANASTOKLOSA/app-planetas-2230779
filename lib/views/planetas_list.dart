import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/%20models/planeta.dart';
import '../repositories/planeta_repository.dart';
import 'planeta_form.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final PlanetaRepository _repository = PlanetaRepository();
  List<Planeta> _planetas = [];

  @override
  void initState() {
    super.initState();
    _carregarPlanetas();
  }

  void _carregarPlanetas() async {
    final planetas = await _repository.listarPlanetas();
    setState(() {
      _planetas = planetas;
    });
    if (kDebugMode) {
      print("Planetas carregados: $_planetas");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Inicial')),
      body: _planetas.isEmpty
          ? const Center(child: Text('Nenhum planeta cadastrado.'))
          : ListView.builder(
              itemCount: _planetas.length,
              itemBuilder: (context, index) {
                final planeta = _planetas[index];
                return ListTile(
                  title: Text(planeta.nome),
                  subtitle: Text(planeta.apelido ?? "Sem Apelido"),
                  onTap: () {},
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TelaCadastro()),
          );
          if (resultado == true) {
            _carregarPlanetas();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
