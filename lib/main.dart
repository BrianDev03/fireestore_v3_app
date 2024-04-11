import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

    body: StreamBuilder(
  stream: FirebaseFirestore.instance.collection("todoclass").snapshots(),
  builder: (context, snapshot) {
    // Muestra "Cargando Datos..." si no hay datos disponibles
    if (!snapshot.hasData) return const Text('Cargando Datos...');
    
    // Construye una lista de elementos usando los datos de Firestore
    return ListView.builder(
      itemCount: snapshot.data?.docs.length, // Número de elementos en la lista
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.task_alt), // Icono del elemento
        title: Text('Numero de Tareas ${snapshot.data!.docs[index]['number']}'), // Título del elemento
        subtitle: Text(snapshot.data!.docs[index]['name']), // Subtítulo del elemento
      ),
    );
  },
),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Hola');
        },
        tooltip: 'Agragar nueva tarea',
        child: const Icon(Icons.add),
        
      ),
    );
  }
}
