// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'founder_voice_player.dart';

class _WebFounderVoicePlayer implements FounderVoicePlayer {
  _WebFounderVoicePlayer({required VoidCallback onComplete}) {
    _endedSubscription = _audioElement.onEnded.listen((_) {
      onComplete();
    });
  }

  final html.AudioElement _audioElement = html.AudioElement();
  StreamSubscription<html.Event>? _endedSubscription;
  String? _objectUrl;

  @override
  Future<void> pause() async {
    _audioElement.pause();
  }

  @override
  Future<void> playBytes(Uint8List bytes, {required String mimeType}) async {
    _revokeObjectUrl();
    final blob = html.Blob([bytes], mimeType);
    _objectUrl = html.Url.createObjectUrlFromBlob(blob);
    _audioElement.src = _objectUrl!;
    _audioElement.currentTime = 0;
    await _audioElement.play();
  }

  @override
  Future<void> resume() async {
    await _audioElement.play();
  }

  @override
  Future<void> stop() async {
    _audioElement.pause();
    _audioElement.currentTime = 0;
  }

  @override
  void dispose() {
    _endedSubscription?.cancel();
    _audioElement.pause();
    _revokeObjectUrl();
  }

  void _revokeObjectUrl() {
    final objectUrl = _objectUrl;
    if (objectUrl == null) {
      return;
    }
    html.Url.revokeObjectUrl(objectUrl);
    _objectUrl = null;
  }
}

FounderVoicePlayer createFounderVoicePlayer({
  required VoidCallback onComplete,
}) {
  return _WebFounderVoicePlayer(onComplete: onComplete);
}
