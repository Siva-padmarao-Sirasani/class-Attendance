import 'package:flutter/material.dart';

class ClassDetailsScreen extends StatefulWidget {
  final int classNumber;
  ClassDetailsScreen({required this.classNumber, Key? key}) : super(key: key);

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  Set<int> selectedNumbers = {};
  bool isAbsentMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("${widget.classNumber}"),
      ),
      body: Column(
        children: [
          // Container to display selected numbers
          Container(
            height: 60,
            width: 100,
            color: selectedNumbers.isNotEmpty ? Colors.green : Colors.red,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedNumbers.isNotEmpty ? 'Present' : 'Absent',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Icon(
                    selectedNumbers.isNotEmpty ? Icons.check : Icons.close,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 3.0,
              ),
              itemCount: 60,
              itemBuilder: (context, index) {
                int number = index + 1;
                bool isSelected = selectedNumbers.contains(number);

                return GestureDetector(
                  onTap: () {
                    // Toggle the selection on tap
                    setState(() {
                      if (isSelected) {
                        selectedNumbers.remove(number);
                      } else {
                        selectedNumbers.add(number);
                      }
                    });
                  },
                  onDoubleTap: () {
                    // Toggle the absent mode on double tap
                    setState(() {
                      isAbsentMode = !isAbsentMode;
                    });
                  },
                  child: Card(
                    color: isSelected ? Colors.green : (isAbsentMode ? Colors.red : Colors.white),
                    child: Center(
                      child: Text(
                        '$number',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


