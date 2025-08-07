import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';
import 'package:shopify/core/utils/prefs.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_button.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:shopify/features/profile/presentation/cubit/cubit/profile_cubit.dart';
import 'package:shopify/features/profile/presentation/widgets/custom_list_tile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    loadSavedImage();
  }

  // تحميل الصورة المخزنة
  Future<void> loadSavedImage() async {
    final savedPath = Prefs.getString(
      '${FireBaseAuthService().getCurrentUserId()}/$Constants.profileImageKey',
    );
    if (savedPath != null) {
      setState(() {
        _selectedImage = File(savedPath);
      });
    }
  }

  // اختيار الصورة وتخزين الـ path
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      await Prefs.setString(
        '${FireBaseAuthService().getCurrentUserId()}/$Constants.profileImageKey',
        pickedFile.path,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Gap(10),
            CustomAppBar(isCart: false),
            Gap(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child:
                      _selectedImage != null
                          ? CircleAvatar(
                            radius: 40,
                            backgroundImage: FileImage(_selectedImage!),
                          )
                          : Icon(Icons.add_a_photo, size: 50),
                ),
                Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            duration: Duration(milliseconds: 1500),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is ProfileUpdated) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Profile Updated"),
                            duration: Duration(milliseconds: 1500),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is ProfileLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.user.name, style: TextStyles.blackBold),
                            Gap(3),
                            Text(
                              state.user.email,
                              style: TextStyles.greyMedium,
                            ),
                            Gap(3),
                            GestureDetector(
                              onTap: () {
                                final nameController = TextEditingController(
                                  text: state.user.name,
                                );
                                final emailController = TextEditingController(
                                  text: state.user.email,
                                );
                                final locationController =
                                    TextEditingController(
                                      text: state.user.location,
                                    );
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              CustomTextField(
                                                controller: nameController,
                                                hintText: "Name",
                                                prefixIcon: Icon(Iconsax.user),
                                              ),
                                              Gap(10),
                                              CustomTextField(
                                                controller: emailController,
                                                hintText: "Email",
                                                prefixIcon: Icon(Iconsax.sms),
                                              ),
                                              Gap(10),
                                              CustomTextField(
                                                controller: locationController,
                                                hintText: "Location",
                                                prefixIcon: Icon(
                                                  Iconsax.location,
                                                ),
                                              ),
                                              Gap(10),
                                              CustomButton(
                                                onPressed: () {
                                                  BlocProvider.of<ProfileCubit>(
                                                    context,
                                                  ).updateProfile(
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    location:
                                                        locationController.text,
                                                  );
                                                  context.pop();
                                                },
                                                text: 'Save',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(color: Color(0xff22C55E)),
                              ),
                            ),
                            Gap(10),
                          ],
                        );
                      } else if (state is ProfileLoading) {
                        return CircularProgressIndicator();
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
            Card(
              color: Colors.white,
              elevation: 0,
              child: Column(
                children: [
                  CustomListTile(
                    leadingIcon: "assets/imgs/svgs/my_orders.svg",
                    text: "My Orders",
                    traling: "assets/imgs/svgs/arrow.svg",
                    onTap: () {},
                  ),
                  CustomListTile(
                    leadingIcon: "assets/imgs/svgs/payment_method.svg",
                    text: "Payment Method",
                    traling: "assets/imgs/svgs/arrow.svg",
                    onTap: () {},
                  ),
                  CustomListTile(
                    leadingIcon: "assets/imgs/svgs/help_support.svg",
                    text: "Help & Support",
                    traling: "assets/imgs/svgs/arrow.svg",
                    onTap: () {
                      context.push(Constants.kHelpAndSupport);
                    },
                  ),
                  CustomListTile(
                    leadingIcon: "assets/imgs/svgs/settings.svg",
                    text: "Settings",
                    traling: "assets/imgs/svgs/arrow.svg",
                    onTap: () {},
                  ),
                  CustomListTile(
                    leadingIcon: "assets/imgs/svgs/log_out.svg",
                    text: "Logout",
                    onTap: () async {
                      await FireBaseAuthService().signOut();
                      context.pushAndRemoveUntil(Constants.kSignIn);
                      Prefs.setBool(Constants.kIsLoggedIn, false);
                    },
                    isLogOut: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
