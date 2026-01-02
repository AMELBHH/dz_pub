import 'package:dz_pub/api/report.dart';
import 'package:dz_pub/controllers/providers/report_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportManagementScreen extends ConsumerStatefulWidget {
  const ReportManagementScreen({super.key});

  @override
  ConsumerState<ReportManagementScreen> createState() =>
      _ReportManagementScreenState();
}

class _ReportManagementScreenState
    extends ConsumerState<ReportManagementScreen> {
  int? selectedStatusId;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(reportNotifierProvider.notifier).fetchReports(),
    );
  }

  void filterReports(int? statusId) {
    setState(() {
      selectedStatusId = statusId;
    });
    if (statusId == null) {
      ref.read(reportNotifierProvider.notifier).fetchReports();
    } else {
      ref.read(reportNotifierProvider.notifier).fetchReportsByStatus(statusId);
    }
  }

  String getStatusLabel(int? id) {
    switch (id) {
      case 1:
        return 'قيد الانتظار';
      case 2:
        return 'تمت المراجعة';
      case 3:
        return 'تم الحل';
      case 4:
        return 'مرفوض';
      default:
        return 'غير معروف';
    }
  }

  Color getStatusColor(int? id) {
    switch (id) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reportState = ref.watch(reportNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('إدارة البلاغات', style: AppTextStyle.textStyle),
        centerTitle: true,
        backgroundColor: AppColors.premrayColor,
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: reportState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : reportState.errorMessage != null
                ? Center(
                    child: Text(
                      reportState.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : reportState.reports.isEmpty
                ? const Center(child: Text('لا توجد بلاغات حالياً'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: reportState.reports.length,
                    itemBuilder: (context, index) {
                      return _ReportCard(report: reportState.reports[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _FilterChip(
            label: 'الكل',
            isSelected: selectedStatusId == null,
            onTap: () => filterReports(null),
          ),
          _FilterChip(
            label: 'قيد الانتظار',
            isSelected: selectedStatusId == 1,
            onTap: () => filterReports(1),
          ),
          _FilterChip(
            label: 'تمت المراجعة',
            isSelected: selectedStatusId == 2,
            onTap: () => filterReports(2),
          ),
          _FilterChip(
            label: 'تم الحل',
            isSelected: selectedStatusId == 3,
            onTap: () => filterReports(3),
          ),
          _FilterChip(
            label: 'مرفوض',
            isSelected: selectedStatusId == 4,
            onTap: () => filterReports(4),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black87),
        ),
        selected: isSelected,
        selectedColor: AppColors.premrayColor,
        onSelected: (_) => onTap(),
      ),
    );
  }
}

class _ReportCard extends ConsumerStatefulWidget {
  final Report report;

  const _ReportCard({required this.report});

  @override
  ConsumerState<_ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends ConsumerState<_ReportCard> {
  bool isUpdating = false;

  String getStatusLabel(int? id) {
    switch (id) {
      case 1:
        return 'قيد الانتظار';
      case 2:
        return 'تمت المراجعة';
      case 3:
        return 'تم الحل';
      case 4:
        return 'مرفوض';
      default:
        return 'غير معروف';
    }
  }

  Color getStatusColor(int? id) {
    switch (id) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'بلاغ رقم: #${widget.report.id}',
                  style: AppTextStyle.black19.copyWith(fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(
                      widget.report.reportStatusId,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    getStatusLabel(widget.report.reportStatusId),
                    style: TextStyle(
                      color: getStatusColor(widget.report.reportStatusId),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildUserRow(
              'المُبلّغ:',
              widget.report.reporter?.name ?? 'غير معروف',
            ),
            const SizedBox(height: 8),
            _buildUserRow(
              'المُبلّغ عنه:',
              widget.report.reported?.name ?? 'غير معروف',
            ),
            const SizedBox(height: 12),
            Text(
              'المحتوى:',
              style: AppTextStyle.titel.copyWith(color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.report.content ?? 'لا يوجد محتوى',
                style: const TextStyle(height: 1.5),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isUpdating)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.premrayColor,
                      ),
                    ),
                  )
                else
                  TextButton.icon(
                    onPressed: () => _showStatusDialog(context),
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('تغيير الحالة'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.premrayColor,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(width: 8),
        Text(value, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  void _showStatusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تغيير حالة البلاغ', textAlign: TextAlign.center),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _statusOption(context, 1, 'قيد الانتظار', Colors.orange),
              _statusOption(context, 2, 'تمت المراجعة', Colors.blue),
              _statusOption(context, 3, 'تم الحل', Colors.green),
              _statusOption(context, 4, 'مرفوض', Colors.red),
            ],
          ),
        );
      },
    );
  }

  Widget _statusOption(
    BuildContext context,
    int id,
    String label,
    Color color,
  ) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      leading: Icon(Icons.circle, color: color, size: 16),
      onTap: () async {
        Navigator.pop(context);

        setState(() => isUpdating = true);

        final res = await ref
            .read(reportNotifierProvider.notifier)
            .updateStatus(widget.report.id ?? 0, id);

        if (!mounted) return;

        setState(() => isUpdating = false);

        if (res != null && res['status'] == true) {
          ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(
              content: Text(res['message'] ?? 'تم تحديث حالة البلاغ بنجاح'),
            ),
          );
        } else {
          ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(
              content: Text(res?['message'] ?? 'فشل في تحديث حالة البلاغ'),
            ),
          );
        }
      },
    );
  }
}
