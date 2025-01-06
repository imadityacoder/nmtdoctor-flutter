import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nmt_doctor_app/api/local_data.dart';

class TestPackGrid extends StatelessWidget {
  final List<Map<String, dynamic>> testPacks;

  const TestPackGrid({super.key, required this.testPacks});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.7,
      ),
      itemCount: testPacks.length,
      itemBuilder: (context, index) {
        final testPack = testPacks[index];
        return TestPackItem(
          title: testPack['title']!,
          svgAsset: testPack['svgAsset']!,
          preprice: testPack['preprice']!,
          price: testPack['price']!,
          description: testPack['description']!,
          onTap: () {
            print("Booked: ${testPack['title']}");
          },
        );
      },
    );
  }
}

class TestPackItem extends StatelessWidget {
  final String title;
  final String svgAsset;
  final String preprice;
  final String price;
  final String description;
  final VoidCallback onTap;

  const TestPackItem({
    super.key,
    required this.title,
    required this.svgAsset,
    required this.preprice,
    required this.price,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  svgAsset,
                  height: 70,
                  width: 70,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "₹$preprice",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      "₹$price",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 36),
                  ),
                  child: const Text("Book Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HealthPacksContent extends StatelessWidget {
  const HealthPacksContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TestPackGrid(testPacks: healthPacks),
    );
  }
}
