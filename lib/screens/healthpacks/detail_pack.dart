import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/api/local_data.dart';

void showHealthPackDetails(
  BuildContext context, {
  required String cardId,
  required String title,
  required String preprice,
  required String price,
  required String desc,
  required List tests,
  required String svgAsset,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 3,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final selectedIds = tests;
      final filteredChecks = healthChecks
          .where((checkup) => selectedIds.contains(checkup['id']))
          .toList();

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handlebar for BottomSheet
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003580),
                ),
              ),
              const SizedBox(height: 8),

              // Price Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹$price",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₹$preprice",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Book Now Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Example booking logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Booking confirmed!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003580),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text("Book now"),
              ),
              const SizedBox(height: 12),

              // Info Section
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.home, color: Color(0xFF003580)),
                      SizedBox(width: 8),
                      Text("Home Sample Collection Available"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Reports in",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("15 Hours"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Description
              const Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(desc),
              const SizedBox(height: 12),

              // What is it for?
              const Text(
                "What is it for?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              // List of Tests (Fixed)
              SizedBox(
                height: filteredChecks.length *
                    55.0, // Dynamic height for better UX
                child: ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevents inner scrolling
                  itemCount: filteredChecks.length,
                  itemBuilder: (context, index) {
                    final checkup = filteredChecks[index];
                    return ListTile(
                      title: Text(checkup['title']),
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green.shade600,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Sample Type
              const Text(
                "Sample Type",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text("Urine and Blood"),
            ],
          ),
        ),
      );
    },
  );
}
