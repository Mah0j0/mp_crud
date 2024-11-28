import 'package:flutter/material.dart';

//importaciones de firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//importaciones de servicios
import 'package:mp_crud/services/firebase_service.dart';

//hola mundo en dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

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
        body: FutureBuilder(
            future: getProductos(), //se ejecuta y el resultado va al builder
            builder: (context, snapshot) {
              //la lista con los productos van al snapshot
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount:
                      snapshot.data?.length, //la cantidad de productos que hay
                  itemBuilder: (context, index) {
                    return Text(snapshot.data?[index]
                        ['nombre']); //mostramos el nombre del producto
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }) //porque nuestra funcion de servicios es un future
        );
  }
}
