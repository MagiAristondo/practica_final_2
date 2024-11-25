import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Per formatar la data de naixement
import '../models/persona.dart';

class PersonalPage extends StatefulWidget {
  final Persona persona;

  const PersonalPage({super.key, required this.persona});

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  late TextEditingController nomController;
  late TextEditingController cognomController;
  late TextEditingController dataNaixementController;
  late TextEditingController emailController;
  late TextEditingController contrasenyaController;

  @override
  void initState() {
    super.initState();
    nomController = TextEditingController(text: widget.persona.nom);
    cognomController = TextEditingController(text: widget.persona.cognom);
    dataNaixementController = TextEditingController(
      text: widget.persona.dataNaixement != null
          ? DateFormat('dd/MM/yyyy').format(widget.persona.dataNaixement!)
          : '',
    );
    emailController = TextEditingController(text: widget.persona.email);
    contrasenyaController =
        TextEditingController(text: widget.persona.contrasenya);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.persona.dataNaixement ?? DateTime.now(),
      firstDate: DateTime(1900), // Data mínima
      lastDate: DateTime.now(), // No permet dates futures
      locale: const Locale('en', 'GB'),
    );

    if (selectedDate != null) {
      setState(() {
        widget.persona.dataNaixement = selectedDate;
        dataNaixementController.text =
            DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.persona.cognom)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomController,
              decoration: const InputDecoration(
                  labelText: 'Nom', hintText: 'Escriu el teu nom aquí'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cognomController,
              decoration: const InputDecoration(
                  labelText: 'Cognom', hintText: 'Escriu el teu cognom aquí'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: 'Email', hintText: 'Escriu el teu email aquí'),
            ),
            const SizedBox(height: 16),
            // TextField per a la data de naixement
            TextField(
              controller: dataNaixementController,
              decoration: const InputDecoration(
                labelText: 'Data de naixement',
                hintText: 'Selecciona la teva data de naixement',
              ),
              readOnly: true, // No es pot escriure manualment
              onTap: () => _selectDate(context), // Obrir el selector de dates
            ),
            const SizedBox(height: 16),
            // TextField per a la contrasenya
            TextField(
              controller: contrasenyaController,
              decoration: const InputDecoration(
                labelText: 'Contrasenya',
                hintText: 'Escriu la teva contrasenya',
              ),
              obscureText: true, // Amaga el text per la contrasenya
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.persona.nom = nomController.text;
                  widget.persona.cognom = cognomController.text;
                  widget.persona.email = emailController.text;
                  widget.persona.contrasenya = contrasenyaController.text;
                });
                Navigator.pop(context, widget.persona);
              },
              child: const Text('Desa'),
            ),
          ],
        ),
      ),
    );
  }
}
