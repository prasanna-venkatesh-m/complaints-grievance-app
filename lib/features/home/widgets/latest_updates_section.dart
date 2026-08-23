import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvk_grievance/app/providers.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/app/widgets/header_text_widget.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';
import 'package:tvk_grievance/shared/enums/app_language.dart';

import '../home_model.dart';
import '../home_providers.dart';

class LatestUpdatesSection extends ConsumerStatefulWidget {
  const LatestUpdatesSection({super.key});

  @override
  ConsumerState<LatestUpdatesSection> createState() =>
      _LatestUpdatesSectionState();
}

class _LatestUpdatesSectionState extends ConsumerState<LatestUpdatesSection> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(homeControllerProvider);

    final language = ref.watch(languageProvider);

    final l10n = AppLocalizations.of(context)!;

    final isTamil = language == AppLanguage.tamil;

    if (controller.isLoadingContents) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTextWidget(text: l10n.latestUpdates),
            const SizedBox(height: 16),
            const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      );
    }

    if (controller.contentErrorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTextWidget(text: l10n.latestUpdates),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.cloud_off_outlined,
                    size: 36,
                    color: Color(0xff8A0038),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.contentErrorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: controller.loadLatestContents,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff8A0038),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final contents = controller.contents;

    if (contents.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTextWidget(text: l10n.latestUpdates),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'No latest updates available.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ),
          ],
        ),
      );
    }

    if (activeIndex >= contents.length) {
      activeIndex = 0;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTextWidget(text: l10n.latestUpdates),

          const SizedBox(height: 16),

          CarouselSlider.builder(
            itemCount: contents.length,
            itemBuilder: (context, index, realIndex) {
              return UpdateCard(data: contents[index], isTamil: isTamil);
            },
            options: CarouselOptions(
              height: 200,
              viewportFraction: 0.88,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              autoPlay: contents.length > 1,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOut,
              padEnds: true,
              onPageChanged: (index, reason) {
                if (!mounted) {
                  return;
                }

                setState(() {
                  activeIndex = index;
                });
              },
            ),
          ),

          const SizedBox(height: 5),

          if (contents.length > 1)
            Center(
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: contents.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Color(0xff8A0038),
                  dotColor: Colors.grey,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class UpdateCard extends StatelessWidget {
  final Content data;
  final bool isTamil;

  const UpdateCard({super.key, required this.data, required this.isTamil});

  @override
  Widget build(BuildContext context) {
    final title = data.title.valueForLanguage(isTamil: isTamil);

    final shortDescription = data.shortDescription.valueForLanguage(
      isTamil: isTamil,
    );

    final shareUrl = data.registrationUrl;

    return GestureDetector(
      onTap: () {
        context.push('${AppRoutes.contentDetails}/${data.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14, left: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.orange,
              offset: Offset(4, 5),
              blurRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff8A0038),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      data.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      final shareText = StringBuffer()
                        ..writeln(title)
                        ..writeln()
                        ..writeln(shortDescription);

                      if (shareUrl != null && shareUrl.isNotEmpty) {
                        shareText
                          ..writeln()
                          ..writeln(shareUrl);
                      }

                      Share.share(shareText.toString());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.shareNodes,
                        size: 15,
                        color: Color(0xff8A0038),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                shortDescription,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
