import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopify/features/Info/cubits/cubit/profile_cubit.dart';
import 'package:shopify/features/Info/model/user_model.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: height * .15,
                  color: const Color.fromARGB(255, 157, 157, 157),
                  width: width,
                ),
                Positioned(
                  bottom: -35,
                  left: width * .05,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(
                        "assets/imgs/photo_2025-06-09_19-35-33.jpg",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.read<ProfileCubit>().user.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  //userName
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "@${context.read<ProfileCubit>().user.name}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Ana bgd t3bt neek 3ayz amoot :)",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Gap(20),

                  //location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Ionicons.location_outline,
                        color: Colors.grey.shade800,
                        size: 20,
                      ),
                      Gap(3),
                      Text(
                        context.read<ProfileCubit>().user.location,
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ],
                  ),

                  //ngl row
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Icon(
                  //           Ionicons.link_outline,
                  //           color: Colors.grey.shade800,
                  //           size: 20,
                  //         ),
                  //         Gap(3),
                  //         Text(
                  //           // https://ngl.link/kg_sofiiaaan1
                  //           "ngl.link/kg_sofiiaaan1",
                  //           style: TextStyle(color: Colors.blue),
                  //         ),
                  //       ],
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Icon(
                  //           Ionicons.calendar_outline,
                  //           color: Colors.grey.shade800,
                  //           size: 16,
                  //         ),
                  //         Gap(3),
                  //         Text(
                  //           "Born 4 Apr 2005",
                  //           style: TextStyle(color: Colors.grey.shade800),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  Gap(10),
                  Row(
                    children: [
                      Text(
                        "${context.read<ProfileCubit>().user.followedBrands?.length} ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Following",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
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
