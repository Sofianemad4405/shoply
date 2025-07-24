import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewListTile extends StatefulWidget {
  const ReviewListTile({
    super.key,
    required this.name,
    required this.email,
    required this.comment,
    required this.image,
    required this.rating,
  });

  final String name;
  final String email;
  final String comment;
  final String image;
  final int rating;

  @override
  State<ReviewListTile> createState() => _ReviewListTileState();
}

class _ReviewListTileState extends State<ReviewListTile> {
  bool isLiked = false;
  Future<void> launchEmail(String email) async {
    // log("SOfian");
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeFull('subject=Hello&body='),
    );
    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap:
          () => setState(() {
            isLiked = !isLiked;
          }),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(widget.image),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => launchEmail(widget.email),
              child: Text(
                widget.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                for (int i = 0; i < widget.rating; i++)
                  Icon(Ionicons.star, color: Colors.amber, size: 12),
              ],
            ),
            Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              widget.comment,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
          child: Icon(
            isLiked ? Ionicons.heart : Ionicons.heart_outline,
            color: isLiked ? Colors.red : Colors.black,
            size: 20,
          ),
        ),
      ),
    );
  }
}
