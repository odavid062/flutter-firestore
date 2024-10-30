import 'package:firebase_core/firebase_core.dart'; // Importa a biblioteca Firebase Core para inicializar o Firebase
import 'package:flutter/material.dart'; // Importa a biblioteca Flutter Material para construção da interface

import 'cadastro_page.dart'; // Importa o arquivo da tela de cadastro
import 'firebase_options.dart'; // Importa as configurações do Firebase, geradas automaticamente pelo comando flutterfire configure

// Função principal do aplicativo
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Garante que o Flutter esteja completamente inicializado antes de rodar o app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Inicializa o Firebase com as opções para a plataforma atual
  );
  runApp(MyApp()); // Executa o aplicativo
}

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro Simples', // Define o título do aplicativo
      theme: ThemeData(
          primarySwatch: Colors
              .blue), // Define o tema do aplicativo com a cor principal azul
      home: CadastroPage(), // Define a tela inicial como CadastroPage
    );
  }
}
