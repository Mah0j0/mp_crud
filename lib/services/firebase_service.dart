//aqui administramos toda la informacion de firebase 
//aqui creamos las funciones de CRUD

//importaciones
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore db = FirebaseFirestore.instance; //creamos una instancia de firestore

//-----------------FUNCIONES DE CRUD-----------------
//Obtener informacion 
Future<List> getProductos() async { //funcion asincrona, o sea que se ejecuta en segundo plano
  List productos = [];
  CollectionReference collectionReference = db.collection('productos'); //referencia a la coleccion de productos
  QuerySnapshot queryProductos = await collectionReference.get(); //obtenemos los productos, TODOS LOS QUE HAYA
  queryProductos.docs.forEach((documento) { //recorremos los productos
    productos.add(documento.data()); //agregamos los productos a la lista que creamos arriba
  });
  return productos;
}