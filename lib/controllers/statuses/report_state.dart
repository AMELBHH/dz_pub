import 'package:dz_pub/api/report.dart';

class ReportState {
  final bool isLoading;
  final String? errorMessage;
  final List<Report> reports;

  ReportState({
    this.isLoading = false,
    this.errorMessage,
    this.reports = const [],
  });

  ReportState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Report>? reports,
  }) {
    return ReportState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      reports: reports ?? this.reports,
    );
  }
}
