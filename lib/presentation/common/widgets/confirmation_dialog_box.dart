import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/widgets/custom_elevated_button.dart';
import 'package:github_repo_list/presentation/common/widgets/custom_outlined_button.dart';

class ConfirmationDialogBox extends StatelessWidget {
  final String title;
  final String subTitle;
  final String rightBtnText;
  final String leftBtnText;
  final VoidCallback onTapRightBtn;
  final VoidCallback onTapLeftBtn;
  final IconData? icon;

  const ConfirmationDialogBox({
    super.key,
    required this.title,
    required this.subTitle,
    required this.rightBtnText,
    required this.leftBtnText,
    required this.onTapRightBtn,
    required this.onTapLeftBtn,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: colorScheme.error,
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              title,
              style: textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              subTitle,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.grey[30],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    text: leftBtnText,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onTapLeftBtn();
                    },
                    isFullWidth: true,
                    height: 48.0,
                    borderColor: colorScheme.primary.withAlpha(128),
                    borderRadius: 12.0,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomElevatedButton(
                    text: rightBtnText,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onTapRightBtn();
                    },
                    isFullWidth: true,
                    height: 48.0,
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    borderRadius: 12.0,
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
