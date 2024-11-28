import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: const Text('Material App Bar'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('productos')
            .where('estado', isEqualTo: true) // Solo productos activos
            .snapshots(), // Escucha en tiempo real
        builder: (context, snapshot) {
          // Manejo de errores o conexión inicial
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Datos de la colección
          final productos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index].data() as Map<String, dynamic>;

              return Dismissible(
                key: Key(productos[index].id),
                child: ListTile(
                  title: Text(
                    producto['nombre'] ?? 'Sin nombre',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Precio: \$${producto['precio'] ?? 0}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Stock: ${producto['stock'] ?? 0}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Sección: ${producto['seccion'] ?? 'Sin sección'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Descripción: ${producto['descripcion'] ?? 'Sin descripción'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      '/edit',
                      arguments: {
                        "uid": productos[index].id,
                        "nombre": producto['nombre'],
                        "precio": producto['precio'],
                        "stock": producto['stock'],
                        "descripcion": producto['descripcion'],
                        "seccion": producto['seccion'],
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
