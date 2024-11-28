import 'package:flutter/material.dart';
import 'package:mp_crud/services/firebase_service.dart';

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
                    itemCount: snapshot
                        .data?.length, //la cantidad de productos que hay
                    itemBuilder: ((context, index) {
                      return Dismissible(
                        key: Key(snapshot.data?[index]['uid']),
                        child: ListTile(
                            title: Text(snapshot.data?[index]['nombre'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Precio: \$${snapshot.data?[index]['precio'] as int}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Stock: ${snapshot.data?[index]['stock'] as int}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                // 'Stock: ${producto['stock']} unidades',
                                'Seccion: ${snapshot.data?[index]['seccion']}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Descripcion: ${snapshot.data?[index]['descripcion']}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                            onTap: (() async {
                              await Navigator.pushNamed(context, '/edit',
                                  arguments: {
                                    "nombre": snapshot.data?[index]['nombre'],
                                    "uid": snapshot.data?[index]['uid'],
                                  });
                                  setState(() {
                                    
                                  });
                            })),
                      );
                    }));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/add');
            setState(() {});
          }, 
          child: const Icon(Icons.add),
        ));
  }
}
