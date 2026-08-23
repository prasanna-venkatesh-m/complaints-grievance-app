import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tvk_grievance/app/providers.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';
import 'package:tvk_grievance/shared/enums/app_language.dart';

import 'content_details_providers.dart';
import 'widgets/content_attachment_card.dart';

class ContentDetailsPage extends ConsumerStatefulWidget {
  final String contentId;

  const ContentDetailsPage({super.key, required this.contentId});

  @override
  ConsumerState<ContentDetailsPage> createState() => _ContentDetailsPageState();
}

class _ContentDetailsPageState extends ConsumerState<ContentDetailsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(contentDetailsControllerProvider.notifier)
          .loadContent(widget.contentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(contentDetailsControllerProvider);

    final language = ref.watch(languageProvider);

    final l10n = AppLocalizations.of(context)!;

    final isTamil = language == AppLanguage.tamil;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffA91145),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          l10n.latestUpdates,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          if (controller.content != null)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {
                _shareContent(controller.content!, isTamil);
              },
            ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(controller: controller, isTamil: isTamil, l10n: l10n),
      ),
    );
  }

  Widget _buildBody({
    required dynamic controller,
    required bool isTamil,
    required AppLocalizations l10n,
  }) {
    if (controller.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xff8A0038)),
      );
    }

    if (controller.errorMessage != null) {
      return _buildErrorState(controller.errorMessage!, controller, l10n);
    }

    final content = controller.content;

    if (content == null) {
      return _buildEmptyState(l10n);
    }

    final title = content.title.valueForLanguage(isTamil: isTamil);

    final shortDescription = content.shortDescription.valueForLanguage(
      isTamil: isTamil,
    );

    final description = content.description.valueForLanguage(isTamil: isTamil);

    return RefreshIndicator(
      color: const Color(0xff8A0038),
      onRefresh: () {
        return controller.loadContent(content.id);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroHeader(content: content, isTamil: isTamil),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // ----------------------------------------------------------
                  // TYPE + CATEGORY
                  // ----------------------------------------------------------
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // TYPE - NORMAL TEXT
                      Text(
                        content.type,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .7,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 10),

                      // CATEGORY - COLORED BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff8A0038),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          content.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ----------------------------------------------------------
                  // TITLE
                  // ----------------------------------------------------------
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      height: 1.2,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ----------------------------------------------------------
                  // POSTED DATE
                  // ----------------------------------------------------------
                  if (content.publishedOn != null)
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 15,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          '${l10n.postedOn} ${_formatDate(content.publishedOn!)}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 22),

                  // ----------------------------------------------------------
                  // SHORT DESCRIPTION - FLAT TEXT
                  // ----------------------------------------------------------
                  if (shortDescription.isNotEmpty) ...[
                    Text(
                      shortDescription,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],

                  // ----------------------------------------------------------
                  // LONG DESCRIPTION
                  // ----------------------------------------------------------
                  if (description.isNotEmpty) ...[
                    _sectionTitle(l10n.description),

                    const SizedBox(height: 10),

                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.75,
                        color: Colors.grey.shade800,
                      ),
                    ),

                    const SizedBox(height: 28),
                  ],

                  // ----------------------------------------------------------
                  // ATTACHMENTS
                  // ----------------------------------------------------------
                  if (content.attachments.isNotEmpty) ...[
                    _sectionTitle(l10n.attachments),

                    const SizedBox(height: 14),

                    ...content.attachments.map((attachment) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: ContentAttachmentCard(
                          attachment: attachment,
                          isTamil: isTamil,
                        ),
                      );
                    }),
                  ],
                  const SizedBox(height: 18),

                  _buildContentEnding(
                    l10n: l10n,
                    content: content,
                    isTamil: isTamil,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // HERO
  // ===========================================================================

  Widget _buildHeroHeader({required dynamic content, required bool isTamil}) {
    final imageUrls = content.imageUrls;

    if (imageUrls.isEmpty) {
      return Container(
        width: double.infinity,
        height: 90,
        color: const Color(0xffA91145),
        alignment: Alignment.center,
        child: const Icon(
          Icons.article_outlined,
          color: Colors.white,
          size: 42,
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrls.first,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xffA91145),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.white,
                  size: 42,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return Container(
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Color(0xff8A0038),
                ),
              );
            },
          ),

          // Dark gradient for a cleaner public-news appearance.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: .35),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION TITLE
  // ===========================================================================

  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 22,
          decoration: BoxDecoration(
            color: const Color(0xff8A0038),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 9),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // ERROR
  // ===========================================================================

  Widget _buildErrorState(
    String message,
    dynamic controller,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black87),
            boxShadow: const [
              BoxShadow(color: Colors.orange, offset: Offset(4, 5)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_off_outlined,
                size: 42,
                color: Color(0xff8A0038),
              ),

              const SizedBox(height: 14),

              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 18),

              ElevatedButton(
                onPressed: () {
                  controller.loadContent(widget.contentId);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8A0038),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // EMPTY
  // ===========================================================================

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          l10n.noDataAvailable,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
        ),
      ),
    );
  }

  // ===========================================================================
  // SHARE
  // ===========================================================================

  void _shareContent(dynamic content, bool isTamil) {
    final title = content.title.valueForLanguage(isTamil: isTamil);

    final shortDescription = content.shortDescription.valueForLanguage(
      isTamil: isTamil,
    );

    final shareText = StringBuffer()
      ..writeln(title)
      ..writeln();

    if (shortDescription.isNotEmpty) {
      shareText
        ..writeln(shortDescription)
        ..writeln();
    }

    Share.share(shareText.toString());
  }

  // ===========================================================================
  // DATE
  // ===========================================================================

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date.toLocal());
  }
}
