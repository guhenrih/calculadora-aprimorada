import 'calculadora.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _modoEscuro = false;

  void _alternarModo() {
    setState(() {
      _modoEscuro = !_modoEscuro;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: _modoEscuro
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            )
          : ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
      home: HomePage(
        title: 'Calculadora',
        alternarModo: _alternarModo,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.title,
    required this.alternarModo,
  });

  final String title;
  final Function alternarModo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              size: 30,
            ),
            onPressed: () => alternarModo(),
          ),
        ],
      ),
      body: const Center(
        child: Calculadora(),
      ),
    );
  }
}
