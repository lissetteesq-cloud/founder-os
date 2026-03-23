import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/supabase_config.dart';

class FounderOsSyncService {
  FounderOsSyncService._();

  static final FounderOsSyncService instance = FounderOsSyncService._();

  bool _initialized = false;

  bool get isConfigured =>
      SupabaseConfig.url.isNotEmpty && SupabaseConfig.anonKey.isNotEmpty;

  bool get isInitialized => _initialized && isConfigured;

  Future<void> initialize() async {
    if (!isConfigured || _initialized) {
      return;
    }

    try {
      await Supabase.initialize(
        url: SupabaseConfig.url,
        anonKey: SupabaseConfig.anonKey,
        authOptions: const FlutterAuthClientOptions(
          detectSessionInUri: true,
        ),
      );
      await _consumeReturnedAuthLink();
      _initialized = true;
    } catch (error, stackTrace) {
      debugPrint('Founder OS Supabase init failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _consumeReturnedAuthLink() async {
    final uri = Uri.base;
    final client = Supabase.instance.client.auth;

    try {
      if (uri.queryParameters.containsKey('code') ||
          uri.fragment.contains('access_token') ||
          uri.fragment.contains('error_description')) {
        await client.getSessionFromUrl(uri);
        return;
      }

      final tokenHash = uri.queryParameters['token_hash'];
      if (tokenHash == null || tokenHash.isEmpty) {
        return;
      }

      await client.verifyOTP(
        tokenHash: tokenHash,
        type: _otpTypeFromQuery(uri.queryParameters['type']),
      );
    } catch (error, stackTrace) {
      debugPrint('Founder OS auth callback handling failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  OtpType _otpTypeFromQuery(String? rawType) {
    switch (rawType?.toLowerCase()) {
      case 'signup':
        return OtpType.signup;
      case 'invite':
        return OtpType.invite;
      case 'recovery':
        return OtpType.recovery;
      case 'email':
        return OtpType.email;
      case 'email_change':
        return OtpType.emailChange;
      case 'magiclink':
      default:
        return OtpType.magiclink;
    }
  }

  Future<Map<String, dynamic>?> fetchWorkspaceState() async {
    if (!isInitialized) {
      return null;
    }

    try {
      final response = await Supabase.instance.client
          .from('fos_workspaces')
          .select('app_state')
          .eq('slug', SupabaseConfig.workspaceSlug)
          .maybeSingle();

      final appState = response?['app_state'];
      if (appState is Map<String, dynamic>) {
        return appState;
      }
    } catch (error, stackTrace) {
      debugPrint('Founder OS Supabase fetch failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }

    return null;
  }

  Future<void> saveWorkspaceState(Map<String, dynamic> state) async {
    if (!isInitialized) {
      return;
    }

    try {
      await Supabase.instance.client.from('fos_workspaces').upsert({
        'slug': SupabaseConfig.workspaceSlug,
        'name': SupabaseConfig.workspaceName,
        'app_state': state,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }, onConflict: 'slug');
    } catch (error, stackTrace) {
      debugPrint('Founder OS Supabase save failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}
