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
      home: const SistemaVendas(),
    );
  }
}

class SistemaVendas extends StatefulWidget {
  const SistemaVendas({super.key});

  @override
  State<SistemaVendas> createState() => _SistemaVendasState();
}

class _SistemaVendasState extends State<SistemaVendas> {
  final TextEditingController produtoController = TextEditingController();
  final TextEditingController precoController = TextEditingController();
  final TextEditingController quantidadeController =
      TextEditingController();

  String resultado = '';

  void calcular() {
    final String produto = produtoController.text.trim();
    final double? preco = double.tryParse(precoController.text.trim());
    final int? quantidade =
        int.tryParse(quantidadeController.text.trim());

    if (produto.isEmpty || preco == null || quantidade == null) {
      setState(() {
        resultado = 'Preencha os dados corretamente.';
      });
      return;
    }

    if (preco < 0 || quantidade < 0) {
      setState(() {
        resultado = 'Preço e quantidade não podem ser negativos.';
      });
      return;
    }

    final double subtotal = preco * quantidade;
    double desconto = 0;

    if (subtotal > 500) {
      desconto = subtotal * 0.10;
    }

    final double total = subtotal - desconto;

    setState(() {
      resultado =
          'Produto: $produto\n'
          'Quantidade: $quantidade\n'
          'Subtotal: R\$ ${subtotal.toStringAsFixed(2)}\n'
          'Desconto: R\$ ${desconto.toStringAsFixed(2)}\n'
          'Total: R\$ ${total.toStringAsFixed(2)}';
    });
  }

  void limpar() {
    produtoController.clear();
    precoController.clear();
    quantidadeController.clear();

    setState(() {
      resultado = '';
    });
  }

  @override
  void dispose() {
    produtoController.dispose();
    precoController.dispose();
    quantidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sistema simples de vendas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: produtoController,
              decoration: const InputDecoration(
                labelText: 'Produto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: precoController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Preço unitário',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
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
