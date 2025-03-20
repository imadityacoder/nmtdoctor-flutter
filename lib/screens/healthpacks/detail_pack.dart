import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/api/local_data.dart';
import 'package:nmt_doctor_app/providers/order_provider.dart';
import 'package:nmt_doctor_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

void showHealthPackDetails(
  BuildContext context, {
  required String cardId,
  required String title,
  required String preprice,
  required String price,
  required String desc,
  required List tests, // Ensure it's a List<String>
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
      final selectedIds = tests; // Ensure tests contain correct IDs or titles

      final filteredChecks = healthChecks
          .where((checkup) =>
              selectedIds.contains(checkup['cardId'])) // Match by title
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
                  width: 50,
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
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003580),
                ),
              ),
              const SizedBox(height: 10),

              // Price Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹$price",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.green.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₹$preprice",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red.shade500,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Book Now Button (Now Adds to Cart)
              ElevatedButton(
                onPressed: () {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  Provider.of<OrderProvider>(context, listen: false)
                      .setUserDetails(user: userProvider.userData!);

                  // Add package to cart
                  Provider.of<OrderProvider>(context, listen: false)
                      .setTestPackage(
                    title: title,
                    totalPrice: price,
                    items: tests.map((testId) {
                      final checkup = healthChecks.firstWhere(
                        (checkup) =>
                            checkup['cardId'] ==
                            testId, // Match test ID with checkup's cardId
                        orElse: () => {
                          'title': 'Unknown Test'
                        }, // Default in case of missing match
                      );
                      return {
                        "title": checkup[
                            'title'], // Get test title from filtered checkup
                        "price": "Included",
                      };
                    }).toList(),
                  );

                  context.pop();
                  context.push('/booking');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003580),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text(
                  "Book now",
                  style: TextStyle(fontSize: 16),
                ),
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
                      Text(
                        "Home Sample Collection Available",
                        overflow: TextOverflow.clip,
                      ),
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
                  fontSize: 18,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),

              // What is it for?
              const Text(
                "What is it for?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              // List of Tests
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredChecks.length,
                  itemBuilder: (context, index) {
                    final checkup = filteredChecks[index];
                    return Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.verified_outlined,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          checkup['title'],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
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
                  fontSize: 17,
                ),
              ),
              const Row(
                children: [
                  Card(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Blood"),
                  )),
                  Card(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Urine"),
                  )),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
