import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();
  String resultText = 'Result will appear here';
  String? errorText;

  @override
  void dispose() {
    num1Controller.dispose();
    num2Controller.dispose();
    super.dispose();
  }

  void calculate(String operation) {
    setState(() {
      errorText = null;
      resultText = '';

      final n1 = double.tryParse(num1Controller.text.trim());
      final n2 = double.tryParse(num2Controller.text.trim());

      if (n1 == null || n2 == null) {
        errorText = 'Please enter valid numbers in both fields.';
        return;
      }

      double result;
      switch (operation) {
        case '+':
          result = n1 + n2;
          break;
        case '-':
          result = n1 - n2;
          break;
        case '*':
          result = n1 * n2;
          break;
        case '/':
          if (n2 == 0) {
            errorText = 'Cannot divide by zero.';
            return;
          }
          result = n1 / n2;
          break;
        default:
          return;
      }

      resultText =
          'Result: ${result % 1 == 0 ? result.toInt() : result.toStringAsFixed(4)}';
    });
  }

  void clear() {
    setState(() {
      num1Controller.clear();
      num2Controller.clear();
      resultText = 'Result will appear here';
      errorText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.calculate, size: 80, color: Colors.indigo),
            const SizedBox(height: 16),
            TextField(
              controller: num1Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'First number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_one),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: num2Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Second number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_two),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => calculate('+'),
                    child: const Text('+'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => calculate('-'),
                    child: const Text('−'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => calculate('*'),
                    child: const Text('×'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => calculate('/'),
                    child: const Text('÷'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: clear,
              child: const Text('Clear'),
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    if (errorText != null)
                      Text(
                        errorText!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else
                      Text(
                        resultText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}