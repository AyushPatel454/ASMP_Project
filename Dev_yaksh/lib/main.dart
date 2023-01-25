

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home : Home(),
));

class Home extends StatefulWidget{

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // to validation of the form
  void Validate(){
    if(formkey.currentState!.validate()){
      print("ok");

    }else{
      print("Error");
    }
  }



  @override
  // drop down list
  late String valueChoose;
  List listItem = [
    "item 1",
    "item 2",
    "item 3"
  ];

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Log In'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),

      body: Padding(
        padding: EdgeInsets.all(25),
        child:Center(
          child: Form(

            key : formkey,
            child: Column(
              children: <Widget>[
                TextFormField(

                  decoration: InputDecoration(
                    labelText: "Full Name",

                    border: OutlineInputBorder()
                  ),
                  validator: (val){
                    if(val!.isEmpty){
                      return "Requied";
                    }
                    else{
                      return null ;
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder()
                  ),
                  validator: (val){
                    if(val!.isEmpty){
                      return "Requied";
                    }
                    else{
                      return null ;
                    }
                  },
                ),
                
                DropdownButton(
                  value: valueChoose,
                  onChanged: (newValue){
                    setState(() {
                      valueChoose = newValue ;
                    });

                  },
                  items: listItem.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
                
                
                
                
                
                
                ElevatedButton(onPressed:Validate, child: Text('LOG IN')),

              ],
            ),
          ),
        ),
      )




    );
  }
}