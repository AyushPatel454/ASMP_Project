import 'package:flutter/material.dart';
class login_Screen extends StatefulWidget {
  const login_Screen({Key? key}) : super(key: key);
  @override
  State<login_Screen> createState() => _login_ScreenState();
}
List<String> fieldlist = [
  'Computer Science',
  'Mechanical',
  'Electrical',

];
List<String> Collegelist = [
  'Parul university',
  'Ms university',
];
class _login_ScreenState extends State<login_Screen> {
  GlobalKey<FormState> login_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Form(
            key: login_key,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10)),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "First Name ",
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
                Padding(padding: EdgeInsets.only(top: 10)),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Last Name ",
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
                  padding: EdgeInsets.only(top: 10),
                ),
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
                Padding(padding: EdgeInsets.only(top: 10)),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Set-Password",
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
                Padding(padding: EdgeInsets.only(top: 10)),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Enter password again",
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
                Row(
                  children: <Widget>[
                    Expanded(child: Container(
                      padding: EdgeInsets.all(10),
                      child:Text('Your Field :'),
                    )),
                    Expanded(child: Container(
                      child: DropdownButtonExample(),
                    ),)
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child:Text('Your College name :'),
                    )),
                    Expanded(
                      flex: 4,
                      child:
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Enter password again",
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
                    ),




                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// this is the field to choose your field ...
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});
  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}
class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = fieldlist.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black87),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: fieldlist.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
