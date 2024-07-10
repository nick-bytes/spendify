import 'package:budgeto/colors.dart';

import 'package:budgeto/presentation/screens/home_screen/home_screen.dart';

import 'package:budgeto/presentation/screens/user_profile/user_profile.dart';
import 'package:budgeto/presentation/screens/my_wallet/wallet_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../screens/auth/login_screen.dart';

import '../screens/plan/planning_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreen() {
    return const [
      HomeScreen(),
      WalletScreen(),
      PlanningScreeen(),
      UserProfileScreeen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: kGreenNavC,
        activeColorPrimary: kGreenNavC,
        icon: const Icon(Icons.home),
      ),
      PersistentBottomNavBarItem(
          inactiveColorPrimary: kGreenNavC,
          activeColorPrimary: kGreenNavC,
          icon: const Icon(Icons.account_balance_wallet)),
      PersistentBottomNavBarItem(
          inactiveColorPrimary: kGreenNavC,
          activeColorPrimary: kGreenNavC,
          icon: const Icon(Icons.article)),
      PersistentBottomNavBarItem(
          inactiveColorPrimary: kGreenNavC,
          activeColorPrimary: kGreenNavC,
          icon: const Icon(Icons.person)),
    ];
  }

  bool isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PersistentTabView(
              context,
              screens: _buildScreen(),
              items: _navBarItem(),
              controller: controller,
              navBarHeight: 60,
              decoration: const NavBarDecoration(
                  colorBehindNavBar: kGreenColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              padding: const NavBarPadding.all(0),
              backgroundColor: kGreenColor,
              navBarStyle: NavBarStyle.style3,
              itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              ),
              screenTransitionAnimation:
                  const ScreenTransitionAnimation(curve: Curves.ease),
            );
          }

          return const LoginScreen();
        });
  }
}
