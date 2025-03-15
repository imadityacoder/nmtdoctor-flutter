import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/api/local_data.dart';
import 'package:nmt_doctor_app/providers/hc_cart_provider.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/widgets/builders.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';
import 'package:provider/provider.dart';

class HealthPacksContent extends StatelessWidget {
  const HealthPacksContent({super.key});

  @override
  Widget build(BuildContext context) {
    final hcCartProvider = Provider.of<HcCartProvider>(context, listen: false);

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
            onTap: () {
              hcCartProvider.addToCartById(testPack['cardId']);
              NmtdSnackbar.show(context, "Health pack added to cart!",
                  type: NoticeType.success);
              context.push('/cart');
            },
          );
        },
      ),
    );
  }
}
