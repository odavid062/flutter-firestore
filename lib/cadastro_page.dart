import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Define o widget para a tela de cadastro
class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // Cria uma chave para o formulário, permitindo validar e gerenciar seu estado
  final _formKey = GlobalKey<FormState>();

  // Controladores para capturar os dados dos campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Variável para armazenar o ID do documento selecionado para atualização
  String? _selectedDocId;

  // Função assíncrona para salvar um novo cadastro no Firestore
  Future<void> _salvarCadastro() async {
    if (_formKey.currentState!.validate()) {
      // Verifica se o formulário é válido
      // Adiciona um novo documento na coleção 'usuarios' no Firestore
      await FirebaseFirestore.instance.collection('usuarios').add({
        'nome': _nameController.text, // Salva o nome do campo de texto
        'email': _emailController.text, // Salva o email do campo de texto
      });
      _limparFormulario(); // Limpa o formulário após salvar
    }
  }

  // Função para buscar os cadastros em tempo real usando snapshots
  Stream<QuerySnapshot> _buscarCadastros() {
    // Retorna um stream de snapshots da coleção 'usuarios'
    return FirebaseFirestore.instance.collection('usuarios').snapshots();
  }

  // Função para atualizar o cadastro selecionado com o ID do documento fornecido
  Future<void> _atualizarCadastro(String docId) async {
    if (_formKey.currentState!.validate()) {
      // Verifica se o formulário é válido
      // Atualiza o documento com o ID especificado na coleção 'usuarios'
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(docId)
          .update({
        'nome': _nameController.text, // Atualiza o nome
        'email': _emailController.text, // Atualiza o email
      });
      _limparFormulario(); // Limpa o formulário após atualizar
    }
  }

  // Função para deletar um cadastro específico usando o ID do documento
  Future<void> _deletarCadastro(String docId) async {
    // Deleta o documento com o ID especificado na coleção 'usuarios'
    await FirebaseFirestore.instance.collection('usuarios').doc(docId).delete();
  }

  // Limpa o formulário e reseta o ID do documento selecionado
  void _limparFormulario() {
    _nameController.clear(); // Limpa o campo de nome
    _emailController.clear(); // Limpa o campo de email
    _selectedDocId = null; // Reseta o ID do documento selecionado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Cadastro Simples')), // Título do app na barra superior
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Formulário de cadastro com campos de texto e botão de ação
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Campo de entrada para o nome
                  TextFormField(
                    controller:
                        _nameController, // Controlador do campo de texto
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um nome'; // Validação de campo vazio
                      }
                      return null; // Retorna null se não houver erros
                    },
                  ),
                  // Campo de entrada para o email
                  TextFormField(
                    controller:
                        _emailController, // Controlador do campo de texto
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um email'; // Validação de campo vazio
                      }
                      return null; // Retorna null se não houver erros
                    },
                  ),
                  SizedBox(height: 20), // Espaçamento entre campos e botão
                  // Botão de ação: Cadastrar ou Atualizar
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedDocId == null) {
                        _salvarCadastro(); // Salva novo cadastro se nenhum documento estiver selecionado
                      } else {
                        _atualizarCadastro(
                            _selectedDocId!); // Atualiza o cadastro selecionado
                      }
                    },
                    child: Text(_selectedDocId == null
                        ? 'Cadastrar'
                        : 'Atualizar'), // Define o texto do botão
                  ),
                ],
              ),
            ),
            // Exibe a lista de cadastros em tempo real
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    _buscarCadastros(), // Stream que monitora a coleção 'usuarios'
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return CircularProgressIndicator(); // Mostra indicador de carregamento se não houver dados
                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return ListTile(
                        title: Text(doc['nome']), // Exibe o nome do cadastro
                        subtitle:
                            Text(doc['email']), // Exibe o email do cadastro
                        onTap: () {
                          // Ao clicar, os campos são preenchidos para edição
                          _nameController.text = doc['nome'];
                          _emailController.text = doc['email'];
                          _selectedDocId = doc.id; // Armazena o ID do documento
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.delete), // Ícone para deletar
                          onPressed: () =>
                              _deletarCadastro(doc.id), // Ação de deletar
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
