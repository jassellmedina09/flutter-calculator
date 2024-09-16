import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  // Handle digit and operator input
  void _onPressed(String value) {
    if (value == '=') {
      _calculate();  // Evaluate expression on '='
    } else if (value == 'C') {
      _clear();  // Clear input and result on 'C'
    } else {
      setState(() {
        _expression += value;  // Accumulate the expression
      });
    }
  }

  // Clear the display and reset the expression
  void _clear() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  // Evaluate the current expression
  void _calculate() {
    try {
      final expression = Expression.parse(_expression);
      final evaluator = const ExpressionEvaluator();
      final evalResult = evaluator.eval(expression, {});
      setState(() {
        _result = evalResult.toString();  // Show result
        _expression = '';  // Reset expression after calculation
      });
    } catch (e) {
      setState(() {
        _result = 'Error';  // Show error message for invalid expressions
      });
    }
  }

  // Create calculator button widget
  Widget _buildButton(String value, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onPressed(value),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.blueAccent,
            padding: const EdgeInsets.all(24),
          ),
          child: Text(value, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator - Your Name'),
      ),
      body: Column(
        children: [
          // Display the expression
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression.isEmpty ? '0' : _expression,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          // Display the result
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _result,
                style: const TextStyle(fontSize: 32, color: Colors.grey),
              ),
            ),
          ),
          // Calculator buttons
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/', color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*', color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-', color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('0'),
                  _buildButton('C', color: Colors.red),
                  _buildButton('=', color: Colors.green),
                  _buildButton('+', color: Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
