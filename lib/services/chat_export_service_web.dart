// ignore_for_file: deprecated_member_use

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';

Future<String> exportTranscript({
  required String filename,
  required String contents,
}) async {
  final bytes = utf8.encode(contents);
  final blob = html.Blob([bytes], 'text/markdown;charset=utf-8');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..download = filename
    ..style.display = 'none';

  html.document.body?.children.add(anchor);
  anchor.click();
  anchor.remove();
  html.Url.revokeObjectUrl(url);
  return filename;
}
