import 'package:budgify/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReusableTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final double? radius;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? prefixText;
  final VoidCallback? onTapPrefix;
  final bool filled;
  final bool isBorder;
  final bool isHeading;

  const ReusableTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isHeading = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.prefixIcon,
    this.isPassword = false,
    this.filled = true,
    this.isBorder = true,
    this.radius,
    this.onChanged,
    this.focusNode,
    this.prefixText,
    this.onTapPrefix,
  });

  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  bool _obscureText = true;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return TextFormField(
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      focusNode: widget.focusNode ?? _focusNode,
      obscureText: (!widget.isPassword) ? false : _obscureText,
      maxLines: widget.maxLines,
      controller: widget.controller,
      style:
          widget.isHeading ? AppStyles.headingPrimary(context: context) : null,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      textAlignVertical: TextAlignVertical.center,
      minLines: 1,
      decoration: !widget.isBorder
          ? InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              hintText: widget.hintText,
              hintStyle: !widget.isHeading
                  ? TextStyle(
                      fontFamily: 'Poppins',
                      color: _isFocused
                          ? theme.primary
                          : theme.onSurface.withValues(alpha: 0.8),
                    )
                  : AppStyles.headingPrimary(context: context, fontSize: 32)
              // contentPadding: EdgeInsets.zero, // Optional: removes internal padding
              )
          : InputDecoration(
              prefixIcon: widget.prefixText != null || widget.prefixIcon != null
                  ? InkWell(
                      onTap: widget.onTapPrefix,
                      child: widget.prefixText != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 12, left: 18),
                              child: Text(
                                widget.prefixText!,
                                style:
                                    AppStyles.headingPrimary(context: context),
                              ),
                            )
                          : widget.prefixIcon == null
                              ? null
                              : Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Icon(widget.prefixIcon,
                                      color: _isFocused
                                          ? theme.primary
                                          : theme.onSurface
                                              .withValues(alpha: 0.8),
                                      size: 25),
                                ),
                    )
                  : null,
              suffixIcon: (!widget.isPassword)
                  ? null
                  : IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: _isFocused
                            ? theme.primary
                            : theme.onSurface.withValues(alpha: 0.8),
                      ),
                      onPressed: _toggle,
                    ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                color: _isFocused
                    ? theme.primary
                    : theme.onSurface.withValues(alpha: 0.8),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 15),
                borderSide: BorderSide(
                  color: _isFocused ? theme.primary : theme.onSurface,
                  width: 1.5,
                ),
              ),
              fillColor: theme.surface,
              filled: widget.filled,
            ),
    );
  }
}
