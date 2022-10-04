import 'package:flutter/material.dart';

class TitleClickableTile extends StatelessWidget {
  const TitleClickableTile({
    required this.title,
    required this.onTap,
    this.trailing,
    Key? key,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade800,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: <Widget>[
              Text(title),
              const Spacer(),
              if (trailing != null) trailing!,
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward_ios_rounded, size: 15)
            ],
          ),
        ),
      ),
    );
  }
}
