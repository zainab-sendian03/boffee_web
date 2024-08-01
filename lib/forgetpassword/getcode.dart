import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/core/color.dart';
import 'package:hello/forgetpassword/resetpass.dart';
import 'textfield.dart';

class getCode extends StatefulWidget {
  const getCode({super.key});

  @override
  State<getCode> createState() => _getCodeState();
}

class _getCodeState extends State<getCode> {
  GlobalKey<FormState> formstats = GlobalKey();
  final first = TextEditingController();
  final second = TextEditingController();
  final third = TextEditingController();
  final fourth = TextEditingController();


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
                    "No worries, we’ll send you reset instruction.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 23,
                        color: medium_Brown,
                      )),
              )),
              Container(
              child: ListView(children: [ 
               Padding(
                    padding:
                        const EdgeInsets.only(right: 50, left: 50, top: 320),
                    child: Column(
                      children: [
                        Container(
                          width: 600,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomTextFormField(
                                  hintText: "",
                                  controller: first,
                                  min: 1,
                                  max: 1,
                                  visPassword: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomTextFormField(
                                  hintText: "",
                                  controller: second,
                                  min: 1,
                                  max: 1,
                                  visPassword: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomTextFormField(
                                  hintText: "",
                                  controller: third,
                                  min: 1,
                                  max: 1,
                                  visPassword: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomTextFormField(
                                  hintText: "",
                                  controller: fourth,
                                  min: 1,
                                  max: 1,
                          visPassword: false,
                                
                                ),
                              ),
                            ],
                          
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => resetpass()),
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
    ),
        ]
      )
    );
  }
}
