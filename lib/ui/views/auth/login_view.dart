import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/ui/responsive/mobile_screen_layout.dart';
import 'package:rmts/ui/widgets/inputs/app_button.dart';
import 'package:rmts/ui/widgets/inputs/app_text_field.dart';
import 'package:rmts/utils/snackbar.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      String res = await authViewModel.signIn(context);
      if (res != 'success') {
        showSnackBar(res, context);
      } else {
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
          (route) => false,
        );
      }
    }
  }

//TODO: Remove this function in production
 void _autoSignIn() async {
  final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
  
  authViewModel.passwordController.text = "Soqar4ever101@";
  authViewModel.emailController.text = "mnsoqar2@gmail.com";

  String res = await authViewModel.signIn(context);

  if (res != 'success') {
    showSnackBar(res, context);
  } else {
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
      (route) => false,
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             
                SvgPicture.asset(
                  "assets/rmtslogo.svg",
                  color: Theme.of(context).colorScheme.primary,
                  fit: BoxFit.contain,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 80),
                AppTextField(
                  labelText: 'Email or Phone Number',
                  controller:
                      Provider.of<AuthViewModel>(context).emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  labelText: 'Password',
                  controller:
                      Provider.of<AuthViewModel>(context).passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                if (authViewModel.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      authViewModel.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomButton(
                    color: Theme.of(context).colorScheme.primary,
                    label: "Login",
                    onPressed: _signIn,
                  ),
                ),
              
                const SizedBox(height: 10),
                //forgot password button
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
