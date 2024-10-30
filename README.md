Aqui está o `README.md` formatado para você copiar e colar no GitHub:

---

```markdown
# Configuração do Projeto Flutter com Firebase Usando FlutterFire CLI

Este guia explica como configurar um projeto Flutter com Firebase usando a FlutterFire CLI, o jeito mais fácil de começar a utilizar o Firebase no Flutter.

## Pré-requisitos

Antes de continuar, certifique-se de que os seguintes itens estejam instalados:

- **Firebase CLI**: Instale a Firebase CLI e faça login com `firebase login`.
- **SDK do Flutter**: Certifique-se de ter o Flutter instalado ([Guia de instalação do Flutter](https://docs.flutter.dev/get-started/install)).

---

## Passo 1: Criar um Novo Projeto Flutter

1. No terminal, crie um novo projeto Flutter:
   ```bash
   flutter create nome_do_projeto
   ```

2. Entre no diretório do projeto:
   ```bash
   cd nome_do_projeto
   ```

---

## Passo 2: Instalar e Configurar a FlutterFire CLI

1. **Instalar a FlutterFire CLI**:
   - No terminal, execute o comando para ativar a CLI do FlutterFire:
     ```bash
     dart pub global activate flutterfire_cli
     ```

2. **Configurar o Firebase com a FlutterFire CLI**:
   - Dentro do diretório do projeto, execute o comando para configurar o Firebase:
     ```bash
     flutterfire configure --project=exemplo2-99357
     ```
   - Esse comando registra automaticamente seu app nas plataformas configuradas (Android e iOS) e gera o arquivo `lib/firebase_options.dart` com as configurações de inicialização.

---

## Passo 3: Adicionar Dependências do FlutterFire

1. Abra o arquivo `pubspec.yaml` e adicione as dependências que você deseja utilizar:
   ```yaml
   dependencies:
     firebase_core: latest_version
     cloud_firestore: latest_version
     firebase_auth: latest_version
     firebase_storage: latest_version
   ```

2. **Atualizar as dependências**:
   - Execute o comando:
     ```bash
     flutter pub get
     ```

3. **Inicializar o Firebase no Projeto**:
   - No arquivo `main.dart`, inicialize o Firebase antes de rodar o app:
     ```dart
     import 'package:firebase_core/firebase_core.dart';
     import 'firebase_options.dart';
     import 'package:flutter/material.dart';

     void main() async {
       WidgetsFlutterBinding.ensureInitialized();
       await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
       runApp(MyApp());
     }
     ```

---

## Passo 4: Testar a Configuração

1. Execute o comando:
   ```bash
   flutter run
   ```
2. Verifique se o aplicativo inicia corretamente sem erros no console.

---

## Referências

- [Documentação FlutterFire](https://firebase.flutter.dev/docs/overview)
- [Console do Firebase](https://console.firebase.google.com/)
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/)
```

---

Esse `README.md` já está formatado para você colar no seu repositório no GitHub. Se precisar de mais ajustes, me avise!
