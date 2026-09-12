import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../shared/enums/app_language.dart';

class LanguageButton extends ConsumerWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    final isTamil = currentLanguage == AppLanguage.tamil;

    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: GestureDetector(
        onTap: () {
          ref.read(languageProvider.notifier).setLanguage(
                isTamil
                    ? AppLanguage.english
                    : AppLanguage.tamil,
              );
        },
        child: Container(
          height: 28,
          width: 72,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: const Color(0xffEEF0F3),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xffD9DDE3),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              // English
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: !isTamil
                        ? const Color(0xffA91145)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'EN',
                    style: TextStyle(
                      color: !isTamil
                          ? Colors.white
                          : const Color(0xff30343B),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              // Tamil
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isTamil
                        ? const Color(0xffA91145)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'த',
                    style: TextStyle(
                      color: isTamil
                          ? Colors.white
                          : const Color(0xff30343B),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeLanguageButton extends ConsumerWidget {
  const HomeLanguageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);

    final isTamil = currentLanguage == AppLanguage.tamil;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          ref
              .read(languageProvider.notifier)
              .setLanguage(isTamil ? AppLanguage.english : AppLanguage.tamil);
        },
        child: SizedBox(
          height: 82,
          child: Stack(
            children: [
              // =====================================================
              // GOLD OFFSET LAYER
              // =====================================================
              Positioned(
                left: 4,
                top: 4,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4A017),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              // =====================================================
              // MAIN CARD
              // =====================================================
              Positioned(
                left: 0,
                top: 0,
                right: 4,
                bottom: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.black87, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      // =================================================
                      // LANGUAGE ICON
                      // =================================================
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFA91145),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.language_rounded,
                          color: Color(0xFFFFC107),
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 14),

                      // =================================================
                      // LANGUAGE TEXT
                      // =================================================
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isTamil ? 'மொழி' : 'LANGUAGE',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),

                            const SizedBox(height: 3),

                            Text(
                              isTamil ? 'தமிழ்' : 'English',
                              style: const TextStyle(
                                color: Color(0xFFA91145),
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // =================================================
                      // SWITCH LANGUAGE
                      // =================================================
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC107),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black87, width: 1.2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isTamil ? 'English' : 'தமிழ்',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            const SizedBox(width: 5),

                            const Icon(
                              Icons.swap_horiz_rounded,
                              color: Colors.black,
                              size: 19,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
