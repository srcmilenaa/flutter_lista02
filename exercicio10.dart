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
      home: const ControleEstoque(),
    );
  }
}

class ControleEstoque extends StatefulWidget {
  const ControleEstoque({super.key});

  @override
  State<ControleEstoque> createState() => _ControleEstoqueState();
}

class _ControleEstoqueState extends State<ControleEstoque> {
  final TextEditingController quantidadeController =
      TextEditingController();

  int estoque = 0;
  String mensagem = '';

  void entrada() {
    final int? quantidade =
        int.tryParse(quantidadeController.text.trim());

    if (quantidade == null || quantidade <= 0) {
      setState(() {
        mensagem = 'Digite uma quantidade inteira maior que zero.';
      });
      return;
    }

    setState(() {
      estoque = estoque + quantidade;
      mensagem = 'Entrada realizada com sucesso.';
    });
  }

  void saida() {
    final int? quantidade =
        int.tryParse(quantidadeController.text.trim());

    if (quantidade == null || quantidade <= 0) {
      setState(() {
        mensagem = 'Digite uma quantidade inteira maior que zero.';
      });
      return;
    }

    if (quantidade > estoque) {
      setState(() {
        mensagem = 'Aviso: a saída é maior que o estoque disponível.';
      });
      return;
    }

    setState(() {
      estoque = estoque - quantidade;
      mensagem = 'Saída realizada com sucesso.';
    });
  }

  void limparCampo() {
    quantidadeController.clear();

    setState(() {
      mensagem = '';
    });
  }

  @override
  void dispose() {
    quantidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controle de estoque')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Quantidade atual em estoque: $estoque',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: quantidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: entrada,
                  child: const Text('Entrada'),
                ),
                ElevatedButton(
                  onPressed: saida,
                  child: const Text('Saída'),
                ),
                ElevatedButton(
                  onPressed: limparCampo,
                  child: const Text('Limpar campo'),
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
