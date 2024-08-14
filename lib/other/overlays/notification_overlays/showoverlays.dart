import 'package:flutter/material.dart';

class ShowOverlays {
  OverlayEntry? _overlayEntry;

  void showOverlay(BuildContext context, Widget overlayWidget, {Duration duration = const Duration(seconds: 13)}) {
    final OverlayState overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.1,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent, // Ensure it doesn't affect the background
          child: overlayWidget,
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);

    // Automatically remove the overlay after the specified duration
    Future.delayed(duration, () {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
    });
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
