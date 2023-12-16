import 'package:flutter/material.dart';

class SocialAccountsWidget extends StatelessWidget {
  final String? socialAccountName;
  final VoidCallback onTap;
  const SocialAccountsWidget({
    super.key,
    required this.onTap,
    this.socialAccountName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(socialAccountName!,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                )),
      ),
    );
  }
}
