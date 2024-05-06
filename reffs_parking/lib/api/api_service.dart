
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reffs_parking/objects/auto.dart';
import 'package:reffs_parking/objects/garaje.dart';
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
        'telefono': telefono, // Incluir el campo telefono en el cuerpo de la solicituD
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

  Future<http.Response> addAuto(
      int usuarioId, String placa, String modelo, String dimensiones) async {
    try {
      var url = '$baseUrl/autos/addAuto'; // URL para agregar un nuevo auto
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'usuarioId': usuarioId,
        'placa': placa,
        'modelo': modelo,
        'dimensiones': dimensiones,
      });

      print('Enviando solicitud HTTP para agregar auto...');

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      print('Solicitud para agregar auto completada con éxito.');

      // Retornar la respuesta HTTP
      return response;
    } catch (e) {
      print('Error en la solicitud para agregar auto:');
      print(e);
      // Retornar un código de estado de error
      return http.Response('Error en la solicitud para agregar auto', 500);
    }
  }

  Future<int> addGaraje(
      String direccion,
      String lat,
      String lng,
      String dimensiones,
      String caracteristicasAdicionales,
      String disponibilidad) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final usuarioId = prefs.getInt('userId');

      if (usuarioId == null) {
        // Manejar el caso donde usuarioId no está disponible
        print('Error: UsuarioId no encontrado en SharedPreferences.');
        return 404; // Código de error para usuario no encontrado
      }

      var url =
          '$baseUrl/garajes/addGaraje'; // URL para agregar un nuevo garaje
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'direccion': direccion,
        'lat': lat,
        'lng': lng,
        'dimensiones': dimensiones,
        'caracteristicasAdicionales': caracteristicasAdicionales,
        'disponibilidad': disponibilidad,
        'usuarioId': usuarioId,
      });

      print('Enviando solicitud HTTP para agregar garaje...');

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      print('Solicitud para agregar garaje completada con éxito.');

      if (response.statusCode == 201) {
        print('Código de estado 201 - Garaje agregado exitosamente:');
        // Puedes agregar lógica adicional aquí según sea necesario
      } else {
        print('Error en la respuesta al agregar garaje:');
        print('Código de estado: ${response.statusCode}');
        print('Mensaje: ${response.body}');
      }

      // Retornar el código de estado de la respuesta
      return response.statusCode;
    } catch (e) {
      print('Error en la solicitud para agregar garaje:');
      print(e);
      return 500; // Error genérico
    }
  }

  Future<List<Garaje>> getGarajesById(int id) async {
    try {
      var url =
          '$baseUrl/garajes/getGarajesById/$id'; // URL para obtener el garaje por ID
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;
        return jsonResponse.map((data) => Garaje.fromJson(data)).toList();
      } else {
        print('Error en la respuesta para obtener garaje por ID:');
        print('Código de estado: ${response.statusCode}');
        print('Mensaje: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error en la solicitud para obtener garaje por ID:');
      print(e);
      return [];
    }
  }

  Future<List<Garaje>> getGarajesDisponibles() async {
    try {
      var url =
          '$baseUrl/garajes/getGarajesDisponibles'; // URL para obtener el garaje por ID
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;
        return jsonResponse.map((data) => Garaje.fromJson(data)).toList();
      } else {
        print('Error en la respuesta para obtener garajes:');
        print('Código de estado: ${response.statusCode}');
        print('Mensaje: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error en la solicitud para obtener garajes:');
      print(e);
      return [];
    }
  }

  Future<void> setGarajeDisponible(int id) async {
    try {
      var url = '$baseUrl/garajes/setGarajeDisponible/$id';
      var response = await http.put(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Código de estado 200 - Garaje marcado como disponible.');
      } else {
        print('Error en la respuesta para marcar garaje como disponible:');
        print('Código de estado: ${response.statusCode}');
        print('Mensaje: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud para marcar garaje como disponible:');
      print(e);
    }
  }

  Future<void> setGarajeOcupado(int id) async {
    try {
      var url = '$baseUrl/garajes/setGarajeOcupado/$id';
      var response = await http.put(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Código de estado 200 - Garaje marcado como ocupado.');
      } else {
        print('Error en la respuesta para marcar garaje como ocupado:');
        print('Código de estado: ${response.statusCode}');
        print('Mensaje: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud para marcar garaje como ocupado:');
      print(e);
    }
  }

  Future<List<Auto>> getAutosById(int id) async {
    try {
      var url =
          '$baseUrl/autos/getAutosById/$id'; // URL para obtener el auto por ID
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;
        return jsonResponse.map((data) => Auto.fromJson(data)).toList();
      } else {
        print('Error en la respuesta para obtener auto por ID:');
        print('Código de estado: ${response.statusCode}');
        print('Mensaje: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error en la solicitud para obtener auto por ID:');
      print(e);
      return [];
    }
  }

  Future<int> createReservation(
    int fkIdGaraje,
    int fkIdAuto,
    String startTime,
    String endTime,
    List<String> horasDisponibles,
    double precio,
  ) async {
    try {
      var url = '$baseUrl/reservaciones/createReservacion';
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'fk_id_garaje': fkIdGaraje,
        'fk_id_auto': fkIdAuto,
        'start_time': startTime,
        'end_time': endTime,
        'horas_disponibles': horasDisponibles,
        'precio': precio,
      });

      print('Enviando solicitud HTTP para crear reservación...');

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      print('Solicitud de creación de reservación completada con éxito.');

      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        var reservationId = jsonResponse['id'] as int?;
        var message = jsonResponse['message'] as String?;

        if (reservationId != null) {
          print('ID de reservación creada: $reservationId');
        } else {
          print('Error: ID de reservación nulo en la respuesta JSON');
        }

        if (message != null) {
          print('Mensaje de la respuesta: $message');
        } else {
          print('Error: Mensaje nulo en la respuesta JSON');
        }

        // Puedes procesar más la respuesta según tus necesidades
      } else {
        print('Error en la respuesta para crear reservación:');
        print('Código de estado: ${response.statusCode}');
        print('Mensaje: ${response.body}');
      }

      return response.statusCode;
    } catch (e) {
      print('Error en la solicitud para crear reservación:');
      print(e);
      return 500; // Error genérico
    }
  }
}
