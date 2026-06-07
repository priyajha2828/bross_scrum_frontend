import 'package:flutter/material.dart';

class loginpageButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Color iconColor;
  final VoidCallback onPressed;

  const loginpageButton({
    super.key,
    required this.label,
    required this.iconData,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 36),
        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        foregroundColor: Colors.black,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(iconData, color: iconColor, size: 22),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF253858)),
            ),
          )
        ],
      ),
    );
  }
}