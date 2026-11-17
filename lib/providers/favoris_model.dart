import 'package:flutter/foundation.dart';
import '../models/destination.dart';

/// Favoris partagés par tous les écrans.
class FavorisModel extends ChangeNotifier {
  // favoris rangés par id : Map<String, Destination>
  final Map<String, Destination> _favoris = {};

  /// Vérifie si la destination est dans les favoris
  bool estFavori(Destination d) {
    return _favoris.containsKey(d.id);
  }

  /// Liste des destinations favorites en lecture seule
  List<Destination> get liste => List.unmodifiable(_favoris.values);

  /// Nombre total de favoris
  int get nombre => _favoris.length;

  /// Bascule l'état favori (ajoute ou retire),
  /// prévient les écouteurs avec notifyListeners(),
  /// et renvoie true si ajouté, false si retiré.
  bool basculer(Destination d) {
    final bool ajoute;
    if (_favoris.containsKey(d.id)) {
      _favoris.remove(d.id);
      ajoute = false;
    } else {
      _favoris[d.id] = d;
      ajoute = true;
    }
    notifyListeners();
    return ajoute;
  }
}
