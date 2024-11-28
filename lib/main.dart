import 'package:flutter/material.dart';

//importaciones de firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//importaciones de las paginas
import 'pages/home_page.dart';
import 'package:mp_crud/pages/add_product.dart';
import 'package:mp_crud/pages/update_product.dart';


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
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/add': (context) => const AddProductPage(),
        '/edit': (context) => const EditProductPage(),
      },
    );
  }
}


