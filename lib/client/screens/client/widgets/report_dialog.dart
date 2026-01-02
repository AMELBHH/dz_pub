import 'package:dz_pub/controllers/providers/report_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportDialog extends ConsumerStatefulWidget {
  final int reportedId;

  const ReportDialog({super.key, required this.reportedId});

  @override
  ConsumerState<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends ConsumerState<ReportDialog> {
  final TextEditingController _contentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'إبلاغ عن هذا الحساب',
        textAlign: TextAlign.center,
        style: AppTextStyle.titel,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _contentController,
            maxLines: 4,
            style: AppTextStyle.descriptionText,
            decoration: InputDecoration(
              hintText: 'اكتب سبب الإبلاغ هنا...',
              hintStyle: AppTextStyle.descriptionText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.premrayColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isSubmitting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  'إرسال البلاغ',
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('يرجى كتابة سبب الإبلاغ')));
      return;
    }

    setState(() => _isSubmitting = true);

    final reporterId = NewSession.get(PrefKeys.id, 0);
    final res = await ref
        .read(reportNotifierProvider.notifier)
        .submitReport(
          reporterId: reporterId,
          reportedId: widget.reportedId,
          content: _contentController.text.trim(),
        );

    if (!mounted) return;

    setState(() => _isSubmitting = false);
    Navigator.pop(context);

    final statusCode = res?['statusCode'] ?? 0;
    final isSuccess = statusCode >= 200 && statusCode < 400;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          res?['data']?['message'] ??
              (isSuccess ? 'تم إرسال البلاغ بنجاح' : 'فشل في إرسال البلاغ'),
        ),
      ),
    );
  }
}
