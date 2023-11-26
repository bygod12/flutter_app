import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserController {
  final String apiUrl = 'http://127.0.0.1:8000'; // Substitua pela sua URL base
  User? _loggedInUser; // Variável privada para armazenar o usuário logado
  SharedPreferences? prefsuser;

  static const String _userKey = 'user_key';

  // Armazenar o objeto User nas SharedPreferences
  Future<void> saveUser(User user) async {
    print('o usuario é o ');
    print(user.toJson());
    prefsuser = await SharedPreferences.getInstance();
    final userJson = json.encode(user.toJson());
    await prefsuser?.setString(_userKey, userJson);
  }

  // Recuperar o objeto User das SharedPreferences
  Future<User?> getUser() async {

    final userJson = prefsuser?.getString(_userKey);

    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap['user']); // Acesso ao objeto "user" dentro do JSON
    }

    return null; // Retorna null se o usuário não estiver armazenado nas SharedPreferences
  }

  // Remover o objeto User das SharedPreferences
  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await http.get(Uri.parse('$apiUrl/users'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Erro ao obter lista de usuários: ${response.statusCode}');
    }
  }

  Future<bool> verifyUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/users/verify'), // Rota para verificar as credenciais
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        // Credenciais válidas
        final Map<String, dynamic> data =
        json.decode(response.body);
        User user = User.fromJson(data);

        saveUser(user);
        _loggedInUser = user;
        return true;
      } else if (response.statusCode == 401) {
        // Credenciais inválidas
        return false;
      } else {
        // Outro status de resposta, pode tratar de acordo com suas necessidades
        print('Erro de status HTTP: ${response.statusCode}');
        print('Corpo da resposta HTTP: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Erro durante a verificação de usuário: $e');
      return false;
    }
  }

  Future<bool> registerUser(String nome, String email, String senha) async {
    print({
      'name': nome,
      'email': email,
      'password': senha,
    });
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/users'), // Rota para cadastrar usuário
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': nome,
          'email': email,
          'password': senha,
        }),
      );

      if (response.statusCode == 201) {
        // Usuário cadastrado com sucesso
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

  // Método para remover o usuário logado
  Future<bool> logoutUser() async {
    try {
      final user = _loggedInUser;
      if (user == null) {
        // Não há usuário logado, não há nada para remover
        return false;
      }

      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/api/users/${user.id}'), // Substitua pelo caminho correto da sua rota de exclusão
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Usuário removido com sucesso na API
        _loggedInUser = null; // Remova o usuário logado localmente
        return true;
      } else {
        // Trate outros códigos de resposta, se necessário
        return false;
      }
    } catch (e) {
      // Trate qualquer erro que possa ocorrer durante a remoção
      print('Erro durante a remoção do usuário: $e');
      return false;
    }
  }
  User? get loggedInUser => _loggedInUser; // Getter para acessar o usuário logado

}
