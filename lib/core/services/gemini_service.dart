import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'config_service.dart';

class GeminiService {
  static final GenerativeModel _model = GenerativeModel(
    model: 'gemini-pro-vision',
    apiKey: ConfigService.apiKey,
  );

  static Future<String> getResponse(String query) async {
    try {
      final response = await _model.generateContent([
        Content.text(query),
      ]);
      return response.text ?? 'No response from API.';
    } catch (e) {
      return "Error: Failed to get response from API. $e";
    }
  }

  static Future<String> diagnoseDisease(String imagePath) async {
    try {
      final prompt =
          TextPart("Identify the disease in the following crop image. Provide the disease name, symptoms, and recommended treatment.");
      final image = File(imagePath);
      final imageBytes = await image.readAsBytes();
      final imagePart = DataPart('image/jpeg', imageBytes);

      final response = await _model.generateContent([
        Content.multi([prompt, imagePart])
      ]);
      return response.text ?? 'No response from API.';
    } catch (e) {
      return "Error: Failed to get response from API. $e";
    }
  }
}
