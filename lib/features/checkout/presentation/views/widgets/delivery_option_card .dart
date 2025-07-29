import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/text_styles.dart';

class DeliveryOptionCard extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onTap;
  final bool isDefault;

  const DeliveryOptionCard({
    super.key,
    required this.isSelected,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onTap,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFF0FDF4) : Color(0xffEFF0F1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xff22C55E) : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Radio(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onTap(),
              activeColor: Color(0xff22C55E),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyles.blackBold.copyWith(fontSize: 16),
                      ),
                      Gap(20),
                      isDefault
                          ? Container(
                            width: 54.28,
                            height: 19.97,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFDCFCE7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 7.99,
                                  top: 0.97,
                                  child: SizedBox(
                                    width: 38.29,
                                    height: 16.27,
                                    child: Text(
                                      'Default',
                                      style: TextStyle(
                                        color: const Color(0xFF15803D),
                                        fontSize: 10.20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.57,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyles.blackRegular.copyWith(
                      color: Color(0xff4B5563),
                    ),
                  ),
                ],
              ),
            ),
            Text(price, style: TextStyles.blackBold.copyWith(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
