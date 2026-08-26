import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/features/auth/pages/login_page.dart';
import 'package:tvk_grievance/features/auth/pages/otp_page.dart';
import 'package:tvk_grievance/features/auth/pages/signup_page.dart';
import 'package:tvk_grievance/features/content_details/content_details_page.dart';
import 'package:tvk_grievance/features/grievance/grievance_page.dart';
import 'package:tvk_grievance/features/grievance_details/grievance_details_page.dart';
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

    GoRoute(
      path: AppRoutes.otpPage,
      builder: (context, state) {
        final mobileNumber = state.extra as String? ?? '';

        return OtpPage(mobileNumber: mobileNumber);
      },
    ),

    GoRoute(path: AppRoutes.home, builder: (_, __) => HomePage()),

    GoRoute(path: AppRoutes.helpDesk, builder: (_, __) => HelpDeskPage()),

    GoRoute(path: AppRoutes.grievances, builder: (_, __) => GrievancePage()),

    GoRoute(
      path: '${AppRoutes.contentDetails}/:contentId',
      builder: (context, state) {
        final contentId = state.pathParameters['contentId']!;

        return ContentDetailsPage(contentId: contentId);
      },
    ),

    GoRoute(
      path: '${AppRoutes.grievanceDetails}/:grievanceId',
      builder: (context, state) {
        final grievanceId = state.pathParameters['grievanceId'];

        if (grievanceId == null || grievanceId.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('Invalid grievance ID.')),
          );
        }

        return GrievanceDetailsPage(grievanceId: grievanceId);
      },
    ),
  ],
);
