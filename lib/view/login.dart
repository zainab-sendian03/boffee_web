import 'package:flutter/material.dart';
import 'package:hello/view/Navigation.dart';
import 'package:hello/core/color.dart';
import 'package:hello/forgetpassword/maiadd.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
   // MediaQuery.size.heght
    return Scaffold(
      body: Container(
       
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child:
                  Image.asset('assets/images/web book.png', fit: BoxFit.fill),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: Image.asset('assets/images/logo.png',
                          height: 100, width: 100),
                    ),
                  ),
    
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 40),
                    child: Center(
                      child: Text(
                        'Hello From Boffee',
                        style: TextStyle(
                          fontFamily: 'Inkfree',
                          color: dark_Brown,
                          fontSize: 24,
                         // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
    
                  const SizedBox(height: 40),
    
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 200),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Beige,),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: dark_Brown, width: 2.5),
                        ),
                      ),
                    ),
                  ),
    
                  const SizedBox(height: 20),
    
                  
                  Padding(
                    padding: const EdgeInsets.only(right: 200, left: 200),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: dark_Brown, width: 2.5),
                        ),
                        hintText: 'Password',
                         hintStyle: TextStyle(color: Beige,),
                      ),
                    ),
                  ),
    
                  Padding(
                    padding: const EdgeInsets.only(right: 120),
                    child: Align(
                      alignment: Alignment.centerRight,
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
                  ),
    
                  const SizedBox(height: 40),
    
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                     Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SideMenue()),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
