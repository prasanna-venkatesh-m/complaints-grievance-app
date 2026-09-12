
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/core/network/dio_provider.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({
    super.key,
  });

  Future<void> _logout(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            l10n.logout,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            l10n.logoutConfirmation,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: Text(
                l10n.cancel,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffA91145),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: Text(
                l10n.logout,
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    try {
      final authService = ref.read(authServiceProvider);
      await authService.clearAllLocalStorage();
      if (!context.mounted) {
        return;
      }
      context.go(AppRoutes.login);
    } catch (error) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to logout. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: GestureDetector(
        onTap: () => _logout(context, ref),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.rightFromBracket,
            color: Colors.white,
            size: 19,
          ),
        ),
      ),
    );
  }
}
