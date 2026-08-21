import 'package:flutter/material.dart';
import 'home.dart';

class SplashScreen extends StatelessWidget {
  final bool temaEscuro;
  final Function(bool) mudarTema;

  const SplashScreen({
    super.key,
    required this.temaEscuro,
    required this.mudarTema,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 340,
            padding: const EdgeInsets.fromLTRB(30, 35, 30, 30),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.local_gas_station,
                    size: 55,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Abastecimentos',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tema escuro',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      value: temaEscuro,
                      onChanged: mudarTema,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 150,
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}