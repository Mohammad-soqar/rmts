import 'package:flutter/material.dart';

void _showLanguageSelector(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              // TODO: Update language in your app
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Arabic'),
            onTap: () {
              // TODO: Update language in your app
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Turkish'),
            onTap: () {
              // TODO: Update language in your app
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void _showDisplayModeSelector(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Light Mode'),
            onTap: () {
              // TODO: Set light mode (e.g., using Provider or Theme)
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Dark Mode'),
            onTap: () {
              // TODO: Set dark mode (e.g., using Provider or Theme)
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('System Default'),
            onTap: () {
              // TODO: Set system mode
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
