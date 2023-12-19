import 'package:demotask/service/firebase_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  String? userId;

  @override
  void initState() {
    super.initState();

    _initializeUser();
  }

  void _initializeUser() {
    // Check if the user is signed in
    if (_auth.currentUser != null) {
      // If the user is signed in, get the user ID
      setState(() {
        userId = _auth.currentUser!.uid;
      });
    } else {
      userId='0';
      // Handle the case where the user is not signed in
      // You might want to navigate to a login screen or take appropriate action
    }
  }

  // Example function to add a transaction when a button is pressed
  void _addTransaction() {
    _firestoreService.addTransaction(userId!, {
      'amount': 50.0,
      'description': 'Example Expense',
      'category': 'Food', // You might want to use the category document reference here
      'date': Timestamp.now(),
    });
  }

  // Example function to add a category when a button is pressed
  void _addCategory() {
    _firestoreService.addCategory(userId!, {
      'name': 'Shopping',
      'icon': 'shopping_icon_url',
    });
  }

  @override
  Widget build(BuildContext context) {
    // Only build the UI if the userId is not null
    if (userId != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Finance'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Your UI components here to display transactions and categories
              StreamBuilder<QuerySnapshot>(
                stream: _firestoreService.getTransactions(userId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> transactions = snapshot.data!.docs;
          
                    // Display the list of transactions
                    return Column(
                      children: [
                        const Text('Transactions:'),
                        for (var transaction in transactions)
                          ListTile(
                            title: Text('Amount: ${transaction['amount']}'),
                            subtitle: Text('Description: ${transaction['description']}'),
                          ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestoreService.getCategories(userId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> categories = snapshot.data!.docs;
          
                    // Display the list of categories
                    return Column(
                      children: [
                        const Text('Categories:'),
                        for (var category in categories)
                          ListTile(
                            title: Text('Name: ${category['name']}'),
                          ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              // Example buttons to add transactions and categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _addTransaction,
                    child: const Text('Add Transaction'),
                  ),
                  ElevatedButton(
                onPressed: _addCategory,
                child: const Text('Add Category'),
              ),
                ],
              ),
              
            ],
          ),
        ),
      );
    } else {
      // Return a loading indicator or navigate to a login screen
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}
