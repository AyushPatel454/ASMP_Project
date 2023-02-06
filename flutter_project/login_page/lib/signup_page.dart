import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_page/auth_controller.dart';
import 'package:login_page/login_screen.dart';




class SignUpPage extends StatelessWidget {

  String courcevalue = 'Computer Science';
  String collegevalue = 'Parul University';

  List<String> cources = [
    'Computer Science',
    'Mechanical',
    'Electrical',

  ];
  List<String> colleges = [
    'Parul University',
    'MS University',
  ];



  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    List images = [
      "g.png",
      "t.png",
      "f.png"
    ];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   width: w,
            //   height: h*0.3,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage(
            //               "img/signup.png"
            //           ),
            //           fit: BoxFit.cover
            //       )
            //   ),
            //   child: Column(
            //     children: [
            //       SizedBox(height: h*0.14,),
            //       CircleAvatar(
            //         backgroundColor: Colors.white70,
            //         radius: 60,
            //         backgroundImage: AssetImage(
            //           "img/profile1.png"
            //         ),
            //       )
            //     ],
            //   ),
            // ),

            SizedBox(height: 40,),

            Container(
              child: Text(
                ' FILL THE DETAILS ',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),  // fill the details

            SizedBox(height: 30,),

            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1,1),
                        color: Colors.grey.withOpacity(0.2)
                    )
                  ]
              ),
              child: TextField(
                // controller: emailController,
                decoration: InputDecoration(
                    hintText: "First Name ",
                    prefixIcon: Icon(Icons.account_circle, color: Colors.deepOrangeAccent),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0
                        )
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),
              ),
            ), // first name

            SizedBox(height: 10,),

            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1,1),
                        color: Colors.grey.withOpacity(0.2)
                    )
                  ]
              ),
              child: TextField(
                // controller: emailController,
                decoration: InputDecoration(
                    hintText: "Last Name ",
                    prefixIcon: Icon(Icons.account_circle, color: Colors.deepOrangeAccent),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0
                        )
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),
              ),
            ), // last name


            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,1),
                              color: Colors.grey.withOpacity(0.2)
                          )
                        ]
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                          prefixIcon: Icon(Icons.email, color: Colors.deepOrangeAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,1),
                              color: Colors.grey.withOpacity(0.2)
                          )
                        ]
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Enter Password",
                          prefixIcon: Icon(Icons.password_outlined, color: Colors.deepOrangeAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,1),
                              color: Colors.grey.withOpacity(0.2)
                          )
                        ]
                    ),
                    child: TextField(
                      // controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Re-Enter Password",
                          prefixIcon: Icon(Icons.password_outlined, color: Colors.deepOrangeAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                    ),
                  ),

                  
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,1),
                              color: Colors.grey.withOpacity(0.2)
                          )
                        ]
                    ),
                  ),




                  SizedBox(height: 10,),
                  // Row(
                  //   children: [
                  //     Expanded(child: Container(),),
                  //     Text(
                  //       "Forget Password?",
                  //       style: TextStyle(
                  //         fontSize: 20,
                  //         color: Colors.grey[500],
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),  // Email password

            SizedBox(height: 10,),

            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1,1),
                        color: Colors.grey.withOpacity(0.2)
                    )
                  ]
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '    Your Cource : ' ,
                      style: TextStyle(
                        color: Colors.orange ,
                        fontSize:16,
                        fontWeight:FontWeight.bold,

                      ),
                    ),
                  ),
                  Expanded(
                    child: DropdownButton(
                    value: courcevalue,
                    items: cources.map((String cources){
                      return DropdownMenuItem(
                          value: cources,
                          child: Text(cources),
                      );
                    }).toList(),
                    onChanged: (String? newValue){
                      setState(() {
                        courcevalue = newValue!;
                      });
                    },
                  ),
                  ),
                ],
              ),
            ),  // choose your field

            SizedBox(height: 10,),

            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1,1),
                        color: Colors.grey.withOpacity(0.2)
                    )
                  ]
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '    Your College  : ' ,
                      style: TextStyle(
                        color: Colors.orange ,
                        fontSize:16,
                        fontWeight:FontWeight.bold,

                      ),
                    ),
                  ),
                  Expanded(
                    child: DropdownButton(
                      value: collegevalue,
                      items: colleges.map((String colleges){
                        return DropdownMenuItem(value: colleges,child: Text(colleges));

                      }).toList(),
                      onChanged: (String? newcollege){
                        setState(() {
                          collegevalue = newcollege!;
                        });
                        },
                    ),
                  ),
                ],
              ),
            ),  // choose your college

            SizedBox(height: 30,),


            GestureDetector(
              onTap: (){
                AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
              },
              child: Container(
                width: w*0.3,
                height: h*0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage(
                            "img/loginbtn.png"
                        ),
                        fit: BoxFit.cover
                    )
                ),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    ),
                    child: Text(
                      'SignUP',
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()),);
                    },
                  ),
                ),
              ),  // sign up
            ),


            SizedBox(height: 10,),



            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                text: "Have an account?",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[500]
                )
              )
            ),

            SizedBox(height: 20,),

            RichText(text: TextSpan(
                text: "Sign up using one of the following method",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 15
                ),
            )
            ),


            Wrap(
              children: List<Widget>.generate(
                3,
                  (index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[700],
                      child: CircleAvatar(
                        radius: 26,
                        backgroundImage: AssetImage(
                          "img/"+images[index]
                        ),
                      ),
                    ),
                  );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}

void setState(Null Function() param0) {

}
