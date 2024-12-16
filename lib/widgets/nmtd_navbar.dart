import "package:flutter/material.dart";

List<BottomNavigationBarItem> navbarItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_sharp),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information_outlined),
            activeIcon: Icon(Icons.medical_information_sharp),
            label: 'Checkups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'My Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo_outlined),
            activeIcon: Icon(Icons.add_a_photo_rounded),
            label: 'Add Receipt',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle_sharp),
            label: 'Profile',
          ),
        ];

