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
  String _categorie = 'Tout'; // L'état initial : la catégorie choisie

  // Getter bech y-filtré el destinations selon el catégorie elly t5tart
  List<Destination> get _filtrees {
    if (_categorie == 'Tout') {
      return destinations;
    } else {
      return destinations.where((d) => d.categorie == _categorie).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
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

            for (final d in _filtrees) DestinationCard(destination: d),
          ],
        ),
      ),
    );
  }
}
