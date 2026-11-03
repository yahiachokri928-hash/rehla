import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/destination.dart';

class ReservationScreen extends StatefulWidget {
  final Destination destination;
  final int voyageurs;

  const ReservationScreen({
    super.key,
    required this.destination,
    required this.voyageurs,
  });

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telCtrl = TextEditingController();

  @override
  void dispose() {
    _nomCtrl.dispose();
    _emailCtrl.dispose();
    _telCtrl.dispose();
    super.dispose();
  }

  InputDecoration _deco(String label, IconData icone, {String? aide}) {
    return InputDecoration(
      labelText: label,
      helperText: aide,
      prefixIcon: Icon(icone),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  String? _validerNom(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Indiquez votre nom';
    }

    if (v.trim().length < 3) {
      return 'Au moins 3 caractères';
    }

    return null;
  }

  String? _validerEmail(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Indiquez votre e-mail';
    }

    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.]+$').hasMatch(v.trim())) {
      return 'E-mail invalide (ex. : nom@mail.tn)';
    }

    return null;
  }

  String? _validerTel(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Indiquez votre téléphone';
    }

    if (v.trim().length != 8) {
      return '8 chiffres attendus';
    }

    return null;
  }

  void _valider() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Formulaire valide')));
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    return Scaffold(
      appBar: AppBar(title: const Text('Réserver')),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Récapitulatif de la destination
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      destination.image,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destination.nom,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(destination.duree),
                        Text('${widget.voyageurs} voyageur(s)'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Champ Nom
              TextFormField(
                controller: _nomCtrl,
                decoration: _deco('Nom complet', Icons.person_outline),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: _validerNom,
              ),

              const SizedBox(height: 16),

              // Champ E-mail
              TextFormField(
                controller: _emailCtrl,
                decoration: _deco('E-mail', Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: _validerEmail,
              ),

              const SizedBox(height: 16),

              // Champ Téléphone
              TextFormField(
                controller: _telCtrl,
                decoration: _deco(
                  'Téléphone',
                  Icons.phone_outlined,
                  aide: '8 chiffres, sans indicatif',
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                ],
                validator: _validerTel,
              ),
            ],
          ),
        ),
      ),

      // Bouton Confirmer
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: FilledButton.icon(
            onPressed: _valider,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Confirmer'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
          ),
        ),
      ),
    );
  }
}
