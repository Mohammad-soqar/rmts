import 'package:flutter/material.dart';
import 'package:rmts/ui/views/appointment_view.dart';
import 'package:rmts/ui/views/auth/profile_view.dart';
import 'package:rmts/ui/views/home_view.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const HomeView(),
  const AppointmentView(),
  const ProfileView(),

  //AddPostScreen(),
];
