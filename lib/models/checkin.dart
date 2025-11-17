// lib/models/checkin.dart
class Checkin {
  final DateTime date;
  final int mood; // 1 a 5
  final int fatigue; // 1 a 5
  final double? weight; // opcional, para recomendação de hidratação

  Checkin({
    required this.date,
    required this.mood,
    required this.fatigue,
    this.weight,
  });
}
