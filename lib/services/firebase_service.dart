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
  //funcion asincrona, o sea que se ejecuta en segundo plano
  List productos = [];
  QuerySnapshot queryProductos = await db
      .collection('productos')
      .get(); //obtenemos los productos, TODOS LOS QUE HAYA
  for (var doc in queryProductos.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final producto={
      "nombre": data['nombre'],
      "uid": doc.id
    };
    productos.add(producto); //agregamos los productos a la lista
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
