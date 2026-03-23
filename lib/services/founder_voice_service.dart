import 'dart:convert';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class FounderVoiceReply {
  const FounderVoiceReply({
    required this.audioBase64,
    required this.mimeType,
    required this.voice,
  });

  final String audioBase64;
  final String mimeType;
  final String voice;

  Uint8List get bytes => base64Decode(audioBase64);
}

class FounderVoiceService {
  const FounderVoiceService();

  Future<FounderVoiceReply> synthesize({
    required String text,
    required String voice,
  }) async {
    final response = await Supabase.instance.client.functions.invoke(
      'founder-voice',
      body: {'text': text, 'voice': voice},
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      final error = data['error'];
      final details = data['details'];
      if (error is String && error.isNotEmpty) {
        final detailText = details is String && details.isNotEmpty
            ? ' $details'
            : '';
        throw Exception('$error$detailText');
      }
    }

    if (data is! Map<String, dynamic>) {
      throw const FormatException('Voice response was not valid JSON.');
    }

    final audioBase64 = data['audioBase64'];
    final mimeType = data['mimeType'];
    final resolvedVoice = data['voice'];

    if (audioBase64 is! String || audioBase64.trim().isEmpty) {
      throw const FormatException('Voice response did not include audio.');
    }

    return FounderVoiceReply(
      audioBase64: audioBase64,
      mimeType: mimeType is String && mimeType.isNotEmpty
          ? mimeType
          : 'audio/mpeg',
      voice: resolvedVoice is String && resolvedVoice.isNotEmpty
          ? resolvedVoice
          : voice,
    );
  }
}
