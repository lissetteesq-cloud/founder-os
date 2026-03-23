import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'founder_voice_player_factory.dart';

abstract class FounderVoicePlayer {
  Future<void> playBytes(Uint8List bytes, {required String mimeType});
  Future<void> resume();
  Future<void> pause();
  Future<void> stop();
  void dispose();
}

FounderVoicePlayer createVoicePlayer({required VoidCallback onComplete}) {
  return createFounderVoicePlayer(onComplete: onComplete);
}
