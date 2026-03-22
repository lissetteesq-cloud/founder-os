import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'founder_voice_service.dart';

class FounderVoicePlaybackController extends ChangeNotifier {
  FounderVoicePlaybackController._() {
    _audioPlayer.onPlayerComplete.listen((_) {
      _isPlaying = false;
      notifyListeners();
    });
  }

  static final FounderVoicePlaybackController instance =
      FounderVoicePlaybackController._();

  final FounderVoiceService _voiceService = const FounderVoiceService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Uint8List? _audioBytes;
  String _voice = 'sage';
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
        await _audioPlayer.resume();
      } else {
        await _audioPlayer.play(BytesSource(_audioBytes!));
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
      await _audioPlayer.pause();
    } finally {
      _isPlaying = false;
      notifyListeners();
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
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
      await _audioPlayer.stop();
      await _audioPlayer.play(BytesSource(_audioBytes!));
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
