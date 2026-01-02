import 'package:dz_pub/controllers/methods/api_methods/admin_notifier.dart';
import 'package:dz_pub/controllers/statuses/admin_state.dart';
import 'package:flutter_riverpod/legacy.dart';

final adminNotifierProvider = StateNotifierProvider<AdminNotifier, AdminState>((
  ref,
) {
  return AdminNotifier();
});
