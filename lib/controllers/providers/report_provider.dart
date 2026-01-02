import 'package:dz_pub/controllers/methods/api_methods/report_notifier.dart';
import 'package:dz_pub/controllers/statuses/report_state.dart';
import 'package:flutter_riverpod/legacy.dart';

final reportNotifierProvider =
    StateNotifierProvider<ReportNotifier, ReportState>((ref) {
      return ReportNotifier();
    });
