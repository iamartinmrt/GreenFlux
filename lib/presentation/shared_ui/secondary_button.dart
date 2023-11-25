import 'package:flutter/material.dart';
import 'package:green_flux/core/color/color_palette.dart';

class SecondaryButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final String? icon;

  const SecondaryButton({
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
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
          color: ColorPalette.black,
          width: 1,
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[Image.asset(icon!)],
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
