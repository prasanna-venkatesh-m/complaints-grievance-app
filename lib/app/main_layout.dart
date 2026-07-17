import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/app/widgets/bottom_nav.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({
    super.key,
    required this.child,
  });

  int _getCurrentIndex(String location) {
    if (location.startsWith(AppRoutes.helpDesk)) {
      return 2;
    }

    if (location.startsWith(AppRoutes.grievances)) {
      return 1;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return Scaffold(
      body: child,
      bottomNavigationBar: HomeBottomNav(
        currentIndex: _getCurrentIndex(location),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.home);
              break;

            case 1:
              context.go(AppRoutes.grievances);
              break;

            case 2:
              context.go(AppRoutes.helpDesk);
              break;
          }
        },
      ),
    );
  }
}