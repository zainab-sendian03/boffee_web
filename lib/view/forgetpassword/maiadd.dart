import 'package:flutter/material.dart';
import 'package:hello/core/config/options.dart';
import 'package:hello/core/constants/color.dart';
import 'package:hello/core/constants/crud.dart';
import 'package:hello/core/constants/linksapi.dart';
import 'package:hello/core/constants/textfield.dart';
import 'package:hello/view/forgetpassword/getcode.dart';

class mailadd extends StatefulWidget {
  const mailadd({super.key});

  @override
  State<mailadd> createState() => _mailaddState();
}

class _mailaddState extends State<mailadd> {
  GlobalKey<FormState> formstats = GlobalKey();
  final email = TextEditingController();
  final Crud _crud = Crud();
  bool isLoading = false;

  Future<void> mailAdd() async {
    if (formstats.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var response = await _crud.postrequest(
            link_Email,
            {
              "email": email.text,
            },
            headers: getoptions2());
        setState(() {
          isLoading = false;
        });
        print("Response body: ${response['body']}");

        if (response is Map && response['success'] == true) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const getCode()),
          );
        } else {
          alert(formstats.currentContext!, "The selected email is invalid",
              "Wrong", "Close");
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
                    "Enter the email address associated\n with your account",
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
                    validator: (value) => validInput(value!, 100, 10),
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'Email',
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
                      await mailAdd();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Beige,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(
                            left: 100, right: 100, top: 20, bottom: 20)),
                    child: Text(
                      "Send",
                      style: TextStyle(fontSize: 20, color: offwhite),
                    ),
                  ),
                ]),
              )),
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
        ],
      ),
    );
  }
}
