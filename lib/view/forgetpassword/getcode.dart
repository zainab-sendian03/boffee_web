import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/config/options.dart';
import 'package:hello/constants/color.dart';
import 'package:hello/constants/crud.dart';
import 'package:hello/constants/linksapi.dart';
import 'package:hello/view/forgetpassword/resetpass.dart';
import '../../constants/textfield.dart';

class getCode extends StatefulWidget {
  const getCode({super.key});

  @override
  State<getCode> createState() => _getCodeState();
}

class _getCodeState extends State<getCode> {
  GlobalKey<FormState> formstats = GlobalKey();
  final code = TextEditingController();

  final Crud _crud = Crud();
  bool isLoading = false;

  Future<void> GetTheCode() async {
    if (formstats.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var response = await _crud.postrequest(
            link_checkCode,
            {
              "code": code.text,
            },
            headers: getoptions2());

        setState(() {
          isLoading = false;
        });
        print("Response body: ${response['body']}");

        if (response is Map &&
            response["message"] == "passwords.code_is_valid") {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => resetpass()),
          );
          pref!.setString('code', code.text);
        } else {
          alert(
              formstats.currentContext!,
              "The entered code is incorrect\nPlease try again!",
              "Wrong",
              "Close");
          print('Failed to check code: ${response['message']}');
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
        body: Stack(children: [
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
          padding: EdgeInsets.only(
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
          padding: EdgeInsets.only(
            bottom: 230,
          ),
          child: Center(
            child: Text(
                "Please enter the 6 digit code that\n send to your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  color: medium_Brown,
                )),
          )),
      Container(
        child: Padding(
            padding: const EdgeInsets.only(right: 400, left: 400, top: 320),
            child: Form(
              key: formstats,
              child: Column(children: [
                TextFormField(
                  validator: (value) => validInput(value!, 6, 6),
                  controller: code,
                  decoration: InputDecoration(
                    hintText: 'Code',
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
                    await GetTheCode();
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
      ),
      if (isLoading)
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 350,
            ),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Light_Brown,
                color: dark_Brown,
              ),
            ),
          ),
        )
    ]));
  }
}
