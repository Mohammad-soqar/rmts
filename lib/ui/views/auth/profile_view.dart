import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rmts/data/models/enums/profile_action_type.dart';
import 'package:rmts/ui/widgets/profile/profile_actions_list.dart';
import 'package:rmts/ui/widgets/profile/user_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(top: 12.0),
          child: Text(
        'Profile',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
            ),
        textAlign: TextAlign.start,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
                        const SizedBox(height: 20),

            UserTile(
              name: "John Doe",
         
              onTap: () {},
            ),
            const SizedBox(height: 20),
            ProfileActionsList(
              title: "Preferences",
              actions: [
                ProfileActions(
                  title: "Language",
                  icon: 'assets/icons/Globe.svg',
                  onTap: () {},
                  type: ProfileActionType.push,
                ),
                ProfileActions(
                  title: "Display Mode",
                  icon: 'assets/icons/DisplayMode.svg',
                  onTap: () {},
                  type: ProfileActionType.push,
                ),
                ProfileActions(
                  title: "Notifications",
                  icon: 'assets/icons/Bell.svg',
                  onTap: () {},
                  type: ProfileActionType.toggle,
                ),
              ],
            ),
            const SizedBox(height: 20),
             ProfileActionsList(
              title: "About the App",
              actions: [
                ProfileActions(
                  title: "Privacy & Policy",
                  icon: 'assets/icons/Shield_Warning.svg',
                  onTap: () {},
                  type: ProfileActionType.push,
                ),
                ProfileActions(
                  title: "Support",
                  icon: 'assets/icons/Headphones.svg',
                  onTap: () {},
                  type: ProfileActionType.push,
                ),
                ProfileActions(
                  title: "About the App",
                  icon: 'assets/icons/Info.svg',
                  onTap: () {},
                  type: ProfileActionType.push,
                ),
                ProfileActions(
                  title: "Logout",
                  icon: 'assets/icons/Log_Out.svg',
                  onTap: () {},
                  type: ProfileActionType.push,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
