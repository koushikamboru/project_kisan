import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../core/services/gemini_service.dart';

class DiseaseDiagnosisScreen extends StatefulWidget {
  @override
  _DiseaseDiagnosisScreenState createState() => _DiseaseDiagnosisScreenState();
}

class _DiseaseDiagnosisScreenState extends State<DiseaseDiagnosisScreen> {
  String _result = '';
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = 'Diagnosing...';
      });
      String diagnosis = await GeminiService.diagnoseDisease(pickedFile.path);
      setState(() {
        _result = diagnosis;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diagnose Crop Disease')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_image != null)
              Image.file(
                _image!,
                height: 250,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_result),
            ),
          ],
        ),
      ),
    );
  }
}
