// lib/screens/checkin_screen.dart
import 'package:flutter/material.dart';

import '../models/checkin.dart';
import '../services/api_service.dart';

class CheckinScreen extends StatefulWidget {
  CheckinScreen({Key? key}) : super(key: key);

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  int _mood = 3;
  int _fatigue = 3;
  final TextEditingController _weightController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSending) return;

    setState(() {
      _isSending = true;
    });

    double? weight;
    if (_weightController.text.trim().isNotEmpty) {
      weight = double.tryParse(_weightController.text.replaceAll(',', '.'));
    }

    final checkin = Checkin(
      date: DateTime.now(),
      mood: _mood,
      fatigue: _fatigue,
      weight: weight,
    );

    try {
      await ApiService.instance.sendCheckin(checkin);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Check-in enviado com sucesso!')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao enviar check-in: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  Widget _buildSlider({
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $value', style: TextStyle(fontWeight: FontWeight.bold)),
        Slider(
          min: 1,
          max: 5,
          divisions: 4,
          value: value.toDouble(),
          label: value.toString(),
          onChanged: (double v) => onChanged(v.toInt()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Check-in Diário')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSlider(
              label: 'Humor (1 = péssimo, 5 = ótimo)',
              value: _mood,
              onChanged: (v) => setState(() => _mood = v),
            ),
            SizedBox(height: 16),
            _buildSlider(
              label: 'Fadiga (1 = descansado, 5 = exausto)',
              value: _fatigue,
              onChanged: (v) => setState(() => _fatigue = v),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Peso (kg) - opcional',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSending ? null : _submit,
                child: Text(_isSending ? 'Enviando...' : 'Enviar Check-in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
