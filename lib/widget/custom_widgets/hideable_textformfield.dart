import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HideableTextFormField extends StatefulWidget {
  const HideableTextFormField({
    required TextEditingController controller,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.lable = '',
    this.contentPadding,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.showPrefixIcon = true,
    this.readOnly = false,
    this.autoFocus = false,
    this.notVisible = true,
    this.textAlign = TextAlign.start,
    this.border,
    Key? key,
  })  : _controller = controller,
        super(key: key);
  final TextEditingController _controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final bool showPrefixIcon;
  final String? Function(String? value)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? initialValue;
  final String? lable;
  final bool readOnly;
  final bool autoFocus;
  final bool notVisible;
  final TextAlign textAlign;
  final InputBorder? border;
  @override
  HideableTextFormFieldState createState() => HideableTextFormFieldState();
}

class HideableTextFormFieldState extends State<HideableTextFormField> {
  bool _notVisible = true;
  void _onListener() => setState(() {});
  @override
  void initState() {
    _notVisible = widget.notVisible;
    widget._controller.addListener(_onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller.removeListener(_onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        initialValue: widget.initialValue,
        controller: widget._controller,
        readOnly: widget.readOnly,
        obscureText: _notVisible,
        keyboardType: widget.maxLines! > 1
            ? TextInputType.multiline
            : widget.keyboardType ?? TextInputType.text,
        textInputAction: widget.maxLines! > 1
            ? TextInputAction.newline
            : widget.textInputAction ?? TextInputAction.next,
        autofocus: widget.autoFocus,
        textAlign: widget.textAlign,
        onChanged: widget.onChanged,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        validator: (String? value) => widget.validator!(value),
        cursorColor: Theme.of(context).colorScheme.secondary,
        decoration: InputDecoration(
          labelText: widget.lable,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              _notVisible = !_notVisible;
            }),
            splashRadius: 16,
            icon: (_notVisible == true)
                ? const Icon(CupertinoIcons.eye)
                : const Icon(CupertinoIcons.eye_slash),
          ),
          focusColor: Theme.of(context).primaryColor,
          border: widget.border,
        ),
      ),
    );
  }
}
