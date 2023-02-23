import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String? fieldValue;
  String? subjectValue;
  List<String> fields = [];
  List<String> subjects = [];

  @override
  void initState() {
    super.initState();
    fetchFields();
  }

  Future<void> fetchFields() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('fields').get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;
    for (var document in documents) {
      final departmentName = document['fieldName'];
      fields.add(departmentName);
    }

    setState(() {
      // fieldValue = fields[0];
    });
  }

  // -> Fetch Selected Field's --> Subjects
  Future<void> fetchSubjects() async {
    final QuerySnapshot selectFieldSnapshot = await FirebaseFirestore.instance
        .collection('fields')
        .where('fieldName', isEqualTo: fieldValue)
        .get();

    final List<DocumentSnapshot> fieldDocument = selectFieldSnapshot.docs;
    for (var fieldDoc in fieldDocument) {
      final QuerySnapshot subjectSnapshot =
          await fieldDoc.reference.collection('Subjects').get();

      final List<DocumentSnapshot> subjectDocuments = subjectSnapshot.docs;
      for (var document in subjectDocuments) {
        final subjectName = document['subjectName'];
        subjects.add(subjectName);
      }

      setState(() {
        // subjectValue = subjects[0];
      });
      // setState(() {
      //
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (fields.isEmpty) {
      return CircularProgressIndicator();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          // --> Select Field
          DropdownButton<String>(
            hint: Text('Select Field'),
            value: fieldValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                fieldValue = newValue!;
                subjectValue = null;
                subjects = [];
                // fetchSubjects();
              });
              fetchSubjects();
            },
            items: fields.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            isExpanded: true,
            dropdownColor: Colors.white38.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
            iconEnabledColor: Colors.blue,
          ),
          // --> Selected Field Subject
          if(fieldValue != null)
          DropdownButton<String>(
            hint: Text('Select Subject'),
            value: subjectValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                subjectValue = newValue!;
              });
            },
            items: subjects.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            isExpanded: true,
            dropdownColor: Colors.white38.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
            iconEnabledColor: Colors.blue,
          ),

          // --> Remove Pdf
          // subjectValue != null ?
          if(subjectValue != null)
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.upload), label: Text('Upload'),
          ),
        ],
      ),
    );
  }
}
