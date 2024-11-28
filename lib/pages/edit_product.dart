import 'package:flutter/material.dart';
import 'package:mp_crud/services/firebase_service.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  TextEditingController nombreController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nombreController.text = arguments['nombre'];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Agregar Producto'),
        ),
        body: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Ingrese modificación de nombre',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await updateProducto(nombreController.text, arguments['uid']).then((_) {
                    Navigator.pop(context);
                  });
                },
                child: const Text("Actualizar Producto")),
          ],
        ));
  }
}
