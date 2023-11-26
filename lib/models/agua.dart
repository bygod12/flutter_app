class Agua {
  int idAgua;
  int user;
  double mil_agua;
  DateTime data;

  Agua({required this.idAgua, required this.user, required this.mil_agua, required this.data});

  factory Agua.fromJson(Map<String, dynamic> json) {
    return Agua(
      idAgua: json['idAgua'],
      user: json['user'],
      mil_agua: json['mil_agua'],
      data: DateTime.parse(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idAgua': idAgua,
      'user': user,
      'mil_agua': mil_agua,
      'data': data.toIso8601String(),
    };
  }
}
