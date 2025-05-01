import 'package:flutter/material.dart';
import 'package:rmts/data/models/enums/profile_action_type.dart';
import 'package:rmts/ui/widgets/profile/profile_action_tile.dart';

class ProfileActionsList extends StatelessWidget {
  final String title;
  final List<ProfileActions> actions;

  const ProfileActionsList({
    required this.title,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500
              ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),

        /// Add a line to separate the tiles
        ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                ProfileActionTile(
                  title: actions[index].title,
                  icon: actions[index].icon,
                  onTap: actions[index].onTap,
                  type: actions[index].type,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ), // Add a line to separate the tiles
              ],
            );
          },
          itemCount: actions.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}

class ProfileActions {
  final String title;
  final String icon;
  final Function()? onTap;
  final ProfileActionType type;

  const ProfileActions({
    required this.title,
    required this.icon,
    required this.type,
    this.onTap,
  });
}
