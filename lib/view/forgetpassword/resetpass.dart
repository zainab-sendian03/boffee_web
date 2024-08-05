import 'package:flutter/material.dart';
import 'package:hello/config/options.dart';
import 'package:hello/constants/color.dart';
import 'package:hello/constants/crud.dart';
import 'package:hello/constants/linksapi.dart';
import 'package:hello/constants/textfield.dart';
import 'package:hello/view/auth/login.dart';

class resetpass extends StatefulWidget {
  const resetpass({super.key});

  @override
  State<resetpass> createState() => _resetpassState();
}

class _resetpassState extends State<resetpass> {
  GlobalKey<FormState> formstats = GlobalKey();
  var pass = TextEditingController();
  var conf_pass = TextEditingController();
  bool _visPassword1 = true;
  bool _visPassword2 = true;
  final Crud _crud = Crud();
  bool isLoading = false;

  Future<void> resetPassword() async {
    String? code = pref!.getString('code');
    if (formstats.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var response = await _crud.postrequest(
            link_Reset,
            {
              "code": code,
              "password": pass.text,
              "password_confirmation": conf_pass.text
            },
            headers: getoptions2());
        setState(() {
          isLoading = false;
        });
        print("Response body: ${response['body']}");
        print('Retrieved code: $code');
        if (response is Map &&
            response['message'] == "Password has been successfully reset") {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          alert(formstats.currentContext!,
              "The password confirmation does not match.", "Wrong", "Close");

          print('Failed to send email: ${response['message']}');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print("ERROR: $e");
      }
    }
  }

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
              child: Form(
                key: formstats,
                child: Column(children: [
                  TextFormField(
                    controller: pass,
                    obscureText: _visPassword1,
                    validator: (value) => validInput(value!, 50, 8),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _visPassword1
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: medium_Brown,
                          size: 21,
                        ),
                        onPressed: () {
                          setState(() {
                            _visPassword1 = !_visPassword1;
                          });
                        },
                      ),
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
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _visPassword2,
                    controller: conf_pass,
                    validator: (value) => validInput(value!, 50, 8),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _visPassword2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: medium_Brown,
                          size: 21,
                        ),
                        onPressed: () {
                          setState(() {
                            _visPassword2 = !_visPassword2;
                          });
                        },
                      ),
                      hintText: 'password confirmation',
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
                    onPressed: () async {
                      await resetPassword();
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
                ]),
              )),
          if (isLoading)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 440,
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Light_Brown,
                    color: dark_Brown,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
