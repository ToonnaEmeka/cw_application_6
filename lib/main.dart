import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Simple Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _displayText = '0';
  String _operand1 = '';
  String _operand2 = '';
  String _operator = '';

  void _clear() {
    setState(() {
      _displayText = '0';
      _operand1 = '';
      _operand2 = '';
      _operator = '';
    });
  }

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _clear();
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        if (_operand1.isNotEmpty) {
          _operator = value;
        }
      } else if (value == '=') {
        if (_operand1.isNotEmpty && _operator.isNotEmpty && _operand2.isNotEmpty) {
          _calculateResult();
        }
      } else {
        if (_operator.isEmpty) {
          _operand1 += value;
          _displayText = _operand1;
        } else {
          _operand2 += value;
          _displayText = _operand2;
        }
      }
    });
  }

  void _calculateResult() {
    double num1 = double.tryParse(_operand1) ?? 0;
    double num2 = double.tryParse(_operand2) ?? 0;
    double result = 0;

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        if (num2 == 0) {
          _displayText = 'Error';
          return;
        } else {
          result = num1 / num2;
        }
        break;
    }

    if (result == result.toInt()) {
      _displayText = result.toInt().toString();
    } else {
      _displayText = result.toString();
    }

    _operand1 = '';
    _operand2 = '';
    _operator = '';
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // Set button background color
          ),
          onPressed: () => _buttonPressed(value),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 24.0,
              color: Colors.white, // Set button text color
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _displayText,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/')
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*')
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-')
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('='),
              _buildButton('+')
            ],
          ),
        ],
      ),
    );
  }
}
