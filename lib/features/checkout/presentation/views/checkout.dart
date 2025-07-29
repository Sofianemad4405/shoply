import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:shopify/features/checkout/presentation/views/widgets/checkout_view_body.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  static const String routeName = Constants.kCheckout;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  void initState() {
    super.initState();
    context.read<CheckoutCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CheckoutViewBody());
  }
}
