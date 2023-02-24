import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_scren.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';

const List<String> clgList = <String>["PU", "KPGU", "ITM", "NONE"];
const List<String> fieldList = <String>[
  "CSE",
  "MECHANICAL",
  "CHEMICAL",
  "ELECTRICAL",
  "NONE"
];

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  String? institue;
  String? field;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      institue: institue!, // can not be null
      field: field!, // can not be null
      file: _image!,
    );

    setState(() {
      _isLoading = false; // false
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      // --> Going to home screen.
      Navigator.of(context).pushReplacement( // pushReplacement ---> for no go back previous screen.
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }

    print(res);
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // String institue = clgList.first;
    void dropdownCallback(String? selectedValue) {
      if (selectedValue is String) {
        setState(() {
          institue = selectedValue;
        });
      }
    }

    return Scaffold(
      // backgroundColor: Colors.tealAccent,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // for center in row (horizontal)
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ), // for create spacing top

              //  ---> svg image
              // SvgPicture.asset(
              //   'assets/ic_instagram.svg',
              //   color: primaryColor,
              //   height: 64,
              // ),
              // const SizedBox(height: 64),

              // ---> circular widget to accept and show our selected file
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://t3.ftcdn.net/jpg/01/09/00/64/360_F_109006426_388PagqielgjFTAMgW59jRaDmPJvSBUL.jpg'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.blue, // for change color of icon
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ---> text field input for username
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your name',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),

              //  ---> text field input for email
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              //  ---> text field input for password
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 24),

              // ---> text field input for bio
              // TextFieldInput(
              //   textEditingController: _bioController,
              //   hintText: 'Enter your bio',
              //   textInputType: TextInputType.text,
              // ),
              // const SizedBox(height: 24),

              // --> Drop down menu for // --> Institue.
              DropdownButton<String>(
                hint: Text("Select institue"),
                value: institue,
                icon: const Icon(Icons.arrow_drop_down),
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    institue = value!;
                  });
                },
                items: clgList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.blue),
                    ),
                  );
                }).toList(),
                isExpanded: true,
                dropdownColor: Colors.white38.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                iconSize: 33,
                iconEnabledColor: Colors.blue,
              ),

              // --> Drop down menu for // --> Field.
              DropdownButton<String>(
                hint: Text("Select field"),
                value: field,
                icon: const Icon(Icons.arrow_drop_down),
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    field = value!;
                  });
                },
                items: fieldList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.blue),
                    ),
                  );
                }).toList(),
                isExpanded: true,
                dropdownColor: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                iconSize: 33,
                iconEnabledColor: Colors.blue,
              ),

              //  ---> button login
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),

              //  ---> Transitioning to signing up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Have an account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        "Login.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
