import 'package:flutter/material.dart';
import 'package:mp_crud/services/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de Productos'),
      ),
      body: FutureBuilder(
        future: getProductos(), // Se ejecuta y el resultado va al builder
        builder: (context, snapshot) {
          // La lista con los productos va al snapshot
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length, // Cantidad de productos
              itemBuilder: ((context, index) {
                final producto = snapshot.data?[index];
                return Dismissible(
                  key: Key(producto['uid']),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        producto['imagen_url'],
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      producto['nombre'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          producto['descripcion'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Precio: \$${producto['precio']}',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          'Stock: ${producto['stock']} unidades',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        '/edit',
                        arguments: {
                          "nombre": producto['nombre'],
                          "uid": producto['uid'],
                          "descripcion": producto['descripcion'],
                          "precio": producto['precio'],
                          "stock": producto['stock'],
                          "imagen_url": producto['imagen_url'],
                        },
                      );
                      setState(() {});
                    },
                  ),
                );
              }),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
