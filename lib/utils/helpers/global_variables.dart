import 'package:flutter/material.dart';
import 'package:rmts/ui/views/auth/account.dart';
import 'package:rmts/ui/views/glove_view.dart';
import 'package:rmts/ui/views/home_view.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  HomeView(),
  GloveView(),
  AccountView(),

  //AddPostScreen(),
];
