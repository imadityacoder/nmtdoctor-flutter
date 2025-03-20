import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/screens/booking/payment.dart';
import 'package:nmt_doctor_app/screens/booking/selection_address.dart';
import 'package:nmt_doctor_app/screens/booking/selection_datetime.dart';
import 'package:nmt_doctor_app/screens/booking/selection_member.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';

class BookingStepper extends StatefulWidget {
  const BookingStepper({super.key});

  @override
  _BookingStepperState createState() => _BookingStepperState();
}

class _BookingStepperState extends State<BookingStepper> {
  int _currentStep = 0;

  final List<Widget> stepPages = [
    const MemberSelectionScreen(),
    const AddressSelectionScreen(),
    const DateTimeSelectionScreen(),
    const PaymentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nmtdAppbar(
        title: const Text('Booking'),
      ),
      body: Column(
        children: [
          // Custom Stepper
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) {
                    bool isActive = _currentStep >= index;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Stepper Indicator
                        CircleAvatar(
                          radius: isActive ? 18 : 16,
                          backgroundColor:
                              isActive ? Colors.green : Colors.blue,
                          child: isActive
                              ? const Icon(
                                  Icons.check,
                                  size: 20,
                                  color: Colors.white,
                                  weight: 600,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),

                        // Step Title Below Indicator
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            stepTitles[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                                  isActive ? FontWeight.bold : FontWeight.w500,
                              color: isActive
                                  ? Colors.black87
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),

          // Step Content (Dynamic Page)
          Expanded(child: stepPages[_currentStep]),

          // Next & Back Buttons
          _currentStep != 3
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentStep > 0)
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _currentStep -= 1);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(80, 50),
                          ),
                          child: const Text("Back"),
                        ),
                      if (_currentStep > 0)
                        const SizedBox(width: 10), // Space between buttons
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentStep < 3) {
                              setState(() => _currentStep += 1);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003580),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            _currentStep < 3 ? "Continue" : "Place book",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

// Stepper Titles
final List<String> stepTitles = [
  "Patient Details",
  "Address",
  "Date & Time",
  "Confirm & Pay"
];
