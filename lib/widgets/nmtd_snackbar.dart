import 'package:flutter/material.dart';

class NmtdSnackbar {
  // Enum for different notification types
  static final Map<NoticeType, Color> _typeColors = {
    NoticeType.success: Colors.green.shade500,
    NoticeType.error: Colors.red.shade600,
    NoticeType.warning: Colors.orangeAccent.shade400,
    NoticeType.info: Colors.blue.shade600,
  };

  static void show(
    BuildContext context,
    String message, {
    NoticeType type = NoticeType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: type == NoticeType.info
            ? 60
            : MediaQuery.sizeOf(context).height - 135,
        // Position of the snackbar
        left: 20.0,
        right: 20.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: _typeColors[type],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getIconForType(type),
                  color: Colors.white,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    // Automatically remove the snackbar after the specified duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  // Get an icon based on the notice type
  static IconData _getIconForType(NoticeType type) {
    switch (type) {
      case NoticeType.success:
        return Icons.check_circle;
      case NoticeType.error:
        return Icons.error;
      case NoticeType.warning:
        return Icons.warning_rounded;
      case NoticeType.info:
        return Icons.info;
    }
  }
}

// Enum for the type of snackbar
enum NoticeType {
  success,
  error,
  warning,
  info,
}
