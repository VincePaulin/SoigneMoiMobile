import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String sex;

  const CustomAvatar({super.key, this.avatarUrl, required this.sex});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: kToolbarHeight * 0.4,
      // If avatarURL is null or empty, display a default image
      backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
          ? NetworkImage(avatarUrl!)
          : sex == "homme"
              ? const AssetImage('assets/img/avatar_man.png') as ImageProvider
              : const AssetImage('assets/img/avatar_women.png')
                  as ImageProvider,
    );
  }
}
