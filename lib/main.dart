import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/admin_exclusive/payment_logs_main.dart';
import 'package:tessarus_volunteer/screens/admin_exclusive/system_log_page.dart';
import 'package:tessarus_volunteer/screens/cashier_exclusive/add_coins.dart';
import 'package:tessarus_volunteer/screens/dashboard/dashboard_main.dart';
import 'package:tessarus_volunteer/screens/developer_contact/developer_contact_main.dart';
import 'package:tessarus_volunteer/screens/event/event_page.dart';
import 'package:tessarus_volunteer/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/screens/splash_screens/splash1.dart';
import 'package:tessarus_volunteer/screens/super_admin_exclusive/volunteer_control.dart';
import 'package:tessarus_volunteer/screens/ticket_scan/ticket_scan_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Tessarus Staging',
    theme: ThemeData(fontFamily: 'lato'),
    debugShowCheckedModeBanner: false,
    home: const SplashScreen1(StartScreen(), 5),
  ));
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool go = false;
  String drawer1 = 'Sample';
  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? token = prefs.getBool("signIn");
    final String? drawerval = prefs.getString("DrawerItem");
    if (token == true) {
      go = true;
    }
    drawer1 = (drawerval ?? 'Sample');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkToken(),
          builder: ((context, snapshot) {
            if (go == true && drawer1 != 'Sample') {
              switch (drawer1) {
                case 'Dashboard':
                  return const DashboardMain();

                case 'Event':
                  return const EventPage();

                case 'Ticket Scan':
                  return const TicketScanMain();

                case 'Add Amount':
                  return const AddCoins();

                case 'Volunteer Control':
                  return const VolunteerControl();

                case 'System Logs':
                  return const SystemLogsPage();

                case 'Payment Logs':
                  return const PaymentLogsMain();

                case 'Developer Contact':
                  return const DeveloperContactMain();
                default:
                  return const EventPage();
              }
            } else if (go == true) {
              return const EventPage();
            } else {
              return const LoginScreen();
            }
          })),
    );
  }
}
