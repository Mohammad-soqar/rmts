import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rmts/data/models/enums/profile_action_type.dart';

class ProfileActionTile extends StatelessWidget{
  final String title;
  final String icon;
  final Function()? onTap;
  final ProfileActionType type;

  const ProfileActionTile({
    required this.title,
    required this.icon,
    required this.type,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:12.0),
      child: Row(children: [
        SvgPicture.asset(
          icon,
          color: Theme.of(context).colorScheme.primary,
         
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
  Container(
    width: 34,
    height: 34,
    child: type == ProfileActionType.push
        ? IconButton(
            onPressed: onTap,
            icon: SvgPicture.asset(
              'assets/icons/Chevron_Right.svg',
              color: Theme.of(context).colorScheme.onSurface,
              width: 34,
              height: 34,
            ),
          )
        : type == ProfileActionType.toggle
            ? Switch(
                value: false,
                onChanged: (value) {},
                activeColor: Theme.of(context).colorScheme.primary,
              )
            : null,
  )
      
       
      ],),
    );
  }
}