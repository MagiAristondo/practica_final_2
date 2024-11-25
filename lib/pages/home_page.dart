import 'package:flutter/material.dart';
import 'personal_page.dart';
import 'widget_page.dart';
import '../models/persona.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Persona inicial
  final Persona personaInicial = Persona(
    nom: '',
    cognom: '',
    dataNaixement: null,
    email: '',
    contrasenya: '',
  );

  // Missatge per mostrar el nom de la persona
  String missatgePersona = '';

  // Funció per obrir el diàleg
  void _openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Què fas?'),
          content: const Text('En Tux no se toca!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tancar el diàleg
              },
              child: const Text('Tancar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SPPMM')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'La Meva App',
                style: TextStyle(
                    fontSize: 40, color: Colors.white, fontFamily: 'Atma'),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: _openDialog, // Obrir el diàleg quan la imatge es toca
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Linux_mascot_tux.png/495px-Linux_mascot_tux.png?20220614105200',
                  height: 300,
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PersonalPage(persona: personaInicial),
                      ),
                    ).then((result) {
                      if (result != null && result is Persona) {
                        setState(() {
                          missatgePersona =
                              "S'han desat els canvis de: ${result.nom}";
                        });
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Personal Page'),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WidgetPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Widget Page'),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                missatgePersona,
                style: const TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 113, 175, 204)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
