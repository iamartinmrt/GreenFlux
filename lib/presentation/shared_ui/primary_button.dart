import 'package:flutter/material.dart';
import 'package:green_flux/core/color/color_palette.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final String? icon;

  const PrimaryButton({
    this.onTap,
    required this.text,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(icon != null)...[
              Image.asset(icon!, width: 17, height: 17, color: ColorPalette.black)
            ],
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
