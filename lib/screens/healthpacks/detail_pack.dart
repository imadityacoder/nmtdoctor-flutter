import 'package:flutter/material.dart';
// A helper function to show the bottom sheet.
void showDetailPack(BuildContext context) {
  showModalBottomSheet(
    elevation: 4,
    context: context,
    isScrollControlled: true, // Adjusts height when keyboard appears
    isDismissible: true, // Prevents dismissing by tapping outside
    enableDrag: true, // Disables swipe-to-dismiss gesture
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const DetailPack(),
      );
    },
  );
}


class DetailPack extends StatelessWidget {
  const DetailPack({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
      
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
