import 'package:flutter/material.dart';

import 'ClassDetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Classes"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.0,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          // Class numbers start from 1, so we add 1 to the index
          int classNumber = index + 1;
          return InkWell(
            onTap: () {
              // Navigate to another screen when a class is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassDetailsScreen(classNumber: classNumber),
                ),
              );
            },
            child: Card(
              child: Center(
                child: Text(
                  'Class $classNumber',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

