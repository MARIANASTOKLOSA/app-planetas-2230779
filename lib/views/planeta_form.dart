import 'package:flutter/material.dart';
import 'package:myapp/%20models/planeta.dart';
import '../repositories/planeta_repository.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _distanciaController = TextEditingController();
  final _tamanhoController = TextEditingController();
  final _apelidoController = TextEditingController();
  final PlanetaRepository _repository = PlanetaRepository();

  void _salvarPlaneta() async {
    if (_formKey.currentState!.validate()) {
      final novoPlaneta = Planeta(
        nome: _nomeController.text,
        distanciaDoSol: double.parse(_distanciaController.text),
        tamanho: double.parse(_tamanhoController.text),
        apelido:
            _apelidoController.text.isNotEmpty ? _apelidoController.text : null,
      );
      await _repository.inserirPlaneta(novoPlaneta);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Planeta salvo com sucesso"),
          duration: Duration(seconds: 2),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela de Cadastro')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Planeta'),
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return 'O nome deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _distanciaController,
                decoration: InputDecoration(labelText: 'Distância do Sol (UA)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Insira um número positivo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tamanhoController,
                decoration: InputDecoration(labelText: 'Tamanho (km)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Insira um número positivo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apelidoController,
                decoration: InputDecoration(labelText: 'Apelido (opcional)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _salvarPlaneta, child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}

//(Tela de Cadastro)
// Validações para nome, distância do sol e tamanho.
//-// Exibe mensagem "Planeta salvo com sucesso" por 2 segundos.
// lib/views/planeta_form.dart
