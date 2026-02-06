import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isProfile;

  const AppbarWidget({super.key, required this.title, this.isProfile = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: !isProfile,
      automaticallyImplyLeading: false,
      leading: isProfile
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 25,
        ),
      ),
      backgroundColor: const Color(0xFF1C1F24),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
