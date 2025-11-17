// lib/screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/checkin.dart';
import '../services/api_service.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Checkin>> _future;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  @override
  void initState() {
    super.initState();
    _future = ApiService.instance.getHistory();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = ApiService.instance.getHistory();
    });
  }

  String _moodEmoji(int mood) {
    switch (mood) {
      case 1:
        return '😞';
      case 2:
        return '🙁';
      case 3:
        return '😐';
      case 4:
        return '🙂';
      case 5:
        return '😄';
      default:
        return '😐';
    }
  }

  String _fatigueLabel(int fatigue) {
    switch (fatigue) {
      case 1:
        return 'Descansado';
      case 2:
        return 'Ok';
      case 3:
        return 'Cansado';
      case 4:
        return 'Bem cansado';
      case 5:
        return 'Exausto';
      default:
        return 'Desconhecido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Histórico')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Checkin>>(
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
              return Center(
                child: Text('Erro ao carregar histórico: ${snapshot.error}'),
              );
            }

            final data = snapshot.data ?? [];

            if (data.isEmpty) {
              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Text(
                    'Nenhum check-in registrado ainda.\n\n'
                    'Faça seu primeiro registro na aba de Check-in!',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: EdgeInsets.all(8),
              itemCount: data.length,
              separatorBuilder: (_, __) => Divider(height: 1),
              itemBuilder: (context, index) {
                final c = data[index];
                return ListTile(
                  leading: Text(
                    _moodEmoji(c.mood),
                    style: TextStyle(fontSize: 24),
                  ),
                  title: Text(_dateFormat.format(c.date)),
                  subtitle: Text(
                    'Humor: ${c.mood}/5  |  Fadiga: ${c.fatigue}/5 (${_fatigueLabel(c.fatigue)})',
                  ),
                  trailing: c.weight != null
                      ? Text('${c.weight!.toStringAsFixed(1)} kg')
                      : null,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
