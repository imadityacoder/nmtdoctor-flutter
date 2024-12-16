import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';

class ReceiptsContent extends StatelessWidget {
  const ReceiptsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nmtdAppbar(),
      bottomNavigationBar:const NmtdNavbar(),
      body:const Center(
        child: Text('Receipts Screen'),
      ),
    );
  }
}