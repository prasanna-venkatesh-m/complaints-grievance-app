import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvk_grievance/app/widgets/header_text_widget.dart';

import '../home_controller.dart';
import '../home_model.dart';

class LatestUpdatesSection extends StatefulWidget {
  final HomeController controller;

  const LatestUpdatesSection({super.key, required this.controller});

  @override
  State<LatestUpdatesSection> createState() => _LatestUpdatesSectionState();
}

class _LatestUpdatesSectionState extends State<LatestUpdatesSection> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    super.dispose();
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    if (controller.isLoadingUpdates) {
      return const SizedBox(
        height: 280,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final updates = controller.updates;

    if (updates.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          HeaderTextWidget(text: "LATEST UPDATES"),

          const SizedBox(height: 16),

          CarouselSlider.builder(
            itemCount: updates.length,

            itemBuilder: (context, index, realIndex) {
              return UpdateCard(data: updates[index]);
            },

            options: CarouselOptions(
              height: 200,

              viewportFraction: 0.88,

              enlargeCenterPage: true,

              enlargeFactor: 0.2,

              autoPlay: true,

              autoPlayInterval: const Duration(seconds: 3),

              autoPlayAnimationDuration: const Duration(milliseconds: 800),

              autoPlayCurve: Curves.easeInOut,

              padEnds: true,

              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
          ),

          const SizedBox(height: 5),

          Center(
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,

              count: updates.length,

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
  final LatestUpdate data;

  const UpdateCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14, left: 10),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: Colors.black, width: 1.5),

        boxShadow: const [
          BoxShadow(color: Colors.orange, offset: Offset(4, 5), blurRadius: 0),
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
                    Share.share(
                      "${data.title}\n\n"
                      "${data.shortDescription}\n\n"
                      "${data.shareUrl}",
                    );
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
              data.title,

              style: const TextStyle(
                fontWeight: FontWeight.w800,

                fontSize: 17,

                height: 1.3,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              data.shortDescription,

              style: TextStyle(
                color: Colors.grey.shade700,

                fontSize: 14,

                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
