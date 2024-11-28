import 'package:flutter/material.dart';
import 'package:mp_crud/services/firebase_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // Controladores para los campos
  TextEditingController nombreController = TextEditingController(text: '');
  TextEditingController descripcionController = TextEditingController(text: '');
  TextEditingController precioController = TextEditingController(text: '');
  TextEditingController stockController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo para el nombre
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Ingrese nombre del producto',
              ),
            ),
            const SizedBox(height: 16.0),

            // Campo para la descripción
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Ingrese descripción del producto',
              ),
            ),
            const SizedBox(height: 16.0),

            // Campo para el precio
            TextField(
              controller: precioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingrese precio del producto',
              ),
            ),
            const SizedBox(height: 16.0),

            // Campo para el stock
            TextField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingrese stock del producto',
              ),
            ),
            const SizedBox(height: 16.0),

            // Botón para guardar el producto
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Guardar la información en Firebase
                  await saveProducto(
                    nombreController.text,
                    descripcionController.text,
                    int.tryParse(precioController.text) ?? 0,
                    int.tryParse(stockController.text) ?? 0,
                  ).then((_) {
                    Navigator.pop(context);
                  });
                },
                child: const Text("Guardar Producto"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
