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
      home: const ConversorTemperatura(),
    );
  }
}

class ConversorTemperatura extends StatefulWidget {
  const ConversorTemperatura({super.key});

  @override
  State<ConversorTemperatura> createState() => _ConversorTemperaturaState();
}

class _ConversorTemperaturaState extends State<ConversorTemperatura> {
  final TextEditingController temperaturaController =
      TextEditingController();

  String resultado = '';

  void converter() {
    final double? celsius =
        double.tryParse(temperaturaController.text.trim());

    if (celsius == null) {
      setState(() {
        resultado = 'Digite uma temperatura válida.';
      });
      return;
    }

    final double fahrenheit = (celsius * 9 / 5) + 32;

    setState(() {
      resultado =
          'Temperatura em Fahrenheit: ${fahrenheit.toStringAsFixed(1)} °F';
    });
  }

  void limpar() {
    temperaturaController.clear();

    setState(() {
      resultado = '';
    });
  }

  @override
  void dispose() {
    temperaturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de temperatura')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: temperaturaController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Temperatura em Celsius',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: converter,
                  child: const Text('Converter'),
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
