import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routiner/core/theme/theme_imports.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final String? errorText;
  final String? helperText;
  final Widget? iconLeft;
  final Widget? iconRight;

  // sizing
  final double? width;
  final double? height;
  final EdgeInsets? contentPadding; // ✅ Better than separate h/v

  final double? borderRadius;
  final double? borderWidth;

  // styling

  final Color? bgColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;

  // state
  final FocusNode? focusNode;
  final bool autoFocus;

  // callbacks
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;

  // input behavior
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  const CustomInput({
    super.key,
    required this.label,
    required this.hint,
    this.iconLeft,
    this.iconRight,
    this.width,
    this.height,
    this.borderRadius,
    this.borderWidth,
    this.bgColor,
    this.textColor,
    this.hintColor,
    this.borderColor,
    this.autoFocus = false,
    this.contentPadding,
    required this.controller,
    this.enabled = true,
    this.errorBorderColor,
    this.errorText,
    this.focusNode,
    this.focusedBorderColor,
    this.helperText,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.labelColor,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  @override
  State<CustomInput> createState() => _CustomInput();
}

class _CustomInput extends State<CustomInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller, // ✅ Essential
            focusNode: _focusNode,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            autofocus: widget.autoFocus,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            onFieldSubmitted: widget.onSubmitted,
            validator: widget.validator,

            decoration: InputDecoration(
              filled: true,
              fillColor: _isFocused
                  ? (widget.bgColor ?? Colors.white)
                  : (widget.bgColor ?? AppColors.inputBackground),
              labelStyle: TextStyle(
                color: _isFocused
                    ? widget.labelColor ?? AppColors.textSecondary
                    : widget.labelColor ?? AppColors.textPlaceholder,
              ),
              hintStyle: TextStyle(
                color: widget.hintColor ?? AppColors.textPlaceholder,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppDimensions.radiusLG,
                ),
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.transparent,
                  width: widget.borderWidth ?? 1.0,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppDimensions.radiusLG,
                ),
                borderSide: BorderSide(
                  color: widget.focusedBorderColor ?? AppColors.primary,
                  width: widget.borderWidth ?? 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppDimensions.radiusLG,
                ),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? AppColors.error,
                  width: widget.borderWidth ?? 1.0,
                ),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppDimensions.radiusLG,
                ),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? AppColors.error,
                  width: widget.borderWidth ?? 2.0,
                ),
              ),
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              labelText: widget.label,
              hintText: widget.hint,
              errorText: widget.errorText,
              helperText: widget.helperText,
              prefixIcon: widget.iconLeft,
              suffixIcon: widget.iconRight,
            ),
          ),
        ],
      ),
    );
  }
}
