import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/api/local_data.dart';
import 'package:nmt_doctor_app/providers/order_provider.dart';
import 'package:nmt_doctor_app/widgets/builders.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';

import 'package:provider/provider.dart';

class HealthPacksContent extends StatelessWidget {
  const HealthPacksContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nmtdAppbar(
        title: const Text(
          'Health Packages',
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: healthPacks.length,
        itemBuilder: (context, index) {
          final testPack = healthPacks[index];

          return buildHealthPackItem(
            cardId: testPack['cardId'] ?? '',
            title: testPack['title'] ?? 'No Title',
            desc: testPack['description'] ?? 'No Description',
            tests: testPack['tests'] ?? [],
            svgAsset: testPack['svgAsset'] ?? 'assets/default.svg',
            preprice: testPack['preprice'] ?? '0',
            price: testPack['price'] ?? '0',
            onTap: () => packagePlaceOrder(context, testPack),
          );
        },
      ),
    );
  }
}

void packagePlaceOrder(BuildContext context, Map<String, dynamic> package) {
  final orderProvider = Provider.of<OrderProvider>(context, listen: false);

  orderProvider.setTestPackage(
    title: package['title'] ?? "Custom Package",
    totalPrice: package['price'] ?? '0',
    items: (package['tests'] as List<dynamic>?)
            ?.map((test) => {
                  "title": test,
                  "price":
                      "Included", // Since it's a package, individual tests don't have prices
                })
            .toList() ??
        [],
  );

  context.pop();
  context.push('/booking'); // Navigate to orders page
}
