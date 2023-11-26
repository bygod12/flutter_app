class Alimento {
  int id;
  String nome;
  double calorias;
  double carboidratos;
  double proteinas;
  double gorduras;
  double fibras;

  Alimento({
    required this.id,
    required this.nome,
    required this.calorias,
    required this.carboidratos,
    required this.proteinas,
    required this.gorduras,
    required this.fibras,
  });

  factory Alimento.fromJson(Map<String, dynamic> json) {

    return Alimento(
      id: json['id'],
      nome: json['nome'],
      calorias: json['calorias'],
      carboidratos: json['carboidratos'],
      proteinas: json['proteinas'],
      gorduras: json['gorduras'],
      fibras: json['fibras'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'calorias': calorias,
      'carboidratos': carboidratos,
      'proteina': proteinas,
      'gordura': gorduras,
      'fibras': fibras,
    };
  }
}
