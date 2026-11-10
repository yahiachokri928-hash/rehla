
import 'package:flutter/material.dart';

import '../services/api_service.dart';
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
  late Future<List<Destination>> _futureDestinations;

  int _onglet = 0;
  String _categorie = 'Tout';

  @override
  void initState() {
    super.initState();
    _futureDestinations = ApiService.getDestinations();
  }

  Future<void> _actualiser() async {
    setState(() {
      _futureDestinations = ApiService.getDestinations();
    });

    try {
      await _futureDestinations;
    } catch (_) {
      // L'erreur sera affichée par le FutureBuilder.
    }
  }

  Widget _construireAccueil() {
    return FutureBuilder<List<Destination>>(
      future: _futureDestinations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Impossible de charger les destinations'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _actualiser,
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Aucune destination disponible'),
          );
        }

        final listeDestinations = snapshot.data!;

        final destinationsFiltrees = _categorie == 'Tout'
            ? listeDestinations
            : listeDestinations
                .where((d) => d.categorie == _categorie)
                .toList();

        return RefreshIndicator(
          onRefresh: _actualiser,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              const HomeHeader(prenom: 'Yasmine'),
              const SizedBox(height: 20),
              const SearchBox(),
              const SizedBox(height: 20),
              HeroBanner(destination: listeDestinations.first),
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
              const SectionTitle(
                title: 'Populaires',
                action: 'Voir tout',
              ),
              const SizedBox(height: 12),
              if (destinationsFiltrees.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Aucune destination dans cette catégorie'),
                  ),
                )
              else
                for (final d in destinationsFiltrees)
                  DestinationCard(
                    key: ValueKey(d.id),
                    destination: d,
                  ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> ecrans = [
      _construireAccueil(),
      const Center(
        child: Text(
          'Favoris — Bientôt disponible',
          style: TextStyle(fontSize: 18),
        ),
      ),
      const Center(
        child: Text(
          'Profil — Bientôt disponible',
          style: TextStyle(fontSize: 18),
        ),
      ),
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
