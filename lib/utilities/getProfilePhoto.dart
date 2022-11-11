import 'package:firebasework/utilities/constants.dart';
import 'package:flutter/material.dart';
Widget getProfilePhoto(userImage, context, userEmail) {
  if (userImage == null) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "MyAccount");
      },
      child: CircleAvatar(
        backgroundColor: maincolor,
        radius: 22,
        child: Text(
          userEmail![0].toUpperCase(),
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  } else {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "MyAccount");
      },
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          userImage!,
        ),
      ),
    );
  }
}
