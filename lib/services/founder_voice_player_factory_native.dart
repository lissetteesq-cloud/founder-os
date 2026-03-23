import 'dart:async';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

import 'founder_voice_player.dart';

class _NativeFounderVoicePlayer implements FounderVoicePlayer {
  _NativeFounderVoicePlayer({required VoidCallback onComplete}) {
    _completeSubscription = _audioPlayer.onPlayerComplete.listen((_) {
      onComplete();
    });
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription<void>? _completeSubscription;

  @override
  Future<void> pause() => _audioPlayer.pause();

  @override
  Future<void> playBytes(Uint8List bytes, {required String mimeType}) {
    return _audioPlayer.play(BytesSource(bytes));
  }

  @override
  Future<void> resume() => _audioPlayer.resume();

  @override
  Future<void> stop() => _audioPlayer.stop();

  @override
  void dispose() {
    _completeSubscription?.cancel();
    _audioPlayer.dispose();
  }
}

FounderVoicePlayer createFounderVoicePlayer({
  required VoidCallback onComplete,
}) {
  return _NativeFounderVoicePlayer(onComplete: onComplete);
}
