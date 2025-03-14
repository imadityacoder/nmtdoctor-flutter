import "package:flutter/material.dart";

List<BottomNavigationBarItem> navbarItems = const [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.medical_information_outlined),
    activeIcon: Icon(Icons.medical_information_rounded),
    label: 'Checkups',
  ),
<<<<<<< HEAD
  const BottomNavigationBarItem(
    icon: Icon(Icons.shopping_cart_outlined),
    activeIcon: Icon(Icons.shopping_cart),
    label: 'My Cart',
=======
  BottomNavigationBarItem(
    icon: Icon(Icons.receipt_long_outlined),
    activeIcon: Icon(Icons.receipt_long),
    label: 'My Reports',
>>>>>>> parent of fb8340f (UI upgraded)
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.account_circle_outlined,weight: 2,),
    activeIcon: Icon(Icons.account_circle_sharp),
    label: 'Profile',
  ),
];
