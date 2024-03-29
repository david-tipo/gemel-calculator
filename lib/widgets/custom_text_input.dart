import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import '../app_code/useful_funcs.dart';

class CustomTextInput extends StatefulWidget {
  final String title;
  final TextStyle textStyle;
  final double textFieldWidth;
  final double textFieldHeight;
  final double spacing;
  final TextEditingController controller;
  final IconData iconData;
  final String errorMessage;
  final bool addCommas;

  CustomTextInput({
    @required this.title,
    @required this.textStyle,
    @required this.textFieldWidth,
    @required this.textFieldHeight,
    @required this.spacing,
    @required this.controller,
    @required this.iconData,
    this.addCommas = true,
    this.errorMessage,
  });

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {

  _organizeText(){
    if (widget.addCommas) {
      widget.controller.text =
          UsefulFunc.commaString(
              widget.controller.text); // adds commas to the number
    }
    widget.controller.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller.text.length));
    // always brings the cursor the units number
  }

  /// returns the error text style
  TextStyle get _errorStyle {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width / (360 / 10) +
          widget.textFieldWidth / (MediaQuery.of(context).size.width / 15),
      color: Colors.red,
      backgroundColor: Colors.white.withOpacity(0.8),
    );
  }

  @override
  Widget build(BuildContext context) {
    _organizeText();
    //^^ useful when there is an error msg.
    return Column(
      children: [
        BorderedText(
          strokeWidth: 3,
          strokeColor: Colors.white,
          child: Text(
            widget.title,
            style: widget.textStyle,
          ),
        ),
        SizedBox(
          height: widget.spacing,
        ),
        Container(
          width: widget.textFieldWidth,
          height: widget.textFieldHeight, // + _heightBonus,
          child: TextField(
            controller: widget.controller,
            onChanged: (ctx) {
              _organizeText();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              //contentPadding: const EdgeInsets.all(10),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              errorText: widget.errorMessage != null ? '' : null,
              //makes the red border
              //but dosent make the border red
              // if there is no error text
              errorStyle: TextStyle(
                height: 0,
              ),

              suffixIcon: Icon(
                widget.iconData,
                size: widget.textFieldHeight / 2.5,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        // Shows error text only if there is error to show
        if (widget.errorMessage != null)
          Container(
            width: widget.textFieldWidth,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 2, top: 2),
            child: Text(
              widget.errorMessage,
              style: _errorStyle,
            ),
          ),
      ],
    );
  }
}
