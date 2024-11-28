import 'package:flutter/material.dart';
import 'package:mp_crud/services/firebase_service.dart';

class AddProductPage extends StatefulWidget{
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage>{
  TextEditingController nombreController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: Column(
        children: [
           TextField(
            controller: nombreController,
            decoration: const InputDecoration(
              labelText: 'Ingrese nombre del producto',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await saveProducto(nombreController.text).then((_){
                Navigator.pop(context);
              });
            }, 
            child: const Text("Guardar Producto")
            ),
        ],
      )
    );
  }
}