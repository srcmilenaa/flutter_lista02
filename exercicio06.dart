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
      home: const Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final TextEditingController primeiroController = TextEditingController();
  final TextEditingController segundoController = TextEditingController();

  String resultado = '';

  double? obterPrimeiroNumero() {
    return double.tryParse(primeiroController.text.trim());
  }

  double? obterSegundoNumero() {
    return double.tryParse(segundoController.text.trim());
  }

  void somar() {
    final double? primeiro = obterPrimeiroNumero();
    final double? segundo = obterSegundoNumero();

    if (primeiro == null || segundo == null) {
      setState(() {
        resultado = 'Digite dois números válidos.';
      });
      return;
    }

    setState(() {
      resultado = 'Resultado: ${primeiro + segundo}';
    });
  }

  void subtrair() {
    final double? primeiro = obterPrimeiroNumero();
    final double? segundo = obterSegundoNumero();

    if (primeiro == null || segundo == null) {
      setState(() {
        resultado = 'Digite dois números válidos.';
      });
      return;
    }

    setState(() {
      resultado = 'Resultado: ${primeiro - segundo}';
    });
  }

  void multiplicar() {
    final double? primeiro = obterPrimeiroNumero();
    final double? segundo = obterSegundoNumero();

    if (primeiro == null || segundo == null) {
      setState(() {
        resultado = 'Digite dois números válidos.';
      });
      return;
    }

    setState(() {
      resultado = 'Resultado: ${primeiro * segundo}';
    });
  }

  void dividir() {
    final double? primeiro = obterPrimeiroNumero();
    final double? segundo = obterSegundoNumero();

    if (primeiro == null || segundo == null) {
      setState(() {
        resultado = 'Digite dois números válidos.';
      });
      return;
    }

    if (segundo == 0) {
      setState(() {
        resultado = 'Erro: não é possível dividir por zero.';
      });
      return;
    }

    setState(() {
      resultado = 'Resultado: ${primeiro / segundo}';
    });
  }

  void limpar() {
    primeiroController.clear();
    segundoController.clear();

    setState(() {
      resultado = '';
    });
  }

  @override
  void dispose() {
    primeiroController.dispose();
    segundoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: primeiroController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Primeiro número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: segundoController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Segundo número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: somar, child: const Text('+')),
                ElevatedButton(onPressed: subtrair, child: const Text('-')),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: multiplicar, child: const Text('×')),
                ElevatedButton(onPressed: dividir, child: const Text('÷')),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: limpar,
              child: const Text('Limpar'),
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
