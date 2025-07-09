import 'package:flutter/material.dart';
import 'package:shopify/features/auth/presentation/view/sign_up_page_view.dart';

class DonotHaveAnAccount extends StatelessWidget {
  const DonotHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        const SizedBox(width: 6),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, SignUpPageView.routeName);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.padded,
            visualDensity: VisualDensity.comfortable,
          ),
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
        ),
      ],
    );
  }
}
