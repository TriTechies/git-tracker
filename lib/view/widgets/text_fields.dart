import 'package:flutter/material.dart';
import '../style/style.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.height,
    required this.hintText,
    required this.width,
    required this.type,
    required this.obsured,
    required this.controller,
    this.showPasswordToggle = false,
    this.count,
    this.validator,
    this.textHeading = '',
  });

  final String hintText;
  final double height;
  final double width;
  final TextInputType type;
  final bool showPasswordToggle;
  final bool obsured;
  final TextEditingController controller;
  final int? count;
  final String? Function(String?)? validator;
  final String textHeading;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obsured;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textHeading,
          style: fontWeightStyle(
            size: 13,
            weight: FontWeight.bold,
            fontFamily: "Segoe UI",
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: widget.width,
          child: TextFormField(
            maxLength: widget.count,
            keyboardType: widget.type,
            obscureText: _isObscure,
            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 3), // Thick green border
              ),
              labelText: widget.hintText,
              counterText: '',
              labelStyle: fontWeightStyle(
                size: 15,
                weight: FontWeight.w400,
                fontFamily: "Segoe UI",
                color: Colors.black,
              ),
              suffixIcon: widget.showPasswordToggle
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.controller.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                widget.controller.clear();
                              });
                            },
                          ),
                        IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ],
                    )
                  : widget.controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              widget.controller.clear();
                            });
                          },
                        )
                      : null,
            ),
          
          ),
        ),
      ],
    );
  }
}
