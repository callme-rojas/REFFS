import 'package:flutter/material.dart';
import 'package:reffs_parking/maps_screen.dart';
import 'package:reffs_parking/signup_page.dart';
import 'api/api_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService =
        ApiService(baseUrl: 'https://parkingsystem-hjcb.onrender.com'); // Crea una instancia de ApiService
    String email = '';
    String password = '';

    void _login() async {
      // Llama a la función de inicio de sesión del ApiService
      int statusCode = await apiService.login(email, password);
      if (statusCode == 200) {
        // Si el inicio de sesión es exitoso, redirige a la página CarRegisterPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapsScreen(
              initialLatitud: 0.0, // Valor predeterminado para latitud
              initialLongitud: 0.0, // Valor predeterminado para longitud
            ),
          ),
        );

      } else {
        // Maneja los casos de error de inicio de sesión según sea necesario
        print('Error en el inicio de sesión');
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(),
              _inputField((value) =>
                  email = value), // Actualiza el valor del correo electrónico
              _inputField((value) => password = value,
                  isPassword: true), // Actualiza el valor de la contraseña
              _forgotPassword(),
              _signup(context),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: const Color.fromARGB(255, 176, 39, 39),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  Widget _inputField(Function(String) onChanged, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: isPassword ? "Password" : "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor:
                  const Color.fromARGB(255, 176, 39, 39).withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(isPassword ? Icons.password : Icons.person)),
          obscureText: isPassword,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _forgotPassword() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Color.fromARGB(255, 176, 39, 39)),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            // Navegar a la página de registro cuando se presiona el botón
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  SignupPage()),
            );
          },
          child: const Text("Sign Up",
              style: TextStyle(color: Color.fromARGB(255, 176, 39, 39))),
        )
      ],
    );
  }
}
