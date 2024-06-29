import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leo_final/pages/achievement/achievement_screen.dart';
import 'package:leo_final/pages/achievement/active_achievements_page.dart';
import 'package:leo_final/pages/achievement/all_achievements_page.dart';
import 'package:leo_final/pages/achievement/charm_achievements_page.dart';
import 'package:leo_final/pages/achievement/consumption_achievements_page.dart';
import 'package:leo_final/pages/achievement/recharge_achievements_page.dart';
import 'package:leo_final/pages/feedback/feedback_screen.dart';
import 'package:leo_final/pages/invite%20friends/invite_screen.dart';
import 'package:leo_final/pages/language/language_screen.dart';
import 'package:leo_final/pages/level/level_screen.dart';
import 'package:leo_final/pages/nobel/nobel_screen.dart';
import 'package:leo_final/pages/settings/settings_screen.dart';
import 'package:leo_final/pages/svip/svip_screen.dart';
import 'package:leo_final/pages/wallet/wallet_screen.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart'; // Add this import

import 'package:leo_final/pages/home%20page/bloc/home_page_bloc.dart';
import 'package:leo_final/pages/welcome%20page/welcome_page.dart';
import 'package:leo_final/zego%20files/initial.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'pages/home page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ZIMKit().init(
    appID: Initial.id,
    appSign: Initial.signIn,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<Map<String, dynamic>?> _checkUserLoggedIn() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/user.json');
    if (await file.exists()) {
      final userJson = await file.readAsString();
      final userData = jsonDecode(userJson) as Map<String, dynamic>;
      return userData;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _checkUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          final userData = snapshot.data!;
          final userId = userData['user_id'];
          final name = userData['name'] ?? 'Unknown';
          final about = userData['about'] ?? 'Unknown';
          return BlocProvider(
            create: (context) => HomePageBloc(),
            child: ScreenUtilInit(
              builder: (context, child) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: MyHomePage(userId: userId, about: about, name: name),
                  routes: {
                    '/wallet': (context) => const WalletScreen(),
                  }),
            ),
          );
        } else {
          return BlocProvider(
            create: (context) => HomePageBloc(),
            child: ScreenUtilInit(
              builder: (context, child) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: const MyHomePage(
                      userId: '1', about: 'Unknown', name: 'Unknown'),
                  routes: {
                    '/wallet': (context) => const WalletScreen(),
                    '/achievement': (context) => const AchievementPage(),
                    '/invite': (context) => const InviteFriendsPage(),
                    '/nobel': (context) => const NobelScreen(),
                    '/svip': (context) => const SvipScreen(),
                    '/level': (context) => const LevelScreen(),
                    '/language': (context) => const LanguageScreen(),
                    '/feedback': (context) => const FeedbackScreen(),
                    '/settings': (context) => const SettingsScreen(),
                    '/all': (context) => AllAchievementsPage(),
                    '/active': (context) => ActiveAchievementsPage(),
                    '/charm': (context) => CharmAchievementsPage(),
                    '/recharge': (context) => RechargeAchievementsPage(),
                    '/consumption': (context) => ConsumptionAchievementsPage(),
                  }),
            ),
          );
        }
      },
    );
  }
}
