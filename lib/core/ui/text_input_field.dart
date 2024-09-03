import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInputField extends StatefulWidget {
  const AppInputField({
    Key? key,
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.label,
    this.labelText,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.suffixIcon,
    this.onTap,
    this.focusNode,
  }) : super(key: key);

  final Widget? prefixIcon;
  final String? hintText;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final Widget? label;
  final String? labelText;
  final bool enabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final Function()? onTap;
  final FocusNode? focusNode;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: obscureText,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      maxLines: obscureText ? 1 : widget.maxLines,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      obscuringCharacter: '\u{25CF}',
      textCapitalization: widget.textCapitalization,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true,
        hintStyle: const TextStyle(color: Color(0xFF757575)),
        fillColor: const Color(0xFF979797).withOpacity(0.1),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: !widget.obscureText
            ? widget.suffixIcon
            : obscureText
                ? Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: const Icon(
                        Icons.remove_red_eye,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: const Icon(
                        Icons.visibility_off,
                      ),
                    ),
                  ),
      ),
    );
  }
}
