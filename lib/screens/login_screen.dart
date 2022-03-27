import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultLoginSize = size.height - (size.height * 0.2);
    //double defaultRegisterSize = size.height - (size.height * 0.2);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              // ignore: sized_box_for_whitespace
              child: Container(
                width: size.width,
                height: defaultLoginSize,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      height: 250,
                      image: AssetImage('assets/images/justice2.jpg'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "My Court",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 34.0,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.orange.withAlpha(20),
                      ),
                      child: TextField(
                        controller: txtController,
                        cursorColor: Colors.amber,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.key,
                              color: Colors.orangeAccent,
                            ),
                            hintText: "Enter Your Aadhar no.",
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) =>
                                    DetailScreen(txtController.text)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.amber.withAlpha(180)),
                        height: 40,
                        width: 100,
                        child: const Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
