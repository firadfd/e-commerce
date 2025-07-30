import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  static void _defaultOnTap() {}

  const CustomTextField({
    super.key,
    this.textEditingController,
    // this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputTextStyle = const TextStyle(),
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.hintText,
    this.labelText = '',
    this.hintStyle = const TextStyle(),
    this.fillColor = const Color(0xFFFFFFFF),
    this.suffixIconColor,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius = 8,
    this.onChanged,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.onTapClick = _defaultOnTap,
    this.readOnly = false,
    this.width,
    this.height,
    this.errorStyle,
    this.prefiesIcnColor,
    this.contentPadding,
  });

  final TextEditingController? textEditingController;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle? inputTextStyle;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final String? hintText;
  final String labelText;
  final TextStyle? hintStyle;
  final Color fillColor;
  final Color? suffixIconColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double borderRadius;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool isPassword;
  final VoidCallback onTapClick;
  final bool readOnly;
  final double? height;
  final double? width;
  final TextStyle? errorStyle;
  final Color? prefiesIcnColor;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> obscureTextNotifier = ValueNotifier<bool>(true);

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        child: ValueListenableBuilder<bool>(
          valueListenable: obscureTextNotifier,
          builder: (context, obscureText, child) {
            return TextFormField(
              enabled: true,
              onTap: onTapClick,
              onChanged: onChanged,
              validator: validator,
              onFieldSubmitted: onFieldSubmitted,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              readOnly: readOnly,
              controller: textEditingController,
              // focusNode: focusNode,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: errorStyle,
              maxLines: maxLines,
              maxLength: maxLength,
              obscureText: isPassword ? obscureText : false,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintStyle,
                errorStyle: errorStyle,
                fillColor: fillColor,
                filled: true,
                contentPadding: contentPadding,
                prefixIcon: prefixIcon,
                prefixIconColor: prefiesIcnColor,
                suffixIcon:
                    isPassword
                        ? GestureDetector(
                          onTap: () {
                            obscureTextNotifier.value =
                                !obscureTextNotifier.value;
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 16.h,
                              vertical: 14.w,
                            ),
                            child:
                                obscureText
                                    ? Icon(
                                      Icons.visibility_off,
                                      color: Color(0xFF7F7F8A),
                                    )
                                    : Icon(
                                      Icons.visibility,
                                      color: Color(0xFF7F7F8A),
                                    ),
                          ),
                        )
                        : suffixIcon,
                suffixIconColor: suffixIconColor,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red.shade900,
                    width: 1.2.w,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE2E8F0),
                    width: 1.2.w,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red.shade900,
                    width: 1.2.w,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE2E8F0),
                    width: 1.2.w,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
