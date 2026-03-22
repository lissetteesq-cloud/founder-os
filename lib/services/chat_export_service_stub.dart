Future<String> exportTranscript({
  required String filename,
  required String contents,
}) async {
  throw UnsupportedError(
    'Transcript export is not supported on this platform.',
  );
}
