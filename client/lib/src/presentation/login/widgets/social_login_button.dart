import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.onPress,
  }) : super(key: key);
  final IconData icon;
  final Color color;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50,
      onPressed: onPress,
      icon: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: Icon(icon, color: color, size: 35),
      ),
    );
  }
}
