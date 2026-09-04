import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IdentificacaoUsuario(),
    );
  }
}

class IdentificacaoUsuario extends StatefulWidget {
  const IdentificacaoUsuario({super.key});

  @override
  State<IdentificacaoUsuario> createState() => _IdentificacaoUsuarioState();
}

class _IdentificacaoUsuarioState extends State<IdentificacaoUsuario> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();

  String mensagem = '';

  void mostrar() {
    final nome = nomeController.text.trim();
    final cidade = cidadeController.text.trim();

    if (nome.isEmpty || cidade.isEmpty) {
      setState(() {
        mensagem = 'Preencha o nome e a cidade.';
      });
      return;
    }

    setState(() {
      mensagem = 'Olá, $nome! Você mora em $cidade.';
    });
  }

  void limpar() {
    nomeController.clear();
    cidadeController.clear();

    setState(() {
      mensagem = '';
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    cidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identificação do usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cidadeController,
              decoration: const InputDecoration(
                labelText: 'Cidade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: mostrar,
                  child: const Text('Mostrar'),
                ),
                ElevatedButton(
                  onPressed: limpar,
                  child: const Text('Limpar'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              mensagem,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
