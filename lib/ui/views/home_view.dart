import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/ui/views/glove_management/glove_view.dart';
import 'package:rmts/ui/widgets/debug_buttons.dart';
import 'package:rmts/ui/widgets/glove_connection_widget.dart';
import 'package:rmts/ui/widgets/glove_data.dart';
import 'package:rmts/ui/widgets/home/custom_app_bar.dart';
import 'package:rmts/ui/widgets/inputs/app_button.dart';
import 'package:rmts/ui/widgets/pill_tile.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import 'package:rmts/viewmodels/fsr_viewmodel.dart';
import 'package:rmts/viewmodels/glove_viewmodel.dart';
import 'package:rmts/viewmodels/vibration_motor_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  void _fetchData() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final gloveViewModel = Provider.of<GloveViewModel>(context, listen: false);

    if (authViewModel.currentPatient != null) {
      final patientId = authViewModel.currentPatient!.uid;
      if (authViewModel.currentPatient!.gloveId.isNotEmpty) {
        await gloveViewModel.fetchGlove(authViewModel.currentPatient!.gloveId);
      }
    } else {
      print("No logged-in patient found.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final gloveViewModel = Provider.of<GloveViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const CustomAppBar(), // ✅ Reuse your custom SliverAppBar

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GloveDataWidget(),
                    const SizedBox(height: 16),
                    Text(
                      'Actions',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                    ),
                    const SizedBox(height: 16),
                    PillTileWidget(
                      pillIcon: "assets/icons/Vibration.svg",
                      pillText: "Vibrate for relief",
                      onTap: () async {
                        context.read<VibrationMotorViewmodel>().startVibMotor();
                      },
                    ),
                    const SizedBox(height: 16),
                    PillTileWidget(
                      pillIcon: "assets/icons/Calendar_Add.svg",
                      pillText: "Book an appointment",
                      onTap: () async {
                        context.read<FSRViewModel>().startFsrTest(
                          authViewModel.currentPatient!.uid,
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    if (gloveViewModel.currentGlove != null)
                      CustomButton(
                        color: Theme.of(context).colorScheme.primary,
                        label:
                            "Glove Page  Status: ${gloveViewModel.currentGlove!.status.name}",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const GloveView()));
                        },
                      ),
                    const SizedBox(height: 16),
                    const DebugButtons(), // ✅ Don't forget to remove in production
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
