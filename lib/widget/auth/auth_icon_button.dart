import 'package:flutter/material.dart';

class AuthIconButton extends StatelessWidget {
  const AuthIconButton({
    required this.onTap,
    this.icon,
    this.imagePath,
    Key? key,
  }) : super(key: key);
  final IconData? icon;
  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 48,
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: FittedBox(
              child: (icon != null)
                  ? Icon(icon!)
                  : imagePath != null
                      ? Image.asset(imagePath!, fit: BoxFit.fitHeight)
                      : const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
