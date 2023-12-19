import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a transaction
  Future<void> addTransaction(String userId, Map<String, dynamic> transactionData) async {
    await _firestore.collection('users/$userId/transactions').add(transactionData);
  }

  // Retrieve transactions
  Stream<QuerySnapshot> getTransactions(String userId) {
    return _firestore.collection('users/$userId/transactions').snapshots();
  }

  // Update a transaction
  Future<void> updateTransaction(String userId, String transactionId, Map<String, dynamic> updatedData) async {
    await _firestore.collection('users/$userId/transactions').doc(transactionId).update(updatedData);
  }

  // Delete a transaction
  Future<void> deleteTransaction(String userId, String transactionId) async {
    await _firestore.collection('users/$userId/transactions').doc(transactionId).delete();
  }

  // Add a category
  Future<void> addCategory(String userId, Map<String, dynamic> categoryData) async {
    await _firestore.collection('users/$userId/categories').add(categoryData);
  }

  // Retrieve categories
  Stream<QuerySnapshot> getCategories(String userId) {
    return _firestore.collection('users/$userId/categories').snapshots();
  }

  // Update a category
  Future<void> updateCategory(String userId, String categoryId, Map<String, dynamic> updatedData) async {
    await _firestore.collection('users/$userId/categories').doc(categoryId).update(updatedData);
  }

  // Delete a category
  Future<void> deleteCategory(String userId, String categoryId) async {
    await _firestore.collection('users/$userId/categories').doc(categoryId).delete();
  }
}
