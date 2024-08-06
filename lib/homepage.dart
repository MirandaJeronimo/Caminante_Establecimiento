import 'package:caminante_establecimiento_firebase2/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

/*class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder(
          future: getPeople(),
          builder: ((context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index){
              return Text(snapshot.data?[index]['nombre']);
              },
              );
            }
            else{
               return const Center(
                 child: CircularProgressIndicator(),
               );
            }

          })),
      );
  }
}*/

class HomePage extends StatelessWidget{
const HomePage({super.key});

@override

Widget build(BuildContext context){
    return MaterialApp(
        title: 'Material App',
          home: Scaffold(
            appBar: AppBar(
              title: const Text('material app bar'),
            ),
            body: FutureBuilder(
              future: getPeople(),
              builder:((context, snapshot){
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){
                      return Text(snapshot.data?[index]['nombre']);
                    },
                  );
                 })),//builder
          ),
    );
    }

}
