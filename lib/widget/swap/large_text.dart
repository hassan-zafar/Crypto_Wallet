import 'package:flutter/material.dart';

import '../../backend/all_backends.dart';
import '../../helpers/decimals.dart';

class LargeTextField extends StatelessWidget {
  const LargeTextField({
    Key? key,
    required this.onChanged,
    required this.prefix,
    this.suffixTap,
    this.controller,
  }) : super(key: key);

  final Function(String p1)? onChanged;
  final Widget prefix;
  final void Function()? suffixTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    // AllBackEnds _allBackEnds = AllBackEnds();

    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      inputFormatters: [DecimalTextInputFormatter()],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefix: prefix,
        suffix: InkWell(
          onTap: suffixTap,
          child: const Text('Max',),
        ),
        suffixStyle: const TextStyle(fontSize: 20),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
