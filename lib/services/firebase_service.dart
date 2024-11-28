//aqui administramos toda la informacion de firebase
//aqui creamos las funciones de CRUD

//importaciones
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore db =
    FirebaseFirestore.instance; //creamos una instancia de firestore

//-----------------FUNCIONES DE CRUD-----------------
//Obtener informacion
Future<List> getProductos() async {
  // Función asincrónica para obtener productos
  List productos = [];
  QuerySnapshot queryProductos = await db.collection('productos').get(); // Obtenemos los productos

  for (var doc in queryProductos.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // Extraemos los datos necesarios con valores predeterminados para evitar nulos
    final producto = {
      "uid": doc.id, // ID único del documento
      "nombre": data['nombre'] ?? 'Sin nombre', // Nombre del producto
      "descripcion": data['descripcion'] ?? 'Sin descripción', // Descripción
      "precio": data['precio'] ?? 0.0, // Precio
      "stock": data['stock'] ?? 0, // Stock disponible
      "imagen_url": data['imagen_url'] ?? '', // URL de la imagen
    };
    productos.add(producto); // Agregamos el producto a la lista
  }

  return productos;
}



//Guardar informacion
Future<void> saveProducto(String nombre) async {
  await db.collection('productos').add({
    'nombre': nombre,
  });
}

//Actualizar informacion
Future<void> updateProducto(String nuevoNombre, String id) async {
  await db.collection('productos').doc(id).set({
    'nombre': nuevoNombre,
  });
}
