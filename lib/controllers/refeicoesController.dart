import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/models/refeicao.dart';

import '../models/alimento.dart';
import '../models/user.dart';

class RefeicaoController {
  final String apiUrl = 'http://127.0.0.1:8000'; // Substitua pela sua URL base
  List<Refeicao>? _refeicoes = []; // Variável privada para armazenar o usuário logado
  SharedPreferences? prefsRefeicao;

  static const String _refeicoesKey = 'Refeicao_key';

  // Armazenar o objeto refeicoes nas SharedPreferences
  Future<void> saveRefeicoes() async {
    try{
      List<Map<String,dynamic>> refeicoes = [];

      _refeicoes?.forEach((element) {
        refeicoes.add(element.toJson());
      });
      // Converter a lista de mapas em uma string JSON
      String refeicoesJson = jsonEncode(refeicoes);

      // Agora, refeicoesJson contém a representação JSON das refeições como uma string

      prefsRefeicao = await SharedPreferences.getInstance();

      await prefsRefeicao?.setString(_refeicoesKey, refeicoesJson);
    }catch (e) {
      print('Erro durante a requisicao das refeicões: $e');
    }
  }

  // Recuperar o objeto refeicoes das SharedPreferences
  Refeicao? getrefeicoes()  {

    final refeicoesJson = prefsRefeicao?.getString(_refeicoesKey);

    if (refeicoesJson != null) {
      final refeicoesMap = jsonDecode(refeicoesJson);
      final refeicao = Refeicao.fromJson(refeicoesMap['refeicoes']);
      print(refeicao);
      print(refeicoesMap);

      return refeicao; // Acesso ao objeto "refeicoes" dentro do JSON
    }

    return null; // Retorna null se o usuário não estiver armazenado nas SharedPreferences
  }

  // Remover o objeto refeicoes das SharedPreferences
  Future<void> removerefeicoes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefsRefeicao?.remove(_refeicoesKey);
  }

  Future<dynamic> getrefeicoess() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/refeicoes'), // Rota para verificar as credenciais
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // Transforma json em map
      final List<dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        // Transforma map em Refeições
        _refeicoes = lisMapToRefeicoes(data);
         saveRefeicoes();
        print(data);
        return _refeicoes;
      } else if (response.statusCode == 401) {
        // Credenciais inválidas
        return null;
      } else {
        // Outro status de resposta, pode tratar de acordo com suas necessidades
        print('Erro de status HTTP: ${response.statusCode}');
        print('Corpo da resposta HTTP: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro durante a requisicao das refeicões: $e');
      return false;
    }
  }



  Future<bool> registerRefeicoes(
      String nome,
      int users_id
      ) async {

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/refeicoes'), // Rota para cadastrar usuário
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "nome": nome,
          "users_id": users_id,
          "total_calorias": 0,
          "total_carboidratos": 0,
          "total_proteinas": 0,
          "total_gorduras": 0,
          "total_fibras": 0
        }),
      );

      print(response.statusCode);
      if (response.statusCode == 201) {
        // Usuário cadastrado com sucesso
        print('passou aqui');
        final Map<String, dynamic> data =
        json.decode(response.body);
        Refeicao refeicao = Refeicao.fromJson(data);
        print(refeicao);
        _refeicoes?.add(refeicao);
        print(_refeicoes);
        saveRefeicoes();
        print(prefsRefeicao?.getString(_refeicoesKey));

        // Credenciais válidas
        return true;
      } else {
        // Trate outros códigos de resposta, se necessário
        return false;
      }
    } catch (e) {
      // Trate qualquer erro que possa ocorrer durante o registro
      print('Erro durante o registro de usuário: $e');
      return false; // Retorno padrão em caso de erro
    }
  }

  Future<bool> atualizarRefeicoes(
      int id,
      String nome,
      int users_id,
      int total_calorias,
      int total_carboidratos,
      int total_proteinas,
      int total_gorduras,
      int total_fibras
      ) async {

    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/api/refeicoes/atualiza/11'), // Rota para cadastrar usuário
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "nome": nome,
          "users_id": users_id,
          "total_calorias": total_calorias,
          "total_carboidratos": total_carboidratos,
          "total_proteinas": total_proteinas,
          "total_gorduras": total_gorduras,
          "total_fibras": total_fibras
        }),
      );

       if (response.statusCode == 200) {
         // Usuário cadastrado com sucesso
         final Map<String, dynamic> data =
         json.decode(response.body);
         Refeicao refeicao = Refeicao.fromJson(data);
         print(refeicao);
         _refeicoes?.add(refeicao);
         print(_refeicoes);
         saveRefeicoes();
         print(prefsRefeicao?.getString(_refeicoesKey));

         // Credenciais válidas
         return true;
       } else {
         // Trate outros códigos de resposta, se necessário
         return false;
       }
    } catch (e) {
      // Trate qualquer erro que possa ocorrer durante o registro
      print('Erro durante o registro de usuário: $e');
      return false; // Retorno padrão em caso de erro
    }
  }

  Future<bool> alimentoOnRefeicoes(
      int alimento_id,
      Refeicao refeicao
      ) async {

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/alimento/refeicoes'), // Rota para cadastrar usuário
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "refeicaoId": refeicao.id,
          "alimentoId": alimento_id
        }),
      );

      print(response.statusCode);
      if (response.statusCode == 201) {
        getrefeicoess();
        return true;
      } else {
        // Trate outros códigos de resposta, se necessário
        return false;
      }
    } catch (e) {
      // Trate qualquer erro que possa ocorrer durante o registro
      print('Erro durante o registro de usuário: $e');
      return false; // Retorno padrão em caso de erro
    }
  }

  List<Refeicao>? lisMapToRefeicoes(List<dynamic> data){
    List<Refeicao> refeicoes = [];
    data.forEach((element) {
      Refeicao refeicao = Refeicao.fromJson(element);

      List<Alimento> alimentos = [];

      element['alimentos'].forEach((element){

        alimentos.add(Alimento.fromJson(element));
      });

      refeicao.alimentos = alimentos;

      refeicoes.add(refeicao);

    });
    return refeicoes;
  }


}
