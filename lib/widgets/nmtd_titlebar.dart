import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget nmtdTitlebar() {
  return Builder(
    builder: (context) {
      return SizedBox(
        height: 65,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    alignment: Alignment
                        .center, // Changed to center for better alignment
                  ),
                  const Text(
                    "Home",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const Divider(
                thickness: 5,
                color: Color.fromARGB(64, 0, 0, 0),
                height: 1,
              ),
            ],
          ),
        ),
      );
    },
  );
}
