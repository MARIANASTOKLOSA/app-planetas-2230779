import 'package:flutter/material.dart';
import 'package:myapp/%20models/planeta.dart';
import 'package:sqflite/sqflite.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Inicial')),
      body:
          _planetas.isEmpty
              ? const Center(child: Text('Nenhum planeta cadastrado.'))
              : ListView.builder(
                itemCount: _planetas.length,
                itemBuilder: (context, index) {
                  final planeta = _planetas[index];
                  return ListTile(
                    title: Text(planeta.nome),
                    subtitle: Text(planeta.apelido ?? "Sem Apelido"),
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

class PlanetaRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'planetas.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE planetas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            distancia_do_sol REAL NOT NULL,
            tamanho REAL NOT NULL,
            apelido TEXT
          )
        ''');
      },
    );
  }

  Future<int> inserirPlaneta(Planeta planeta) async {
    final db = await database;
    return await db.insert('planetas', planeta.toMap());
  }

  Future<List<Planeta>> listarPlanetas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('planetas');
    return List.generate(maps.length, (i) {
      return Planeta.fromMap(maps[i]);
    });
  }
  
  join(String s, String t) {}
}

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
