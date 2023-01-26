

import 'package:flutter/material.dart';
import 'Login_page.dart';
void main() => runApp(MaterialApp(
  home : Home(),
));

class Home extends StatefulWidget{

  @override
  State<Home> createState() => _HomeState();
}
GlobalKey<FormState> formkey = GlobalKey<FormState>();
// to validation of the form
void Validate(){
  if(formkey.currentState!.validate()){
    print("ok");

  }else{
    print("Error");
  }
}


class _HomeState extends State<Home> {



  // var myInitialItem = 'item1';


  @override
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
                Text('Welcome'),
                Padding(padding: EdgeInsets.only(top: 50)),
                Text('Enter Your Email Here :'),
                Padding(padding: EdgeInsets.only(top: 10)),
                // we take email from user
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
                Padding(  // to adding space between two widgets
                  padding: EdgeInsets.only(top: 50),
                ),

                Text('Enter Your Password : '),
                Padding(padding: EdgeInsets.only(top: 10)),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Passworld",
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

                // now we take student feild with usig dropdownlist button
                  
                Padding(padding: EdgeInsets.only(top: 50)),
                Row(
                  children: <Widget>[
                    Expanded(flex: 1, child: Text(''),),
                    Expanded(
                      flex: 3,
                      child:
                        Container(

                          child:
                          ElevatedButton(
                              onPressed:Validate,
                              child: Text('Log In'),
                          ),
                        ),
                    ),

                    Expanded(flex: 3, child: Text(''),),
                    Expanded(
                      flex: 3,
                      child:
                        Container(
                          child:
                          ElevatedButton(
                              onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return login_Screen();
                                },),);
                              },
                              child: Text('Sign Up'),
                          ),
                        ),
                    ),
                    Expanded(flex: 1, child: Text(''),),

                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 50)),
                Text('For new user please sign up first ... '),






                
                
                
                

              ],
            ),
          ),
        ),
      )
    );
  }

}