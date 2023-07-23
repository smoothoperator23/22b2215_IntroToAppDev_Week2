import 'package:flutter/material.dart';

void main() => runApp(BudgetTrackerApp());

class BudgetTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Food', total: 100),
    Category(name: 'Transportation', total: 200),
    Category(name: 'Entertainment', total: 50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfo(),
          ExpenseTotal(),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryItem(
                  category: categories[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpenseScreen(category: categories[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace with actual user information
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text('User Information'),
    );
  }
}

class ExpenseTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace with actual expense total calculation
    double total = 350.0;

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Total Expense: \$${total.toStringAsFixed(2)}',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Category {
  final String name;
  final double total;

  Category({required this.name, required this.total});
}

class CategoryItem extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  CategoryItem({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      subtitle: Text('Total: \$${category.total.toStringAsFixed(2)}'),
      onTap: onTap,
    );
  }
}

class ExpenseScreen extends StatelessWidget {
  final Category category;

  ExpenseScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: ListView(
        children: [
          // Replace with expense items
          ExpenseItem(value: 20.0, description: 'Lunch'),
          ExpenseItem(value: 30.0, description: 'Dinner'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => AddExpensePopup(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final double value;
  final String description;

  ExpenseItem({required this.value, required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(value.toStringAsFixed(0)),
      ),
      title: Text(description),
      subtitle: Text('\$${value.toStringAsFixed(2)}'),
    );
  }
}

class AddExpensePopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Expense Value'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Perform expense addition logic
              Navigator.pop(context);
            },
            child: Text('Add Expense'),
          ),
        ],
      ),
    );
  }
}
