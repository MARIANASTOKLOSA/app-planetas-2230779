import 'package:myapp/%20models/planeta.dart';
import 'package:myapp/%20services/planeta_service.dart';


class PlanetaController {
  final PlanetaService _service = PlanetaService();

  Future<List<Planeta>> listarPlanetas() async {
    return await _service.listarPlanetas();
  }

  Future<void> adicionarPlaneta(
    String nome,
    double tamanho,
    double distancia,
    String? apelido,
  ) async {
    await _service.adicionarPlaneta(nome, tamanho, distancia, apelido);
  }

  Future<void> atualizarPlaneta(Planeta planeta) async {
    await _service.atualizarPlaneta(planeta);
  }

  Future<void> removerPlaneta(int id) async {
    await _service.removerPlaneta(id);
  }
}
