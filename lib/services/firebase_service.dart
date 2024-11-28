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
      .where('estado', isEqualTo: true)
      .get(); //obtenemos los productos cuyo estado sea true
  for (var doc in queryProductos.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final producto={
      "nombre": data['nombre'],
      "uid": doc.id,
      "precio": data['precio'],
      "stock": data['stock'],
      "descripcion": data['descripcion'],
      "seccion": data['seccion'],
    };
    productos.add(producto); //agregamos los productos a la lista
  }
  return productos;
}

//Guardar informacion
Future<void> saveProducto(
    String nombre, String descripcion, int precio, int stock) async {
  await db.collection('productos').add({
    'nombre': nombre,
    'descripcion': descripcion,
    'precio': precio,
    'stock': stock,
  });
}


//Actualizar informacion
Future<void> updateProducto(
  String id,
  String nuevoNombre,
  String nuevaDescripcion,
  int nuevoPrecio,
  int nuevoStock,
) async {
  await db.collection('productos').doc(id).set({
    'nombre': nuevoNombre,
    'descripcion': nuevaDescripcion,
    'precio': nuevoPrecio,
    'stock': nuevoStock,
  }, SetOptions(merge: true)); // merge asegura que otros campos no se borren
}

//Cambiar el estado de un producto a false
Future<void> deleteProducto(String id) async {
  await db.collection('productos').doc(id).set({
    'estado': false,
  }, SetOptions(merge: true));
}

