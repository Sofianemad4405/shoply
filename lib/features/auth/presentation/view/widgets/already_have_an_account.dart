import 'package:flutter/material.dart';
import 'package:shopify/core/constants.dart';
import 'package:shopify/features/auth/presentation/view/sign_in_page_view.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Constants.kAlreadyHaveAnAccount,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        const SizedBox(width: 6),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SigninPageView()),
            );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.padded,
            visualDensity: VisualDensity.comfortable,
          ),
          child: Text(
            Constants.kSignIn,
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
