// lib/services/api_service.dart

import 'dart:async';
import 'package:intl/intl.dart';

import '../models/checkin.dart';

class ApiService {
  // Singleton simples
  ApiService._internal();
  static final ApiService _instance = ApiService._internal();
  static ApiService get instance => _instance;

  /// Simulação de banco de dados local
  final List<Checkin> _checkins = [];

  /// Formato usado para comparar datas sem horário
  final DateFormat _dayFormat = DateFormat('yyyy-MM-dd');

  /// Simula POST /checkin
  Future<void> sendCheckin(Checkin checkin) async {
    // Simula tempo de rede
    await Future.delayed(Duration(milliseconds: 500));

    // Remove check-in anterior do mesmo dia
    _checkins.removeWhere(
      (c) => _dayFormat.format(c.date) == _dayFormat.format(checkin.date),
    );

    _checkins.add(checkin);
  }

  /// Simula GET /checkin/today
  Future<Checkin?> getTodayCheckin() async {
    await Future.delayed(Duration(milliseconds: 400));

    final today = _dayFormat.format(DateTime.now());

    try {
      return _checkins.firstWhere((c) => _dayFormat.format(c.date) == today);
    } catch (_) {
      return null;
    }
  }

  /// Simula GET /checkin/history
  Future<List<Checkin>> getHistory() async {
    await Future.delayed(Duration(milliseconds: 400));

    final list = List<Checkin>.from(_checkins);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  /// Simula GET /hydration/recommendation
  ///
  /// Regra: 35 ml por kg
  Future<double> getHydrationRecommendation(double weightKg) async {
    await Future.delayed(Duration(milliseconds: 350));

    final ml = weightKg * 35;
    final liters = ml / 1000.0;

    return liters;
  }
}
