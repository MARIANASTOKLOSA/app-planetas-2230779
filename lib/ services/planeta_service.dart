import 'package:myapp/%20models/planeta.dart';
import '../repositories/planeta_repository.dart';

class PlanetaService {
  final PlanetaRepository _repository = PlanetaRepository();

  Future<List<Planeta>> listarPlanetas() async {
    return await _repository.listarPlanetas();
  }

  Future<void> adicionarPlaneta(
    String nome,
    double tamanho,
    double distancia,
    String? apelido,
  ) async {
    final planeta = Planeta(
      nome: nome,
      tamanho: tamanho,
      distanciaDoSol: distancia,
      apelido: apelido,
    );
    await _repository.inserirPlaneta(planeta);
  }

  Future<void> inserirPlaneta(Planeta planeta) async {
    await _repository.inserirPlaneta(planeta);
  }

  Future<void> atualizarPlaneta(Planeta planeta) async {
    await _repository.atualizarPlaneta(planeta);
  }

  Future<void> removerPlaneta(int id) async {
    await _repository.excluirPlaneta(id);
  }
}
