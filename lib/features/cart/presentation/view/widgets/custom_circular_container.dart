import 'package:flutter/material.dart';

class CustomCircularContainer extends StatefulWidget {
  const CustomCircularContainer({super.key, this.onTap, this.text, this.icon});

  final void Function()? onTap;
  final String? text;
  final IconData? icon;

  @override
  State<CustomCircularContainer> createState() =>
      _CustomCircularContainerState();
}

class _CustomCircularContainerState extends State<CustomCircularContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.onTap,
      onTap: widget.onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border:
              widget.icon == null
                  ? Border.all(color: Colors.grey.shade500)
                  : null,
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child:
              widget.icon != null
                  ? Icon(widget.icon, size: 24, color: Colors.red)
                  : Text(
                    widget.text!,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
        ),
      ),
    );
  }
}
