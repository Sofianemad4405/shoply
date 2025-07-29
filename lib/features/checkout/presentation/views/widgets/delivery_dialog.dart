import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:shopify/features/cart/presentation/view/widgets/proceed_to_checkout_button.dart';
import 'package:shopify/features/checkout/domain/entities/delivery_entity.dart';
import 'package:shopify/features/checkout/presentation/cubit/checkout_cubit.dart';

class DeliveryDialog extends StatefulWidget {
  const DeliveryDialog({super.key});

  @override
  State<DeliveryDialog> createState() => _DeliveryDialogState();
}

class _DeliveryDialogState extends State<DeliveryDialog> {
  final formKey = GlobalKey<FormState>();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final governorateController = TextEditingController();
  final countryController = TextEditingController();
  final buildingController = TextEditingController();
  final apartmentController = TextEditingController();
  final zipCodeController = TextEditingController();
  final landmarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add delivery address",
                  style: TextStyles.blackBold.copyWith(fontSize: 16),
                ),
                Gap(10),
                CustomTextField(
                  controller: streetController,
                  hintText: "Street",
                  prefixIcon: Icon(Iconsax.location),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter street";
                    }
                    return null;
                  },
                ),
                Gap(10),
                CustomTextField(
                  controller: cityController,
                  hintText: "City",
                  prefixIcon: Icon(Iconsax.location_tick),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter city";
                    }
                    return null;
                  },
                ),
                Gap(10),
                CustomTextField(
                  controller: governorateController,
                  hintText: "Governorate",
                  prefixIcon: Icon(Iconsax.map_1),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter governorate";
                    }
                    return null;
                  },
                ),
                Gap(10),
                CustomTextField(
                  controller: apartmentController,
                  hintText: "Apartment",
                  prefixIcon: Icon(Iconsax.home_2),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter apartment";
                    }
                    return null;
                  },
                ),
                Gap(10),
                CustomTextField(
                  controller: countryController,
                  hintText: "Country",
                  prefixIcon: Icon(Iconsax.global),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter country";
                    }
                    return null;
                  },
                ),
                Gap(10),
                CustomTextField(
                  controller: zipCodeController,
                  hintText: "Postal Code",
                  prefixIcon: Icon(Iconsax.archive_tick),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter postal code";
                    }
                    return null;
                  },
                ),
                Gap(10),
                CustomTextField(
                  controller: landmarkController,
                  hintText: "Landmark",
                  prefixIcon: Icon(Iconsax.location_add),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter landmark";
                    }
                    return null;
                  },
                ),
                Gap(20),
                SizedBox(
                  height: 50,
                  child: ProceedToCheckOutButton(
                    text: "Add Address",
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        !context.read<CheckoutCubit>().didUserAddDeliveryAddress
                            ? context.read<CheckoutCubit>().addDeliveryAddress(
                              DeliveryEntity(
                                street: streetController.text,
                                city: cityController.text,
                                governate: governorateController.text,
                                country: countryController.text,
                                zipCode: zipCodeController.text,
                                building: buildingController.text,
                                apartment: apartmentController.text,
                                landmark: landmarkController.text,
                                isDeliveryStandard: true,
                              ),
                            )
                            : context
                                .read<CheckoutCubit>()
                                .updateDeliveryAddress(
                                  DeliveryEntity(
                                    street: streetController.text,
                                    city: cityController.text,
                                    governate: governorateController.text,
                                    country: countryController.text,
                                    zipCode: zipCodeController.text,
                                    building: buildingController.text,
                                    apartment: apartmentController.text,
                                    landmark: landmarkController.text,
                                    isDeliveryStandard: true,
                                  ),
                                );
                        context.pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
