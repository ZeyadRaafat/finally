import 'package:flutter/material.dart';

class FromConteinerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldsubmitted;
  final TextInputType? inputType;
  final IconData? prefixIcon;

  const FromConteinerWidget(
      {this.controller,
      this.isPasswordField,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldsubmitted,
      this.inputType,
      this.prefixIcon});

  @override
  _FromConteinerWidgetState createState() => new _FromConteinerWidgetState();
}

class _FromConteinerWidgetState extends State<FromConteinerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 50,
        child: new TextFormField(
          style: TextStyle(color: Colors.white),
          controller: widget.controller,
          keyboardType: widget.inputType,
          key: widget.fieldKey,
          obscureText: widget.isPasswordField == true ? _obscureText : false,
          onSaved: widget.onSaved,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldsubmitted,
          decoration: new InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            prefixIcon: widget.prefixIcon!= null ? Icon(widget.prefixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.blue, width: 1),
            ),
            fillColor: Colors.transparent,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: new GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: widget.isPasswordField == true
                  ? Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color:
                          _obscureText == false ? Colors.white : Colors.grey,
                    )
                  : Text(""),
            ),
          ),
        ));
  }
}
