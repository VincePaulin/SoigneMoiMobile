import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:soigne_moi_mobile/model/doctor.dart';

import 'custom_avatar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Doctor doctor;
  const CustomAppBar({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      title: Row(
        children: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text('Se déconnecter'),
                    onTap: () async {
                      final FlutterSecureStorage secureStorage =
                          FlutterSecureStorage();
                      await secureStorage.delete(key: 'access_token');
                      // Navigate to the login page
                      if (context.mounted) context.go('/');
                    },
                  ),
                )
              ];
            },
            icon: CustomAvatar(
              sex: doctor.sex,
              avatarUrl: doctor.avatarURL,
            ),
          ),
          const SizedBox(
            width: 2.0,
          ),
          Text(
            doctor.fullName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          CircleAvatar(
            radius: kToolbarHeight *
                0.4, // CircleAvatar size adapted to AppBar height
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/img/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
