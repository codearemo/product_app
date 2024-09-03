import 'package:assessment/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppEmptyList extends StatelessWidget {
  const AppEmptyList({
    super.key,
    this.onPressed,
    this.buttonText = 'Refresh',
    required this.message,
  });

  final String? message;
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.file_open_outlined,
          size: 60.sp,
          color: Colors.black54,
        ),
        S.h(20),
        Text(
          '$message',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black38,
          ),
        ),
        if (onPressed != null) ...[
          S.h(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Color(0xFFFF7643),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
