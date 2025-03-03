import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/api/local_data.dart';
import 'package:nmt_doctor_app/widgets/builders.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';

class HealthPacksContent extends StatelessWidget {
  const HealthPacksContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nmtdAppbar(
        title: const Text(
          'Health Packs',
          
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: healthPacks.length,
        itemBuilder: (context, index) {
          final testPack = healthPacks[index];
          return buildHealthPackItem(
            cardId: testPack['cardId'],
            title: testPack['title']!,
            svgAsset: testPack['svgAsset']!,
            preprice: testPack['preprice']!,
            price: testPack['price']!,
            
            onTap: () {},
          );
        },
      ),
    );
  }
}
