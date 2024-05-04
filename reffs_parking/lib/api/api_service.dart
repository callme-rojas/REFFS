import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<int> login(String email, String password) async {
    try {
      var url = '$baseUrl/users/login';
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'email': email,
        'password': password,
      });

      print('Enviando solicitud HTTP para login...');

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      print('Solicitud de login completada con éxito.');

      if (response.statusCode == 200) {
        print('Código de estado 200 - Éxito en el login:');

        var jsonResponse = jsonDecode(response.body);
        var userId = jsonResponse['id'] as int?;
        var message = jsonResponse['message'] as String?;

        if (userId != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('userId', userId);
          print(
              'ID de usuario guardado en las preferencias compartidas: $userId');
        } else {
          print('Error: ID de usuario nulo en la respuesta JSON');
        }

        if (message != null) {
          print('Mensaje de la respuesta: $message');
        } else {
          print('Error: Mensaje nulo en la respuesta JSON');
        }

        // Aquí puedes procesar el cuerpo de la respuesta según necesites
      } else {
        print('Error en la respuesta para login:');
        print('Código de estado: ${response.statusCode}');
        print('Mensaje: ${response.body}');

        if (response.statusCode == 404) {
          // Credenciales inválidas
          print('Error en la respuesta: Credenciales inválidas');
          print('Respuesta del servidor: ${response.body}');
        }
      }

      // Retornar el código de estado de la respuesta
      return response.statusCode;
    } catch (e) {
      print('Error en la solicitud para login:');
      print(e);
      return 500; // Error genérico
    }
  }

  Future<int> register(
      String email, String password, String username, String telefono) async {
    try {
      var url = '$baseUrl/users/register'; // URL para el registro
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'email': email,
        'password': password,
        'nombre': username,
        'telefono': telefono, // Incluir el campo telefono en el cuerpo de la solicitud
      });

      print('Enviando solicitud HTTP para registro...');

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      print('Solicitud de registro completada con éxito.');

      if (response.statusCode == 201) {
        print('Código de estado 201 - Registro exitoso:');
        // Puedes agregar lógica adicional aquí según sea necesario
      } else {
        print('Error en la respuesta para registro:');
        print('Código de estado: ${response.statusCode}');
        print('Mensaje: ${response.body}');
      }

      // Retornar el código de estado de la respuesta
      return response.statusCode;
    } catch (e) {
      print('Error en la solicitud para registro:');
      print(e);
      return 500; // Error genérico
    }
  }
}
