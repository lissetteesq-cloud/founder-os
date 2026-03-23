import 'package:flutter/foundation.dart';

import 'founder_voice_player.dart';
import 'founder_voice_service.dart';

class FounderVoicePlaybackController extends ChangeNotifier {
  FounderVoicePlaybackController._() {
    _player = createVoicePlayer(onComplete: _handlePlaybackComplete);
  }

  static final FounderVoicePlaybackController instance =
      FounderVoicePlaybackController._();

  final FounderVoiceService _voiceService = const FounderVoiceService();
  late final FounderVoicePlayer _player;

  void _handlePlaybackComplete() {
      _isPlaying = false;
      notifyListeners();
  }

  Uint8List? _audioBytes;
  String _mimeType = 'audio/mpeg';
  String _voice = 'nova';
  String _title = 'Tutor reply';
  bool _isVisible = false;
  bool _isLoading = false;
  bool _isPlaying = false;
  bool _hasStartedPlayback = false;
  String? _error;

  String get voice => _voice;
  String get title => _title;
  bool get isVisible => _isVisible;
  bool get isLoading => _isLoading;
  bool get isPlaying => _isPlaying;
  bool get hasAudio => _audioBytes != null;
  String? get error => _error;

  Future<void> loadReply({
    required String text,
    required String voice,
    required String title,
    bool autoPlay = false,
  }) async {
    _isVisible = true;
    _isLoading = true;
    _error = null;
    _title = title;
    _voice = voice;
    notifyListeners();

    try {
      final reply = await _voiceService.synthesize(text: text, voice: voice);
      _audioBytes = Uint8List.fromList(reply.bytes);
      _mimeType = reply.mimeType;
      _voice = reply.voice;
      _hasStartedPlayback = false;
      _isLoading = false;
      notifyListeners();

      if (autoPlay) {
        await play();
      }
    } catch (error) {
      _isLoading = false;
      _isPlaying = false;
      _error = error.toString();
      notifyListeners();
    }
  }

  Future<void> play() async {
    if (_audioBytes == null) return;
    _error = null;
    notifyListeners();

    try {
      if (_isPlaying) {
        return;
      }

      if (_hasStartedPlayback) {
        await _player.resume();
      } else {
        await _player.playBytes(_audioBytes!, mimeType: _mimeType);
        _hasStartedPlayback = true;
      }
      _isPlaying = true;
      notifyListeners();
    } catch (error) {
      _isPlaying = false;
      _error = error.toString();
      notifyListeners();
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
    } finally {
      _isPlaying = false;
      notifyListeners();
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } finally {
      _isPlaying = false;
      _hasStartedPlayback = false;
      notifyListeners();
    }
  }

  Future<void> replay() async {
    if (_audioBytes == null) return;
    _error = null;
    try {
      await _player.stop();
      await _player.playBytes(_audioBytes!, mimeType: _mimeType);
      _hasStartedPlayback = true;
      _isPlaying = true;
      notifyListeners();
    } catch (error) {
      _isPlaying = false;
      _error = error.toString();
      notifyListeners();
    }
  }

  Future<void> dismiss() async {
    await stop();
    _audioBytes = null;
    _isVisible = false;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}
