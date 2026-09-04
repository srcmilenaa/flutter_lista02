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
      home: const VerificadorIdade(),
    );
  }
}

class VerificadorIdade extends StatefulWidget {
  const VerificadorIdade({super.key});

  @override
  State<VerificadorIdade> createState() => _VerificadorIdadeState();
}

class _VerificadorIdadeState extends State<VerificadorIdade> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();

  String mensagem = '';

  void verificar() {
    final nome = nomeController.text.trim();
    final int? idade = int.tryParse(idadeController.text.trim());

    if (nome.isEmpty || idade == null) {
      setState(() {
        mensagem = 'Digite um nome e uma idade válida.';
      });
      return;
    }

    setState(() {
      if (idade >= 18) {
        mensagem = '$nome é maior de idade.';
      } else {
        mensagem = '$nome é menor de idade.';
      }
    });
  }

  void limpar() {
    nomeController.clear();
    idadeController.clear();

    setState(() {
      mensagem = '';
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verificador de idade')),
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
              controller: idadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Idade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: verificar,
                  child: const Text('Verificar'),
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
