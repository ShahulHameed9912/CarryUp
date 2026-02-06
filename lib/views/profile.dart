import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F232A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              /// Title
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              /// Main Card
              _profileCard([
                _profileItem(
                  icon: Icons.shopping_bag,
                  iconColor: Color(0xFFFFB74D),
                  title: 'My Orders',
                ),
                _divider(),
                _profileItem(
                  icon: Icons.location_on,
                  iconColor: Color(0xFFFFB74D),
                  title: 'Saved Addresses',
                ),
                _divider(),
                _profileItem(
                  icon: Icons.settings,
                  iconColor: Colors.grey,
                  title: 'Settings',
                ),
              ]),

              const SizedBox(height: 16),

              /// Logout Card
              _profileCard([
                _profileItem(
                  icon: Icons.logout,
                  iconColor: Colors.grey,
                  title: 'Log Out',
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  /// Card Wrapper
  static Widget _profileCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2F38),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(children: children),
    );
  }

  /// Single Row Item
  static Widget _profileItem({
    required IconData icon,
    required Color iconColor,
    required String title,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: () {},
    );
  }

  /// Divider
  static Widget _divider() {
    return const Divider(
      height: 1,
      thickness: 0.6,
      color: Colors.grey,
      indent: 56,
    );
  }
}
