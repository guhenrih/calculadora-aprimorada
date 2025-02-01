import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'C';
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Erro';
    }
  }

  double _avaliarExpressao(String expressao) {
    // Substituindo os símbolos para a biblioteca expressions
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    expressao = expressao.replaceAll('√', 'sqrt');  // Raiz quadrada
    expressao = expressao.replaceAll('^', '**');   // Potênciação
    expressao = expressao.replaceAll('%', '/100');  // Porcentagem
    expressao = expressao.replaceAll('π', '${pi}'); // Valor de PI

    // Avaliando a expressão
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  Widget _botao(String valor, Color cor, Color textoCor) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textoCor, backgroundColor: cor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          minimumSize: const Size(70, 70),
        ),
        child: Text(
          valor,
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => _pressionarBotao(valor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tela de expressão
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            _expressao,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        // Tela de resultado
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            _resultado,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        // Grade de botões
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 1.2,
            padding: const EdgeInsets.all(16.0),
            children: [
              _botao('7', Colors.grey.shade300, Colors.black),
              _botao('8', Colors.grey.shade300, Colors.black),
              _botao('9', Colors.grey.shade300, Colors.black),
              _botao('÷', Colors.orangeAccent, Colors.white),
              _botao('4', Colors.grey.shade300, Colors.black),
              _botao('5', Colors.grey.shade300, Colors.black),
              _botao('6', Colors.grey.shade300, Colors.black),
              _botao('x', Colors.orangeAccent, Colors.white),
              _botao('1', Colors.grey.shade300, Colors.black),
              _botao('2', Colors.grey.shade300, Colors.black),
              _botao('3', Colors.grey.shade300, Colors.black),
              _botao('-', Colors.orangeAccent, Colors.white),
              _botao('0', Colors.grey.shade300, Colors.black),
              _botao('.', Colors.grey.shade300, Colors.black),
              _botao('=', Colors.greenAccent, Colors.white),
              _botao('+', Colors.orangeAccent, Colors.white),
              _botao('√', Colors.grey.shade300, Colors.black),  // Raiz
              _botao('%', Colors.grey.shade300, Colors.black),  // Porcentagem
              _botao('^', Colors.grey.shade300, Colors.black),  // Potenciação
              _botao('π', Colors.grey.shade300, Colors.black),  // PI
            ],
          ),
        ),
        // Botão de limpar
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: _botao(_limpar, Colors.redAccent, Colors.white),
        ),
      ],
    );
  }
}
