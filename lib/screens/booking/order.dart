import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BookingStepper(),
  ));
}

class BookingStepper extends StatefulWidget {
  const BookingStepper({super.key});

  @override
  _BookingStepperState createState() => _BookingStepperState();
}

class _BookingStepperState extends State<BookingStepper> {
  int _currentStep = 0;

  final List<Widget> stepPages = [
    const SelectTestPage(),
    const DateTimePage(),
    const PatientDetailsPage(),
    const ConfirmPaymentPage(),
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
            padding: const EdgeInsets.all(4.0),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) {
                    bool isActive = _currentStep >= index;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Stepper Indicator
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive ? Colors.blue : Colors.black45,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 22,
                            color:
                                isActive ? Colors.white : Colors.grey.shade200,
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
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Back"),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentStep < 3) {
                      setState(() => _currentStep += 1);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003580),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(_currentStep < 3 ? "Continue" : "Place book"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Stepper Titles
final List<String> stepTitles = [
  "Select Test",
  "Date & Time",
  "Patient Details",
  "Confirm & Pay"
];

// Pages for Each Step
class SelectTestPage extends StatelessWidget {
  const SelectTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Choose your test package.", style: TextStyle(fontSize: 16)),
    );
  }
}

class DateTimePage extends StatelessWidget {
  const DateTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Pick a date and time for sample collection.",
          style: TextStyle(fontSize: 16)),
    );
  }
}

class PatientDetailsPage extends StatelessWidget {
  const PatientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Enter patient details for the test.",
          style: TextStyle(fontSize: 16)),
    );
  }
}

class ConfirmPaymentPage extends StatelessWidget {
  const ConfirmPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Confirm details and make payment.",
          style: TextStyle(fontSize: 16)),
    );
  }
}
