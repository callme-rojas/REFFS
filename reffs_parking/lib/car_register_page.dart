import 'package:flutter/material.dart';
import 'package:reffs_parking/car.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class RegisterCarPage extends StatefulWidget {
  @override
  _RegisterCarPageState createState() => _RegisterCarPageState();
}

class _RegisterCarPageState extends State<RegisterCarPage> {
  List<Car> cars = [];
  final List<XFile> _imageFiles = []; // Declarar la variable _imageFiles aquí

  final TextEditingController modeloController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController nroplacaController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();

  int selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AÑADIR AUTO'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                style: const TextStyle(
                    color: Colors.black), // Aplicar color al texto
                decoration: InputDecoration(
                  labelText: 'Color',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 176, 39,
                          39)), // Aplicar color al texto del label
                  enabledBorder: OutlineInputBorder(
                    // Aplicar color al borde cuando está habilitado
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    // Aplicar color al borde cuando está enfocado
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                style: const TextStyle(
                    color: Colors.black), // Aplicar color al texto
                decoration: InputDecoration(
                  labelText: 'Modelo',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 176, 39,
                          39)), // Aplicar color al texto del label
                  enabledBorder: OutlineInputBorder(
                    // Aplicar color al borde cuando está habilitado
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    // Aplicar color al borde cuando está enfocado
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Text('Año:'),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _selectYear(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 176, 39, 39),
                      ),
                    ),
                    child: Text(
                      selectedYear.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                style: const TextStyle(
                    color: Colors.black), // Aplicar color al texto
                decoration: InputDecoration(
                  labelText: 'Numero de Placa',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 176, 39,
                          39)), // Aplicar color al texto del label
                  enabledBorder: OutlineInputBorder(
                    // Aplicar color al borde cuando está habilitado
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    // Aplicar color al borde cuando está enfocado
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                style: const TextStyle(
                    color: Colors.black), // Aplicar color al texto
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 176, 39,
                          39)), // Aplicar color al texto del label
                  enabledBorder: OutlineInputBorder(
                    // Aplicar color al borde cuando está habilitado
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    // Aplicar color al borde cuando está enfocado
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                style: const TextStyle(
                    color: Colors.black), // Aplicar color al texto
                decoration: const InputDecoration(
                  labelText: 'Ancho (cm)',
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 176, 39,
                          39)), // Aplicar color al texto del label
                  enabledBorder: OutlineInputBorder(
                    // Aplicar color al borde cuando está habilitado
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Aplicar color al borde cuando está enfocado
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                style: const TextStyle(
                    color: Colors.black), // Aplicar color al texto
                decoration: InputDecoration(
                  labelText: 'Largo (cm)',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 176, 39,
                          39)), // Aplicar color al texto del label
                  enabledBorder: OutlineInputBorder(
                    // Aplicar color al borde cuando está habilitado
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    // Aplicar color al borde cuando está enfocado
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _getImages,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: const Color.fromARGB(255, 176, 39, 39), // Color del texto del botón
                ),
                child: const Text('Seleccionar fotos'),
              ),

              const SizedBox(height: 16),
              // Mostrar las imágenes seleccionadas
              _buildImagePreview(),             
              
               const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    cars.add(
                      Car(
                        color: colorController.text,
                        modelo: modeloController.text,
                        anio: selectedYear,
                        nroplaca: nroplacaController.text,
                        dimensions: Dimensions(
                          altura: double.parse(heightController.text),
                          ancho: double.parse(widthController.text),
                          largo: double.parse(lengthController.text),
                        ),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 176, 39, 39), // Color de fondo del botón
                  minimumSize: const Size(
                      100, 50), // Tamaño mínimo del botón (ancho x alto)
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8), // Espaciado interno
                  shape: RoundedRectangleBorder(
                    // Forma del botón
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Añadir Auto',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white, // Color del texto
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: cars.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Car ${index + 1}'),
                    subtitle: Text(
                        'Color: ${cars[index].color}, Modelo: ${cars[index].modelo}, Anio: ${cars[index].anio}, Nro Placa: ${cars[index].nroplaca}, Dimensions: ${cars[index].dimensions.toString()}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImages() async {
    final picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _imageFiles.clear();
        _imageFiles.addAll(pickedFiles);
      });
    } else {
      print('No images selected.');
    }
  }



  Widget _buildImagePreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final imageFile in _imageFiles)
          Image.file(
            imageFile as File,
            height: 100,
            fit: BoxFit.cover,
          ),
      ],
    );
  }

  Future<void> _selectYear(BuildContext context) async {
    // ignore: unused_local_variable
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: Theme(
              data: ThemeData(
                colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(255, 176, 39, 39),
                ),
              ),
              child: YearPicker(
                selectedDate: DateTime(selectedYear),
                onChanged: (DateTime dateTime) {
                  setState(() {
                    selectedYear = dateTime.year;
                  });
                  Navigator.pop(context);
                },
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ),
            ),
          ),
        );
      },
    );
  }
}
