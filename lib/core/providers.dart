import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rmts/utils/helpers/app_settings.dart';
import 'package:rmts/viewmodels/appointment_viewmodel.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import 'package:rmts/viewmodels/auth/find_glove_viewmodel.dart';
import 'package:rmts/viewmodels/auth/register_viewmodel.dart';
import 'package:rmts/viewmodels/auth/user_viewmodel.dart';
import 'package:rmts/viewmodels/flex_test_viewmodel.dart';
import 'package:rmts/viewmodels/fsr_viewmodel.dart';
import 'package:rmts/viewmodels/glove_viewmodel.dart';
import 'package:rmts/viewmodels/gloveconnectionviewmodel.dart';
import 'package:rmts/viewmodels/mpu_test_viewmodel.dart';
import 'package:rmts/viewmodels/ppg_test_viewmodel.dart';
import 'package:rmts/viewmodels/reports_viewmodel.dart';
import 'package:rmts/viewmodels/vibration_motor_viewmodel.dart';
import 'package:rmts/viewmodels/glovestatus_viewmodel.dart';

List<SingleChildWidget> appProviders(gloveRepository) => [
  ChangeNotifierProvider(create: (_) => GloveStatusViewModel()),  // The shared instance

  ChangeNotifierProvider(create: (_) => UserViewModel()..fetchUserData()),
  ChangeNotifierProvider(
    create: (context) => MpuTestViewModel(context.read<GloveStatusViewModel>()),
  ),
  ChangeNotifierProvider(
    create: (context) => PpgTestViewModel(context.read<GloveStatusViewModel>()),
  ),
  ChangeNotifierProvider(
    create: (context) => FlexTestViewModel(context.read<GloveStatusViewModel>()),
  ),
  ChangeNotifierProvider(
    create: (context) => FSRViewModel(context.read<GloveStatusViewModel>()),
  ),
  ChangeNotifierProvider(
    create: (_) => GloveConnectionViewModel(targetName: 'RA_Glove_GLOVToBY')..init(),
  ),
  ChangeNotifierProvider(create: (_) => AuthViewModel()),
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
  ChangeNotifierProvider(create: (_) => ReportsViewModel()),
  ChangeNotifierProvider(create: (_) => GloveViewModel(gloveRepository)),
  ChangeNotifierProvider(create: (_) => AppointmentViewmodel()),
  ChangeNotifierProvider(create: (_) => FindGloveViewmodel()),
  ChangeNotifierProvider(create: (_) => VibrationMotorViewmodel()),
  ChangeNotifierProvider(create: (_) => AppSettings()),
];
