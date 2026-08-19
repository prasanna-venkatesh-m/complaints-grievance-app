import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const HomeBottomNav({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  double _getCirclePosition(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemWidth = width / 3;

    return (itemWidth * currentIndex) + (itemWidth / 2) - 35;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 75,

      child: Stack(
        clipBehavior: Clip.none,

        children: [

          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,

            child: Container(
              height: 75,

              decoration: const BoxDecoration(
                color: Color(0XFFa91145),

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),

              child: Row(
                children: [

                  _navItem(
                    icon: FontAwesomeIcons.house,
                    label: l10n.home,
                    index: 0,
                  ),

                  _navItem(
                    icon: FontAwesomeIcons.fileCircleExclamation,
                    label: l10n.grievance,
                    index: 1,
                  ),

                  _navItem(
                    icon: FontAwesomeIcons.headset,
                    label: l10n.helpDesk,
                    index: 2,
                  ),

                ],
              ),
            ),
          ),


          // Animated Floating Circle
          AnimatedPositioned(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOutCubic,

            top: -23,
            left: _getCirclePosition(context),

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,

              height: 70,
              width: 70,

              decoration: const BoxDecoration(
                color: Color(0xffF57C00),
                shape: BoxShape.circle,

                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 12,
                    offset: Offset(0, 5),
                  ),
                ],
              ),

              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),

                transitionBuilder: (child, animation) {

                  return ScaleTransition(
                    scale: animation,

                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },

                child: Icon(
                  _getSelectedIcon(),

                  key: ValueKey(currentIndex),

                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }


  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {

    final selected = currentIndex == index;

    return Expanded(
      child: InkWell(

        onTap: () => onTap?.call(index),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.end,

          children: [

            const SizedBox(height: 8),


            AnimatedScale(
              scale: selected ? 1.15 : 1,

              duration: const Duration(milliseconds: 250),

              child: FaIcon(
                icon,

                size: 22,

                color: selected
                    ? const Color(0xffF57C00)
                    : Colors.white70,
              ),
            ),


            const SizedBox(height: 5),


            AnimatedDefaultTextStyle(

              duration: const Duration(milliseconds: 250),

              style: TextStyle(

                fontSize: selected ? 13 : 12,

                fontWeight: selected
                    ? FontWeight.w700
                    : FontWeight.normal,

                color: selected
                    ? const Color(0xffF57C00)
                    : Colors.white70,
              ),

              child: Text(label),
            ),


            const SizedBox(height: 12),

          ],
        ),
      ),
    );
  }


  IconData _getSelectedIcon() {

    switch (currentIndex) {

      case 0:
        return FontAwesomeIcons.house;

      case 1:
        return FontAwesomeIcons.fileCircleExclamation;

      case 2:
        return FontAwesomeIcons.headset;

      default:
        return FontAwesomeIcons.house;
    }
  }
}