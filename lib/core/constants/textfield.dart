import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hello/core/constants/color.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final int min;
  final int max;
  final bool visPassword;
  final bool showVisPasswordToggle;
  final void Function()? onTapIcon;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.min,
    required this.max,
    this.visPassword = true,
    this.showVisPasswordToggle = false,
    this.onTapIcon,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _visPassword;
  late TextEditingController conf_pass;

  @override
  void initState() {
    super.initState();
    _visPassword = widget.visPassword;
    conf_pass = TextEditingController();
  }

  void _handleTapIcon() {
    if (widget.onTapIcon != null) {
      widget.onTapIcon!();
    }

    setState(() {
      _visPassword = !_visPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (valid) => validInput(valid!, widget.max, widget.min),
      obscureText: _visPassword,
      decoration: InputDecoration(
        errorMaxLines: 2,
        suffixIcon: widget.showVisPasswordToggle
            ? IconButton(
                icon: Icon(
                  _visPassword ? Icons.visibility_off : Icons.visibility,
                  color: medium_Brown,
                  size: 21,
                ),
                onPressed: _handleTapIcon,
              )
            : null,
        hintText: widget.hintText,
        // contentPadding:
        //     const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF5D3F2E), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

String? validInput(String val, int max, int min) {
  if (val.length > max) {
    return "It cannot be greater than $max";
  }
  if (val.isEmpty) {
    return "It's required";
  }
  if (val.length < min) {
    return "It cannot be smaller than $min";
  }
  return null;
}

Future<dynamic> alert(
    BuildContext context, String cont, String title, String buttTxt) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String contentText = cont;
        return AlertDialog(
          backgroundColor: Colors.white60,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          icon: const Icon(
            Icons.error,
            size: 50,
            color: Color(0xFF94745B),
          ),
          title: Column(
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xFF5D3F2E),
                  ),
                ),
              ),
              const Divider(
                color: Color(0xFF94745B),
                thickness: 2,
              )
            ],
          ),
          content: Text(
            contentText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: medium_Brown,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 15, bottom: 15)),
                child: Text(buttTxt,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        );
      });
}
