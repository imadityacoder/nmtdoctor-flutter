import "package:flutter/material.dart";

List<BottomNavigationBarItem> navbarItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(
      Icons.home_rounded,
    ),
    label: 'Home',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.medical_information_outlined),
    activeIcon: Icon(Icons.medical_information_rounded),
    label: 'Checkups',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.shopping_cart_outlined),
    activeIcon: Icon(Icons.shopping_cart),
    label: 'My Cart',
  ),
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.account_circle_outlined,
      weight: 2,
    ),
    activeIcon: Icon(Icons.account_circle_sharp),
    label: 'Profile',
  ),
];
