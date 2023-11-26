import 'package:untitled1/models/user.dart';
import 'package:untitled1/models/alimento.dart';

class Refeicao {
  int id;
  User? user;
  String nome;
  DateTime created_at;
  int total_gorduras;
  int total_calorias;
  int total_carboidratos;
  int total_fibras;
  int total_proteinas;
  List<Alimento>? alimentos;

  Refeicao({
    required this.id,
    required this.nome,
    required this.created_at,
    required this.total_gorduras,
    required this.total_calorias,
    required this.total_carboidratos,
    required this.total_fibras,
    required this.total_proteinas,
  });

  factory Refeicao.fromJson(Map<String, dynamic> json) {

    return Refeicao(
      id: json['id'],
      nome: json['nome'],
      created_at: DateTime.parse(json['created_at']),
      total_gorduras: json['total_gorduras'],
      total_calorias: json['total_calorias'],
      total_carboidratos: json['total_carboidratos'],
      total_fibras: json['total_fibras'],
      total_proteinas: json['total_proteinas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'nome': nome,
      'data': created_at.toIso8601String(),
      'total_gordura': total_gorduras,
      'total_calorias': total_calorias,
      'total_carboidratos': total_carboidratos,
      'total_fibras': total_fibras,
      'total_proteinas': total_proteinas,
      'alimentos': alimentos
    };
  }
}
