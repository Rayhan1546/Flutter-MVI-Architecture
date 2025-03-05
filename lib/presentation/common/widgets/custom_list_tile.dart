import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isThreeLine;
  final bool dense;
  final EdgeInsetsGeometry? contentPadding;
  final Color? tileColor;
  final Color? selectedTileColor;
  final bool selected;
  final ShapeBorder? shape;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool enabled;
  final double elevation;
  final Color? cardColor;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.isThreeLine = false,
    this.dense = false,
    this.contentPadding,
    this.tileColor,
    this.selectedTileColor,
    this.selected = false,
    this.shape,
    this.titleStyle,
    this.subtitleStyle,
    this.enabled = true,
    this.elevation = 1.0,
    this.cardColor,
    this.margin = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      elevation: elevation,
      color: cardColor,
      margin: margin,
      shape: shape ??
          (borderRadius != null
              ? RoundedRectangleBorder(borderRadius: borderRadius!)
              : null),
      child: InkWell(
        onTap: enabled ? onTap : null,
        onLongPress: enabled ? onLongPress : null,
        child: ListTile(
          title: Text(
            title,
            style: titleStyle ??
                theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: subtitleStyle ?? theme.textTheme.bodyMedium,
                )
              : null,
          leading: leading,
          trailing: trailing,
          isThreeLine: isThreeLine,
          dense: dense,
          contentPadding: contentPadding,
          tileColor: tileColor,
          selectedTileColor: selectedTileColor,
          selected: selected,
          enabled: enabled,
        ),
      ),
    );
  }
}
