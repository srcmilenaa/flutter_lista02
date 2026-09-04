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
      home: const ConsumoCombustivel(),
    );
  }
}

class ConsumoCombustivel extends StatefulWidget {
  const ConsumoCombustivel({super.key});

  @override
  State<ConsumoCombustivel> createState() => _ConsumoCombustivelState();
}

class _ConsumoCombustivelState extends State<ConsumoCombustivel> {
  final TextEditingController distanciaController = TextEditingController();
  final TextEditingController combustivelController =
      TextEditingController();

  String resultado = '';

  void calcular() {
    final double? distancia =
        double.tryParse(distanciaController.text.trim());
    final double? combustivel =
        double.tryParse(combustivelController.text.trim());

    if (distancia == null || combustivel == null) {
      setState(() {
        resultado = 'Digite a distância e o combustível corretamente.';
      });
      return;
    }

    if (combustivel <= 0) {
      setState(() {
        resultado = 'A quantidade de combustível deve ser maior que zero.';
      });
      return;
    }

    final double consumo = distancia / combustivel;

    setState(() {
      if (consumo >= 12) {
        resultado =
            'Consumo médio: ${consumo.toStringAsFixed(1)} km/l\n'
            'Classificação: Econômico';
      } else {
        resultado =
            'Consumo médio: ${consumo.toStringAsFixed(1)} km/l\n'
            'Classificação: Consumo elevado';
      }
    });
  }

  void limpar() {
    distanciaController.clear();
    combustivelController.clear();

    setState(() {
      resultado = '';
    });
  }

  @override
  void dispose() {
    distanciaController.dispose();
    combustivelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consumo de combustível')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: distanciaController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Distância em km',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: combustivelController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Combustível em litros',
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
