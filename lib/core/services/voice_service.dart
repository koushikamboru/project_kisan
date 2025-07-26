import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class VoiceService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  Future<String> listen() async {
    bool available = await _speech.initialize();
    if (!available) return '';

    final completer = Completer<String>();
    _speech.listen(
      onResult: (result) {
        if (!completer.isCompleted) {
          completer.complete(result.recognizedWords);
        }
      },
    );

    // Wait for result or timeout after 5 seconds
    return completer.future.timeout(const Duration(seconds: 5), onTimeout: () {
      _speech.stop();
      return '';
    });
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }
}