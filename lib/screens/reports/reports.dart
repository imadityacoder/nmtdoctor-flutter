import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';

class ReportsContent extends StatelessWidget {
  const ReportsContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data for reports
    final List<Map<String, String>> reports = [
      {'title': 'report 1', 'image': 'assets/images/sudo-report.png'},
      {'title': 'report 2', 'image': 'assets/images/sudo-report.png'},
      {'title': 'report 3', 'image': 'assets/images/sudo-report.png'},
      {'title': 'report 4', 'image': 'assets/images/sudo-report.png'},
      {'title': 'report 5', 'image': 'assets/images/sudo-report.png'},
      {'title': 'report 6', 'image': 'assets/images/sudo-report.png'},
    ];

    return Scaffold(
      appBar: nmtdAppbar(
        title: const Text(
          'My Reports',
          
        ),
      ),
      bottomNavigationBar: const NmtdNavbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.8, // Adjust for image height
          ),
          itemCount: reports.length,
          itemBuilder: (context, index) {
            final report = reports[index];
            return Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${report['title']} tapped!'),
                    ),
                  );
                  // Navigate or perform actions for this report
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10.0),
                        ),
                        child: Image.asset(
                          report['image'] ?? '',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        report['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
