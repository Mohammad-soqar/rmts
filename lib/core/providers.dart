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

List<SingleChildWidget> appProviders(gloveRepository) => [
      ChangeNotifierProvider(create: (_) => UserViewModel()..fetchUserData()),
      ChangeNotifierProvider(create: (_) => MpuTestViewModel()),
      ChangeNotifierProvider(create: (_) => PpgTestViewModel()),
      ChangeNotifierProvider(create: (_) => FlexTestViewModel()),
      ChangeNotifierProvider(
        create: (_) =>
            GloveConnectionViewModel(targetName: 'RA_Glove_GLOVTY')..init(),
      ),
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => RegisterViewModel()),
      ChangeNotifierProvider(create: (_) => ReportsViewModel()),
      ChangeNotifierProvider(create: (_) => GloveViewModel(gloveRepository)),
      ChangeNotifierProvider(create: (_) => AppointmentViewmodel()),
      ChangeNotifierProvider(create: (_) => FindGloveViewmodel()),
      ChangeNotifierProvider(create: (_) => VibrationMotorViewmodel()),
      ChangeNotifierProvider(create: (_) => FSRViewModel()),
       ChangeNotifierProvider(create: (_) => AppSettings()),
    ];
