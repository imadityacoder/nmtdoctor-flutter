import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';

class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nmtdAppbar(),
      bottomNavigationBar:const NmtdNavbar(),
      body: const Center(
        child: Text('Booking Screen'),
      ),
    );
  }
}