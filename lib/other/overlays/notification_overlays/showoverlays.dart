import 'package:flutter/material.dart';

class ShowOverlays {
  void showOverlay(BuildContext context, Widget overlayWidget, {Duration duration = const Duration(seconds: 3)}) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;
     overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.11,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,

        child: GestureDetector(
            onTap: (){
        overlayEntry?.remove();
            },
            child: overlayWidget),
      ),
    );

    overlayState.insert(overlayEntry);

  //   Future.delayed(duration, () {
  //     overlayEntry.remove();
  //   });
  // }
}}
