import 'package:go_router/go_router.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/features/auth/pages/login_page.dart';
import 'package:tvk_grievance/features/auth/pages/otp_page.dart';
import 'package:tvk_grievance/features/auth/pages/signup_page.dart';
import 'package:tvk_grievance/features/grievance/grievance_page.dart';
import 'package:tvk_grievance/features/helpdesk/contacts.dart';
import 'package:tvk_grievance/features/home/home_page.dart';
import 'package:tvk_grievance/features/splash_screen/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.splashScreen,

  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginPage()),

    GoRoute(path: AppRoutes.signup, builder: (_, __) => const SignupPage()),

    GoRoute(path: AppRoutes.otpPage, builder: (_, __) => const OtpPage()),

    GoRoute(path: AppRoutes.home, builder: (_, __) => HomePage()),

    GoRoute(path: AppRoutes.helpDesk, builder: (_, __) => HelpDeskPage()),

    GoRoute(path: AppRoutes.grievances, builder: (_, __) => GrievancePage()),
  ],
);
