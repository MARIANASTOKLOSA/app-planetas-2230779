class Planeta {
  int? id;
  String nome;
  double distanciaDoSol; // Distância em UA (Unidades Astronômicas)
  double tamanho; // Tamanho em km
  String? apelido; // Opcional

  Planeta({
    this.id,
    required this.nome,
    required this.distanciaDoSol,
    required this.tamanho,
    this.apelido,
  });

  // Converter para Map (usado no SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'distancia_do_sol': distanciaDoSol,
      'tamanho': tamanho,
      'apelido': apelido,
    };
  }

  // Criar um objeto Planeta a partir do Map (SQLite)
  factory Planeta.fromMap(Map<String, dynamic> map) {
    return Planeta(
      id: map['id'],
      nome: map['nome'],
      distanciaDoSol: map['distancia_do_sol'],
      tamanho: map['tamanho'],
      apelido: map['apelido'],
    );
  }
}
