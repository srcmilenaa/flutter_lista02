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
      home: const ReajusteSalarial(),
    );
  }
}

class ReajusteSalarial extends StatefulWidget {
  const ReajusteSalarial({super.key});

  @override
  State<ReajusteSalarial> createState() => _ReajusteSalarialState();
}

class _ReajusteSalarialState extends State<ReajusteSalarial> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController salarioController = TextEditingController();
  final TextEditingController percentualController =
      TextEditingController();

  String resultado = '';

  void calcular() {
    final nome = nomeController.text.trim();
    final double? salario = double.tryParse(salarioController.text.trim());
    final double? percentual =
        double.tryParse(percentualController.text.trim());

    if (nome.isEmpty || salario == null || percentual == null) {
      setState(() {
        resultado = 'Preencha os dados corretamente.';
      });
      return;
    }

    final double aumento = salario * percentual / 100;
    final double novoSalario = salario + aumento;

    setState(() {
      resultado =
          'Funcionário: $nome\n'
          'Salário atual: R\$ ${salario.toStringAsFixed(2)}\n'
          'Aumento: R\$ ${aumento.toStringAsFixed(2)}\n'
          'Novo salário: R\$ ${novoSalario.toStringAsFixed(2)}';
    });
  }

  void limpar() {
    nomeController.clear();
    salarioController.clear();
    percentualController.clear();

    setState(() {
      resultado = '';
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    salarioController.dispose();
    percentualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reajuste salarial')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do funcionário',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: salarioController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Salário atual',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: percentualController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Percentual de reajuste',
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
