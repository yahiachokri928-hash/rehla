import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/destination.dart';
import '../models/reservation.dart';

class ApiService {
  static Uri _url(String chemin) {
    return Uri.parse('${ApiConfig.baseUrl}$chemin');
  }

  // Récupérer les destinations depuis l'API
  static Future<List<Destination>> getDestinations() async {
    final reponse = await http
        .get(_url('/destinations'))
        .timeout(ApiConfig.timeout);

    if (reponse.statusCode != 200) {
      throw Exception('Erreur HTTP ${reponse.statusCode}');
    }

    final List<dynamic> liste = jsonDecode(utf8.decode(reponse.bodyBytes));

    return liste.map((json) => Destination.fromJson(json)).toList();
  }

  // Envoyer une réservation à l'API
  static Future<void> createReservation(Reservation reservation) async {
    final reponse = await http
        .post(
          _url('/reservations'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(reservation.toJson()),
        )
        .timeout(ApiConfig.timeout);

    if (reponse.statusCode != 200 && reponse.statusCode != 201) {
      throw Exception(
        'Erreur lors de la réservation : HTTP ${reponse.statusCode}',
      );
    }
  }
}
