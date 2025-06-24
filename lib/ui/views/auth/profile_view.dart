import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/data/models/enums/profile_action_type.dart';
import 'package:rmts/main.dart';
import 'package:rmts/ui/views/auth/edit_personal_data_view.dart';
import 'package:rmts/ui/views/auth/login_view.dart';
import 'package:rmts/ui/widgets/profile/profile_actions_list.dart';
import 'package:rmts/ui/widgets/profile/user_tile.dart';
import 'package:rmts/utils/helpers/app_settings.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void _logOut() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    await authViewModel.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );
    }
  }

  void _showLanguageSelector(BuildContext context) {
    final settings = Provider.of<AppSettings>(context, listen: false);
    final currentLang = settings.locale.languageCode;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              trailing: currentLang == 'en' ? const Icon(Icons.check) : null,
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('language_code', 'en');
                settings.setLocale(const Locale('en'));
                if (mounted) Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Arabic'),
              trailing: currentLang == 'ar' ? const Icon(Icons.check) : null,
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('language_code', 'ar');
                settings.setLocale(const Locale('ar'));
                if (mounted) Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Turkish'),
              trailing: currentLang == 'tr' ? const Icon(Icons.check) : null,
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('language_code', 'tr');
                settings.setLocale(const Locale('tr'));
                if (mounted) Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDisplayModeSelector(BuildContext context) {
    final settings = Provider.of<AppSettings>(context, listen: false);

    final currentMode = settings.themeMode;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Light Mode'),
                trailing: currentMode == ThemeMode.light
                    ? const Icon(Icons.check)
                    : null,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('display_mode', 'light');
                  settings.setThemeMode(ThemeMode.light);
                  if (mounted) Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Dark Mode'),
                trailing: currentMode == ThemeMode.dark
                    ? const Icon(Icons.check)
                    : null,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('display_mode', 'dark');
                  settings.setThemeMode(ThemeMode.dark);
                  if (mounted) Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('System Default'),
                trailing: currentMode == ThemeMode.system
                    ? const Icon(Icons.check)
                    : null,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('display_mode', 'system');
                  settings.setThemeMode(ThemeMode.system);
                  if (mounted) Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditPersonalDataView(
                  patient: authViewModel
                      .currentPatient!, // Replace with your actual Patient object
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 12.0),
            child: Text(
              'Profile',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.start,
            ),
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
                  onTap: () {
                    _showLanguageSelector(context);
                  },
                  type: ProfileActionType.push,
                ),
                ProfileActions(
                  title: "Display Mode",
                  icon: 'assets/icons/DisplayMode.svg',
                  onTap: () {
                    _showDisplayModeSelector(context);
                  },
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
                  onTap: _logOut,
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
