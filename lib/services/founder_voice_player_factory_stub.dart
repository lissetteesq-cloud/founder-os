import 'package:flutter/widgets.dart';

import 'founder_voice_player.dart';

FounderVoicePlayer createFounderVoicePlayer({
  required VoidCallback onComplete,
}) {
  throw UnsupportedError('Voice playback is not supported on this platform.');
}
