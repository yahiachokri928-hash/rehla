import 'package:flutter/material.dart';

import '../data/destinations.dart';
import '../models/destination.dart';
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/hero_banner.dart';
import '../widgets/section_title.dart';
import '../widgets/destination_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _onglet = 0; // État pour l'onglet actif de la barre de navigation
  String _categorie = 'Tout';

  List<Destination> get _filtrees {
    if (_categorie == 'Tout') {
      return destinations;
    } else {
      return destinations.where((d) => d.categorie == _categorie).toList();
    }
  }

  // Méthode qui construit le contenu de l'onglet "Explorer"
  Widget _construireAccueil() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const HomeHeader(prenom: 'Yasmine'),
        const SizedBox(height: 20),
        const SearchBox(),
        const SizedBox(height: 20),
        HeroBanner(destination: destinations.first),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Catégories'),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final c in categories)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(c),
                    selected: _categorie == c,
                    onSelected: (_) {
                      setState(() {
                        _categorie = c;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SectionTitle(title: 'Populaires', action: 'Voir tout'),
        const SizedBox(height: 12),
        for (final d in _filtrees)
          DestinationCard(
            key: ValueKey(d.nom),
            destination: d,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Liste des écrans selon l'onglet sélectionné
    final List<Widget> ecrans = [
      _construireAccueil(),
      const Center(child: Text('Favoris — Bientôt disponible', style: TextStyle(fontSize: 18))),
      const Center(child: Text('Profil — Bientôt disponible', style: TextStyle(fontSize: 18))),
    ];

    return Scaffold(
      body: SafeArea(
        child: ecrans[_onglet],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _onglet,
        onDestinationSelected: (index) {
          setState(() {
            _onglet = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explorer',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}