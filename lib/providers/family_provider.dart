import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Family Member Model
class FamilyMember {
  String id;
  String name;
  int age;
  String gender;
  String relation;

  FamilyMember({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.relation,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'relation': relation,
    };
  }

  static FamilyMember fromMap(String id, Map<String, dynamic> map) {
    return FamilyMember(
      id: id,
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      relation: map['relation'],
    );
  }
}

// Family Member Provider using Firebase & Provider
class FamilyMemberProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser?.uid ?? '';

  // Add a family member under the user's UID
  Future<void> addFamilyMember(FamilyMember member) async {
    if (_uid.isEmpty) return;

    await _firestore.collection('family_members').doc(_uid).update({
      member.id: member.toMap(),
    }).catchError((_) async {
      await _firestore.collection('family_members').doc(_uid).set({
        member.id: member.toMap(),
      });
    });

    notifyListeners();
  }

  // Update a family member
  Future<void> updateFamilyMember(FamilyMember member) async {
    if (_uid.isEmpty) return;

    await _firestore.collection('family_members').doc(_uid).update({
      member.id: member.toMap(), // Updates the specific member details
    });

    notifyListeners();
  }

  // Delete a family member
  Future<void> deleteFamilyMember(String memberId) async {
    if (_uid.isEmpty) return;

    await _firestore.collection('family_members').doc(_uid).update({
      memberId: FieldValue.delete(),
    });

    notifyListeners();
  }

  // Fetch all family members for the logged-in user
  Stream<List<FamilyMember>> getFamilyMembers() {
    if (_uid.isEmpty) return const Stream.empty();

    return _firestore
        .collection('family_members')
        .doc(_uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return [];

      final data = snapshot.data()!;
      return data.entries
          .map((entry) => FamilyMember.fromMap(entry.key, entry.value))
          .toList();
    });
  }
}
