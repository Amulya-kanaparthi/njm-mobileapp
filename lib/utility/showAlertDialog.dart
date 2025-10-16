import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';

enum DialogType { continueCreatingAccount, done, ok, cancel, login }

class AlertDialogHelper {
  ///  Simple alert with only one button (like your basicNonActionAlert)
  static Future<void> showBasicAlert({
    required BuildContext context,
    required String title,
    required String message,
    DialogType buttonType = DialogType.ok,
  }) async {
    final buttonLabel = _getButtonText(buttonType);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              buttonLabel,
              style: TextStyle(color: _getButtonColor(context, buttonType)),
            ),
          ),
        ],
      ),
    );
  }

  /// Alert with multiple buttons and action handlers (like basicActionAlert)
  static Future<void> showActionAlert({
    required BuildContext context,
    required String? title,
    required String message,
    required List<DialogType> actions,
    required void Function(DialogType) onActionPressed,
  }) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: (title != null && title.isNotEmpty)
            ? Text(title, style: const TextStyle(fontWeight: FontWeight.bold))
            : null,
        content: Text(message),
        actions: actions.map((action) {
          return TextButton(
            onPressed: () {
              onActionPressed(action);
            },
            child: Text(
              _getButtonText(action),
              style: TextStyle(
                color: _getButtonColor(context, action),
                fontSize: action == DialogType.continueCreatingAccount
                    ? 12
                    : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  ///  Helper: get button text
  static String _getButtonText(DialogType type) {
    switch (type) {
      case DialogType.continueCreatingAccount:
        return DialogConstants.continueCreatingAccount.toUpperCase();
      case DialogType.done:
        return DialogConstants.done;
      case DialogType.ok:
        return DialogConstants.ok;
      case DialogType.cancel:
        return DialogConstants.cancel;
      case DialogType.login:
        return DialogConstants.login;
    }
  }

  ///  Helper: color for button
  static Color _getButtonColor(BuildContext context, DialogType type) {
    switch (type) {
      case DialogType.continueCreatingAccount:
        return Color.fromARGB(255, 131, 35, 28);
      default:
        return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    }
  }
}
