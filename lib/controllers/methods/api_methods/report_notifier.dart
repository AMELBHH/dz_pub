import 'dart:convert';
import 'package:dz_pub/api/report.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/statuses/report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

class ReportNotifier extends StateNotifier<ReportState> {
  ReportNotifier() : super(ReportState());

  Future<void> fetchReports() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await http.get(Uri.parse(ServerLocalhostEm.getReports));
      if (response.statusCode == 200) {
        final res = ReportsRes.fromJson(jsonDecode(response.body));
        if (res.status) {
          state = state.copyWith(isLoading: false, reports: res.data);
        } else {
          state = state.copyWith(isLoading: false, errorMessage: res.message);
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error of report: ${response.statusCode}',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> fetchReportsByStatus(int statusId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final url = '${ServerLocalhostEm.getReportsByStatus}?status_id=$statusId';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final res = ReportsRes.fromJson(jsonDecode(response.body));
        if (res.status) {
          state = state.copyWith(isLoading: false, reports: res.data);
        } else {
          state = state.copyWith(isLoading: false, errorMessage: res.message);
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error of report: ${response.statusCode}',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<Map<String, dynamic>?> updateStatus(int reportId, int statusId) async {
    // We don't necessarily want to set the whole screen to loading,
    // maybe handle individual card loading in UI or just show a global indicator.
    // For simplicity, let's just make the call and return the response.
    try {
      final url = ServerLocalhostEm.updateReportStatus;
      final response = await http.post(
        Uri.parse(url),
        body: {
          'report_id': reportId.toString(),
          'status_id': statusId.toString(),
        },
      );

      debugPrint("Update report status response: ${response.body}");

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        if (res['status'] == true) {
          // Refresh the list after update
          await fetchReports();
        }
        return res;
      }
    } catch (e) {
      debugPrint("Update status error: $e");
    }
    return null;
  }

  Future<Map<String, dynamic>?> submitReport({
    required int reporterId,
    required int reportedId,
    required String content,
  }) async {
    try {
      final url =
          '${ServerLocalhostEm.addReport}?reporter_id=$reporterId&reported_id=$reportedId&content=$content';

      debugPrint("Submit report request URL: $url");

      // Using POST as requested, with parameters in the query string
      final response = await http.post(Uri.parse(url));

      debugPrint("Submit report response: ${response.body}");

      Map<String, dynamic> result = {'statusCode': response.statusCode};

      try {
        result['data'] = jsonDecode(response.body);
      } catch (e) {
        debugPrint("Error decoding report response: $e");
      }

      return result;
    } catch (e) {
      debugPrint("Submit report error: $e");
      return {'statusCode': 500, 'error': e.toString()};
    }
  }
}
