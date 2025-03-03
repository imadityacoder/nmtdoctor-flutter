import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
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
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'relation': relation,
    };
  }

  static FamilyMember fromMap(Map<String, dynamic> map) {
    return FamilyMember(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      relation: map['relation'],
    );
  }
}

// Family Member Provider using Appwrite & Provider
class FamilyMemberProvider extends ChangeNotifier {
  late final Databases _databases;
  late final Account _account;
  final String _databaseId =
      "67bd478e001b531435c6"; // Replace with actual database ID
  final String _collectionId =
      "67beb26a0018a5f9a99e"; // Replace with actual collection ID

  FamilyMemberProvider({Databases? databases, Account? account}) {
    _databases = databases ?? Databases(Client());
    _account = account ?? Account(Client());
  }

  Future<String?> get _uid async {
    try {
      models.User user = await _account.get();
      return user.$id;
    } catch (e) {
      return null;
    }
  }

  // Add a family member under the user's UID
  Future<void> addFamilyMember(FamilyMember member) async {
    String? uid = await _uid;
    if (uid == null) return;

    await _databases.createDocument(
      databaseId: _databaseId,
      collectionId: _collectionId,
      documentId: member.id,
      data: member.toMap(),
      permissions: [
        Permission.read("user:$uid"),
        Permission.update("user:$uid"),
        Permission.delete("user:$uid"),
      ],
    );
    notifyListeners();
  }

  // Update a family member
  Future<void> updateFamilyMember(FamilyMember member) async {
    await _databases.updateDocument(
      databaseId: _databaseId,
      collectionId: _collectionId,
      documentId: member.id,
      data: member.toMap(),
    );
    notifyListeners();
  }

  // Delete a family member
  Future<void> deleteFamilyMember(String memberId) async {
    await _databases.deleteDocument(
      databaseId: _databaseId,
      collectionId: _collectionId,
      documentId: memberId,
    );
    notifyListeners();
  }

  // Fetch all family members for the logged-in user
  Future<List<FamilyMember>> getFamilyMembers() async {
    String? uid = await _uid;
    if (uid == null) return [];

    final response = await _databases.listDocuments(
      databaseId: _databaseId,
      collectionId: _collectionId,
    );

    return response.documents
        .map((doc) => FamilyMember.fromMap(doc.data))
        .toList();
  }
}
