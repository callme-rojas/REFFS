import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reffs_parking/garage.dart';
import 'package:reffs_parking/maps_screen.dart';

class RegisterGaragePage extends StatefulWidget {
  @override
  _RegisterGaragePageState createState() => _RegisterGaragePageState();
}

class _RegisterGaragePageState extends State<RegisterGaragePage> {
  final List<XFile> _imageFiles = [];
  List<Garage> garages = [];

  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController referencesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();

  late GoogleMapController _mapController;
  LatLng _initialCameraPosition = const LatLng(0, 0);
  LatLng _selectedLocation = const LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTRAR GARAJE'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: const TextStyle(color: Color.fromARGB(255, 176, 39, 39)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
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
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Ancho (cm)',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 176, 39, 39)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
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
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Largo (cm)',
                  labelStyle: const TextStyle(color: Color.fromARGB(255, 176, 39, 39)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                readOnly: true,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Ubicación',
                  labelStyle: const TextStyle(color: Color.fromARGB(255, 176, 39, 39)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.location_on, color: Colors.blue),
                    onPressed: () {
                      _navigateToMapScreen();
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: referencesController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Referencias',
                  labelStyle: const TextStyle(color: Color.fromARGB(255, 176, 39, 39)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 176, 39, 39)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _getImages,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 176, 39, 39),
                  minimumSize: const Size(100, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Añadir Fotos',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildImagePreview(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      garages.add(
                        Garage(
                          dimensions: Dimensions(
                            altura: double.parse(heightController.text),
                            ancho: double.parse(widthController.text),
                            largo: double.parse(lengthController.text),
                          ),
                          ubicacion: _locationController.text,
                          referencias: referencesController.text,
                        ),
                      );
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 176, 39, 39),
                  minimumSize: const Size(100, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Registrar Garaje',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: garages.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Garaje ${index + 1}'),
                    subtitle: Text(
                        'Dimensiones: ${garages[index].dimensions.toString()}, Ubicación: ${garages[index].ubicacion}, Referencias: ${garages[index].referencias}'),
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
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    setState(() {
      _imageFiles.clear();
      _imageFiles.addAll(pickedFiles);
    });
  }

  Widget _buildImagePreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final imageFile in _imageFiles)
          Image.file(
            File(imageFile.path),
            height: 100,
            fit: BoxFit.cover,
          ),
      ],
    );
  }

  Future<void> _navigateToMapScreen() async {
    final LatLng? selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapScreen(initialPosition: _initialCameraPosition),
      ),
    );
    if (selectedLocation != null) {
      setState(() {
        _selectedLocation = selectedLocation;
        _locationController.text = 'Lat: ${_selectedLocation.latitude}, Lng: ${_selectedLocation.longitude}';
      });
    }
  }
}


