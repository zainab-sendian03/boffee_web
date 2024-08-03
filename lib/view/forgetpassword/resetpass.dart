import 'package:flutter/material.dart';
import 'package:hello/constants/color.dart';
import 'package:hello/view/auth/login.dart';

class resetpass extends StatefulWidget {
  const resetpass({super.key});

  @override
  State<resetpass> createState() => _resetpassState();
}

class _resetpassState extends State<resetpass> {
  GlobalKey<FormState> formstats = GlobalKey();
  final pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/keylogo.png',
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                bottom: 400,
              ),
              child: Center(
                child: Text("Forget password?",
                    style: TextStyle(
                        fontFamily: 'Inconsolata-Bold',
                        fontSize: 35,
                        color: dark_Brown,
                        fontWeight: FontWeight.bold)),
              )),
          Padding(
              padding: const EdgeInsets.only(
                bottom: 230,
              ),
              child: Center(
                child: Text(
                    "Your new password must be different from previously used password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      color: medium_Brown,
                    )),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 400, left: 400, top: 320),
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: medium_Brown,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Beige, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Beige, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: dark_Brown, width: 2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Beige,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(
                          left: 100, right: 100, top: 20, bottom: 20)),
                  child: Text(
                    "Verify",
                    style: TextStyle(fontSize: 20, color: offwhite),
                  ),
                ),
              ]))
        ],
      ),
    );
  }
}
