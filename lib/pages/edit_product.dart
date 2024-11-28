import 'package:flutter/material.dart';
import 'package:mp_crud/services/firebase_service.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  // Controladores para los campos
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // Inicializar los controladores con los datos existentes
    nombreController.text = arguments['nombre'] ?? '';
    precioController.text = (arguments['precio']?.toString()) ?? '0';
    stockController.text = (arguments['stock']?.toString()) ?? '0';
    descripcionController.text = arguments['descripcion'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre del producto',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: precioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Precio',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stock',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await updateProducto(
                  arguments['uid'],
                  nombreController.text,
                  descripcionController.text,
                  int.tryParse(precioController.text) ?? 0,
                  int.tryParse(stockController.text) ?? 0,
                ).then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Actualizar Producto"),
            ),
          ],
        ),
      ),
    );
  }
}
