import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final Color? color;

  const EditButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color:
              (color != null) ? color! : Theme.of(context).colorScheme.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          buttonName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: (color != null)
                    ? color!
                    : Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
    );
  }
}
