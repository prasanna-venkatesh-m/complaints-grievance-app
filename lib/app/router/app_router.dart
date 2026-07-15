import 'package:go_router/go_router.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/features/auth/pages/login_page.dart';
import 'package:tvk_grievance/features/auth/pages/otp_page.dart';
import 'package:tvk_grievance/features/auth/pages/signup_page.dart';
import 'package:tvk_grievance/features/home/home_page.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,

  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (_, __) => const LoginPage(),
    ),

    GoRoute(
      path: AppRoutes.signup,
      builder: (_, __) => const SignupPage(),
    ),

    GoRoute(
      path: AppRoutes.otpPage,
      builder: (_, __) => const OtpPage(),
    ),

        GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => HomePage(),
    ),
  ],
);