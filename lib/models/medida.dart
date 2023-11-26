class Medida {
  int idMedidas;
  int user;
  double valor;
  double descricao;
  DateTime date;

  Medida({required this.idMedidas, required this.user, required this.valor, required this.descricao, required this.date});

  factory Medida.fromJson(Map<String, dynamic> json) {
    return Medida(
      idMedidas: json['idMedidas'],
      user: json['user'],
      valor: json['valor'],
      descricao: json['descricao'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMedidas': idMedidas,
      'user': user,
      'valor': valor,
      'descricao': descricao,
      'date': date.toIso8601String(),
    };
  }
}
