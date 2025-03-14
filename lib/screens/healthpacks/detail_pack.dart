import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nmt_doctor_app/api/local_data.dart';
import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';

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
=======
// A helper function to show the bottom sheet.
void showDetailPack(BuildContext context) {
>>>>>>> parent of fb8340f (UI upgraded)
  showModalBottomSheet(
    elevation: 4,
    context: context,
    isScrollControlled: true, // Adjusts height when keyboard appears
    isDismissible: true, // Prevents dismissing by tapping outside
    enableDrag: true, // Disables swipe-to-dismiss gesture
    builder: (BuildContext context) {
      return Padding(
<<<<<<< HEAD
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

              // Book Now Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Example booking logic
                  NmtdSnackbar.show(context, "This is now in updating",
                      type: NoticeType.warning);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003580),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text(
                  "Add to cart",
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
                  fontSize: 17,
                ),
              ),
              Text(desc),
              const SizedBox(height: 12),

              // What is it for?
              const Text(
                "What is it for?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              // List of Tests (Fixed)
              SizedBox(
                // Dynamic height for better UX
                child: ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevents inner scrolling
                  itemCount: filteredChecks.length,
                  itemBuilder: (context, index) {
                    final checkup = filteredChecks[index];
                    return ListTile(
                      title: Text(checkup['title']),
                      leading: const Icon(
                        Icons.verified_outlined,
                        color: Colors.green,
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
                  fontSize: 17,
                ),
              ),
              const Row(
                children: [
                  Card(
                      elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Blood"),
                      )),
                  Card(
                      elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Urine"),
                      )),
                ],
              ),
            ],
          ),
=======
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
>>>>>>> parent of fb8340f (UI upgraded)
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
