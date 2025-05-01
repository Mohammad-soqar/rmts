import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Function()? onTap;

  const UserTile({
    required this.name,
    this.imageUrl =
        'assets/icons/Avatar.png',
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22.0, 16.0, 22.0, 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
                CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                radius: 30.0, // 60x60 size (radius is half the diameter)
                ),
              const SizedBox(width: 12.0),
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ],
            ),
            IconButton(
            icon: SvgPicture.asset(
              'assets/icons/Note_Edit.svg',
              height: 30.0,
              width: 30.0,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: onTap,
            tooltip: 'Edit',
            ),
        ],
      ),
    );
  }
}
