import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tvk_grievance/app/widgets/header_text_widget.dart';
import 'package:tvk_grievance/features/home/home_controller.dart';
import 'package:tvk_grievance/features/home/home_model.dart';
import 'package:tvk_grievance/features/home/home_providers.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

class DashboardCard extends ConsumerStatefulWidget {
  const DashboardCard({
    super.key,
  });

  @override
  ConsumerState<DashboardCard> createState() =>
      _DashboardCardState();
}

class _DashboardCardState
    extends ConsumerState<DashboardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, .15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(
      homeControllerProvider,
    );

    final l10n = AppLocalizations.of(context)!;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              HeaderTextWidget(
                text: l10n.grievanceDashboard,
              ),
              const SizedBox(height: 12),
              _buildDashboardContent(
                context,
                controller,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =======================
  // DASHBOARD CONTENT
  // =======================

  Widget _buildDashboardContent(
    BuildContext context,
    HomeController controller,
  ) {
    // =======================
    // LOADING
    // =======================

    if (controller.isLoadingDashboard &&
        controller.dashboard == null) {
      return _buildDashboardContainer(
        child: const SizedBox(
          height: 220,
          child: Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFFC107),
            ),
          ),
        ),
      );
    }

    // =======================
    // ERROR
    // =======================

    if (controller.dashboardErrorMessage != null &&
        controller.dashboard == null) {
      return _buildDashboardContainer(
        child: _buildErrorState(
          context,
          controller,
        ),
      );
    }

    final dashboard = controller.dashboard;

    // =======================
    // EMPTY
    // =======================

    if (dashboard == null) {
      return _buildDashboardContainer(
        child: const SizedBox(
          height: 150,
          child: Center(
            child: Text(
              'No dashboard data available.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          ),
        ),
      );
    }

    // =======================
    // SUCCESS
    // =======================

    return _buildDashboardContainer(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // =======================
          // KPI CARDS
          // =======================

          Row(
            children: [
              Expanded(
                child: AnimatedStatCard(
                  number:
                      dashboard.resolvedCount.toString(),
                  title: 'RESOLVED',
                  delay: 0,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: AnimatedStatCard(
                  number:
                      dashboard.inProgressCount.toString(),
                  title: 'IN PROGRESS',
                  delay: 150,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: AnimatedStatCard(
                  number:
                      dashboard.resolvedPercentage
                          .toStringAsFixed(0),
                  suffix: '%',
                  title: 'RESOLVED',
                  delay: 300,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // =======================
          // LATEST GRIEVANCE
          // =======================

          _buildLatestGrievance(
            dashboard.latestGrievance,
          ),
        ],
      ),
    );
  }

  // =======================
  // DASHBOARD CONTAINER
  // =======================

  Widget _buildDashboardContainer({
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff1A1A1A),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Colors.orange,
            offset: Offset(4, 5),
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }

  // =======================
  // ERROR STATE
  // =======================

  Widget _buildErrorState(
    BuildContext context,
    HomeController controller,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 16),

          const Icon(
            Icons.error_outline,
            color: Color(0xFFFFC107),
            size: 36,
          ),

          const SizedBox(height: 10),

          Text(
            controller.dashboardErrorMessage ??
                'Unable to load dashboard.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 14),

          ElevatedButton(
            onPressed: _retryDashboard,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFFFFC107),
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            child: const Text(
              'Retry',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // =======================
  // RETRY
  // =======================

  Future<void> _retryDashboard() async {
    await ref
        .read(homeControllerProvider)
        .loadHomeData();
  }

  // =======================
  // LATEST GRIEVANCE
  // =======================

  Widget _buildLatestGrievance(
    LatestGrievance? grievance,
  ) {
    // =======================
    // NO GRIEVANCE
    // =======================

    if (grievance == null) {
      return Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Ticket',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0,
              minHeight: 6,
              backgroundColor: Colors.white24,
              valueColor:
                  AlwaysStoppedAnimation(
                Color(0xFFFFC107),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'No grievance submitted yet.',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      );
    }

    // =======================
    // API DATA
    // =======================

    final description =
        grievance.description.trim().isNotEmpty
            ? grievance.description
            : 'Latest grievance';

    final ticketId =
        grievance.ticketId.trim();

    final status =
        grievance.latestStatus.trim().isNotEmpty
            ? grievance.latestStatus
            : 'UNKNOWN';

    final progress =
        _statusProgress(status);

    final statusDate =
        _formatDateTime(
      grievance.latestStatusTime,
    );

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        // =======================
        // TICKET + TICKET ID
        // =======================

        Row(
          children: [
            Expanded(
              child: Text(
                'Ticket: $description',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            if (ticketId.isNotEmpty) ...[
              const SizedBox(width: 8),

              Text(
                '#$ticketId',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFFFFC107),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 12),

        // =======================
        // PROGRESS BAR
        // =======================

        TweenAnimationBuilder<double>(
          tween: Tween(
            begin: 0,
            end: progress,
          ),
          duration:
              const Duration(seconds: 2),
          curve: Curves.easeOut,
          builder: (
            context,
            value,
            child,
          ) {
            return ClipRRect(
              borderRadius:
                  BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 6,
                backgroundColor:
                    Colors.white24,
                valueColor:
                    const AlwaysStoppedAnimation(
                  Color(0xFFFFC107),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 10),

        // =======================
        // STATUS + DATE
        // =======================

        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Status: $status',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ),

            if (statusDate.isNotEmpty) ...[
              const SizedBox(width: 12),

              Text(
                statusDate,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  // =======================
  // STATUS PROGRESS
  // =======================

  double _statusProgress(
    String status,
  ) {
    switch (status.toUpperCase()) {
      case 'SUBMITTED':
        return .20;

      case 'IN_PROGRESS':
      case 'IN PROGRESS':
        return .50;

      case 'FORWARDED':
        return .60;

      case 'UNDER_REVIEW':
      case 'UNDER REVIEW':
        return .65;

      case 'RESOLVED':
        return 1.0;

      case 'CLOSED':
        return 1.0;

      case 'REJECTED':
        return 1.0;

      default:
        return .20;
    }
  }

  // =======================
  // DATE FORMAT
  // =======================

  String _formatDateTime(
    DateTime? dateTime,
  ) {
    if (dateTime == null) {
      return '';
    }

    final localDate =
        dateTime.toLocal();

    final day =
        localDate.day
            .toString()
            .padLeft(2, '0');

    final month =
        localDate.month
            .toString()
            .padLeft(2, '0');

    final year =
        localDate.year.toString();

    final hour =
        localDate.hour
            .toString()
            .padLeft(2, '0');

    final minute =
        localDate.minute
            .toString()
            .padLeft(2, '0');

    return '$day/$month/$year $hour:$minute';
  }
}

// =======================
// ANIMATED STAT CARD
// =======================

class AnimatedStatCard extends StatefulWidget {
  final String number;
  final String title;
  final int delay;
  final String suffix;

  const AnimatedStatCard({
    super.key,
    required this.number,
    required this.title,
    required this.delay,
    this.suffix = '',
  });

  @override
  State<AnimatedStatCard> createState() =>
      _AnimatedStatCardState();
}

class _AnimatedStatCardState
    extends State<AnimatedStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    );

    _scale = Tween<double>(
      begin: .6,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    Future.delayed(
      Duration(
        milliseconds: widget.delay,
      ),
      () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          height: 95,
          decoration: BoxDecoration(
            color: const Color(0xff262626),
            borderRadius:
                BorderRadius.circular(16),
            border: Border.all(
              color: const Color(
                0xFFFFC107,
              ).withOpacity(.35),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFFFFC107,
                ).withOpacity(.15),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              AnimatedNumber(
                value: widget.number,
                suffix: widget.suffix,
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: .5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================
// ANIMATED NUMBER
// =======================

class AnimatedNumber extends StatefulWidget {
  final String value;
  final String suffix;

  const AnimatedNumber({
    super.key,
    required this.value,
    this.suffix = '',
  });

  @override
  State<AnimatedNumber> createState() =>
      _AnimatedNumberState();
}

class _AnimatedNumberState
    extends State<AnimatedNumber>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    final endValue =
        double.tryParse(widget.value) ?? 0;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    _animation = Tween<double>(
      begin: 0,
      end: endValue,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final display =
            widget.value.contains('.')
                ? _animation.value
                    .toStringAsFixed(1)
                : _animation.value
                    .toInt()
                    .toString();

        return Text(
          '$display${widget.suffix}',
          style: const TextStyle(
            color: Color(0xFFFFC107),
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        );
      },
    );
  }
}