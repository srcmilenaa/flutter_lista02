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
      home: const AntecessorSucessor(),
    );
  }
}

class AntecessorSucessor extends StatefulWidget {
  const AntecessorSucessor({super.key});

  @override
  State<AntecessorSucessor> createState() => _AntecessorSucessorState();
}

class _AntecessorSucessorState extends State<AntecessorSucessor> {
  final TextEditingController numeroController = TextEditingController();

  String resultado = '';

  void calcular() {
    final int? numero = int.tryParse(numeroController.text.trim());

    if (numero == null) {
      setState(() {
        resultado = 'Digite um número inteiro válido.';
      });
      return;
    }

    final int antecessor = numero - 1;
    final int sucessor = numero + 1;

    setState(() {
      resultado =
          'Número: $numero\n'
          'Antecessor: $antecessor\n'
          'Sucessor: $sucessor';
    });
  }

  void limpar() {
    numeroController.clear();

    setState(() {
      resultado = '';
    });
  }

  @override
  void dispose() {
    numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Antecessor e sucessor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: numeroController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número inteiro',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: calcular,
                  child: const Text('Calcular'),
                ),
                ElevatedButton(
                  onPressed: limpar,
                  child: const Text('Limpar'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              resultado,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
