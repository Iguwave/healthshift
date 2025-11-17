// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';

import '../models/checkin.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<_DashboardData> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
  }

  Future<_DashboardData> _loadData() async {
    Checkin? today = await ApiService.instance.getTodayCheckin();
    double? hydration;

    if (today?.weight != null) {
      hydration = await ApiService.instance.getHydrationRecommendation(
        today!.weight!,
      );
    }

    return _DashboardData(todayCheckin: today, hydrationLiters: hydration);
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard do Turno')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<_DashboardData>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView(
                children: [
                  SizedBox(height: 200),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }

            if (snapshot.hasError) {
              return ListView(
                children: [
                  SizedBox(height: 200),
                  Center(child: Text('Erro ao carregar: ${snapshot.error}')),
                ],
              );
            }

            final data = snapshot.data;

            if (data == null || data.todayCheckin == null) {
              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Text(
                    'Nenhum check-in encontrado para hoje.\n\nRegistre seu turno na aba "Check-in".',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            }

            final Checkin today = data.todayCheckin!;
            final hydration = data.hydrationLiters;

            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(Icons.sentiment_satisfied),
                    title: Text('Humor de hoje'),
                    subtitle: Text('${today.mood} de 5'),
                  ),
                ),
                SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.battery_alert),
                    title: Text('Fadiga de hoje'),
                    subtitle: Text('${today.fatigue} de 5'),
                  ),
                ),
                SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.local_drink),
                    title: Text('Hidratação recomendada'),
                    subtitle: hydration != null
                        ? Text('${hydration.toStringAsFixed(2)} L de água')
                        : Text('Informe seu peso no check-in.'),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Lembre-se de fazer pausas e se hidratar 💧',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DashboardData {
  final Checkin? todayCheckin;
  final double? hydrationLiters;

  _DashboardData({required this.todayCheckin, required this.hydrationLiters});
}
