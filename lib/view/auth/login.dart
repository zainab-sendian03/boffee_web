import 'package:flutter/material.dart';
import 'package:hello/core/config/options.dart';
import 'package:hello/core/constants/linksapi.dart';
import 'package:hello/core/constants/crud.dart';
import 'package:hello/view/Navigation.dart';
import 'package:hello/core/constants/color.dart';
import 'package:hello/view/forgetpassword/maiadd.dart';
import 'package:hello/core/constants/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user_name = TextEditingController();
  final password = TextEditingController();
  bool _visPassword = true;

  final Crud _crud = Crud();
  GlobalKey<FormState> formstats = GlobalKey();
  bool isLoading = false;

  logIn() async {
    setState(() {
      isLoading = true;
    });
    if (formstats.currentState!.validate()) {
      try {
        var response = await _crud.postrequest(
            linklogin,
            {
              "user_name": user_name.text,
              "password": password.text,
            },
            headers: getoptions2());
        setState(() {
          isLoading = false;
        });

        print("Response: $response");

        if (response is Map && response['success'] == true) {
          pref?.setString("id", response['data']['id'].toString());
          pref?.setString("user_name", response['data']['user_name']);
          pref?.setString("password", response['data']['password']);
          pref?.setString("token", response['data']['token']);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SideMenue()),
          );
        } else {
          alert(
              formstats.currentContext!,
              "Your password or User name is incorrect or the account does not exist\nPlease try again!",
              "Wrong",
              "Close");
        }
      } catch (e) {
        print("ERROR $e");
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Image.asset('assets/images/web book.png', fit: BoxFit.fill),
              Padding(
                padding: const EdgeInsets.only(left: 400, top: 100),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset('assets/images/logo.png',
                          height: 100, width: 100),
                    ),
                    Text(
                      'Hello From Boffee',
                      style: TextStyle(
                        fontFamily: 'Inkfree',
                        color: dark_Brown,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 270, left: 700, right: 200),
            child: Form(
              key: formstats,
              child: Column(
                children: [
                  TextFormField(
                    validator: (valid) => validInput(valid!, 20, 2),
                    decoration: InputDecoration(
                      hintText: 'User name',
                      hintStyle: TextStyle(
                        color: Beige,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: dark_Brown, width: 2.5),
                      ),
                    ),
                    controller: user_name,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    validator: (valid) => validInput(valid!, 15, 6),
                    obscureText: _visPassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _visPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: medium_Brown,
                          size: 21,
                        ),
                        onPressed: () {
                          setState(() {
                            _visPassword = !_visPassword;
                          });
                        },
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: dark_Brown, width: 2.5),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Beige,
                      ),
                    ),
                    controller: password,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 440),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const mailadd()),
                        );
                      },
                      child: Text(
                        "Forget password?",
                        style: TextStyle(
                            fontSize: 15,
                            color: dark_Brown,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await logIn();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 80, right: 80, top: 20, bottom: 20),
                        backgroundColor: Beige,
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: Text(
                        'login',
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                    ),
                  ),
                  if (isLoading)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
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
            ),
          )
        ],
      ),
    );
  }
}
