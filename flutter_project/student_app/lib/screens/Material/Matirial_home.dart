import 'package:flutter/material.dart';

import 'branchs/Cse/Cse.dart';
import 'branchs/elec/elec.dart';
import 'branchs/mech/mech.dart';

class MaterialHome extends StatefulWidget {
  const MaterialHome({Key? key}) : super(key: key);

  @override
  State<MaterialHome> createState() => _MaterialHomeState();
}

class _MaterialHomeState extends State<MaterialHome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(

        children: <Widget>[
          SizedBox(height: 30,),
          Text('Materials',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 10,),

          Text('which Matirial You want ? ',
            style: TextStyle(
              fontSize: 20,

            ),
          ),
          SizedBox(height: 50,),

          ElevatedButton( child: Text('Computer Science And Engineering '),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shadowColor: Colors.green,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(300, 36),
            ),
              onPressed:(){
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => Cse()),
                );
              },

          ),

          SizedBox(height: 30,),

          ElevatedButton(child: Text('Mechanical Engineering'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shadowColor: Colors.green,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(300, 36),
            ),
            onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Mech()),
              );
            },
          ),

          SizedBox(height: 30,),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shadowColor: Colors.green,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(300, 36),


            ),
            onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => elec()),
              );
            },
            child: Text('Electrical Engineering'),
          ),

        ],
      ),
    );
  }
}
