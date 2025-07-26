import 'package:flutter/material.dart';
import '../../core/services/gemini_service.dart';

class DiseaseDiagnosisScreen extends StatefulWidget {
  @override
  _DiseaseDiagnosisScreenState createState() => _DiseaseDiagnosisScreenState();
}

class _DiseaseDiagnosisScreenState extends State<DiseaseDiagnosisScreen> {
  final GeminiService _geminiService = GeminiService();
  String _result = '';

  Future<void> _diagnose(String imagePath) async {
    String diagnosis = await _geminiService.diagnoseDisease(imagePath);
    setState(() {
      _result = diagnosis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diagnose Crop Disease')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Implement image picker and call _diagnose with image path
            },
            child: Text('Upload Image'),
          ),
          Text(_result),
        ],
      ),
    );
  }
}