import 'package:flutter/material.dart';
import '../../../core/services/voice_service.dart';

class VoiceInput extends StatelessWidget {
  final Function(String) onResult;
  final VoiceService _voiceService = VoiceService();

  VoiceInput({required this.onResult});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.mic),
      onPressed: () async {
        String query = await _voiceService.listen();
        onResult(query); // Pass result to parent screen
      },
    );
  }
}