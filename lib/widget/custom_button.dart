import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.color = Colors.blue,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: textColor),
        label: Text(
          label,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
