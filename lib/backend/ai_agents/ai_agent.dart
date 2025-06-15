import 'package:flutter/material.dart';
import 'firebase_vertexai_agent.dart';
import '/gymhub/gymhub_util.dart';

Future<dynamic> callAiAgent({
  required BuildContext context,
  required String prompt,
  String? imageUrl,
  FFUploadedFile? imageAsset,
  String? audioUrl,
  FFUploadedFile? audioAsset,
  String? videoUrl,
  FFUploadedFile? videoAsset,
  String? pdfUrl,
  FFUploadedFile? pdfAsset,
  required String threadId,
  required String agentCloudFunctionName,
  required String provider,
  String? agentJson,
  required String responseType,
}) async {
  try {
    switch (provider) {
      case 'GOOGLE':
        if (agentJson == null) {
          throw Exception('Configuración del agente necesaria para Google AI');
        }
        final parsedJson = jsonDecode(agentJson) as Map<String, dynamic>;
        return await ChatManager().sendMessage(
          prompt,
          threadId,
          parsedJson,
          imageUrl: imageUrl,
          imageAsset: imageAsset,
          audioUrl: audioUrl,
          audioAsset: audioAsset,
          videoUrl: videoUrl,
          videoAsset: videoAsset,
          pdfUrl: pdfUrl,
          pdfAsset: pdfAsset,
        );

      default:
        showSnackbar(
          context,
          'Proveedor de IA no compatible: $provider}',
        );
        return null;
    }
  } catch (e) {
    showSnackbar(
      context,
      'Error: ${e.toString()}',
    );
    return null;
  }
}

void clearAiChat(String threadId, String provider) {
  switch (provider) {
    case 'GOOGLE':
      ChatManager().clearChat(threadId);
      break;

    default:
      break;
  }
}
