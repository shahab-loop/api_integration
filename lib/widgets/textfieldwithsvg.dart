import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hintText;


  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  final double? width;
  final Color? hintColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final int maxLines;
  final int? minLines;
  final bool useUnderlineBorder;

  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.width,
    this.hintColor,
    this.borderColor,
    this.focusedBorderColor,
    this.contentPadding,
    this.maxLines = 1,
    this.minLines,
    this.useUnderlineBorder = false,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final enabledColor =
        widget.borderColor ?? Colors.white60!;
    final focusedColor =
        widget.focusedBorderColor ?? Colors.grey!;

    final InputBorder border = widget.useUnderlineBorder
        ? UnderlineInputBorder(
      borderSide: BorderSide(color: enabledColor),
    )
        : OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: enabledColor),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 48.px,
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        onChanged: widget.onChanged,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        style: TextStyle(
          color: Colors.black26,
          fontSize: 14.px,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.hintColor ?? Colors.grey,
            fontSize: 12.px,
          ),

          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),

          border: border,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
            borderSide:  BorderSide(color: Colors.red),
          ),

          errorStyle:  TextStyle(
            fontSize: 11,
            height: 1.2,
          ),

        ),
      ),
    );
  }
}
