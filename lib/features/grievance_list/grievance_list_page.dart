import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:tvk_grievance/app/main_layout.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/features/grievance_list/grievance_list_controller.dart';
import 'package:tvk_grievance/features/grievance_list/grievance_list_providers.dart';
import 'package:tvk_grievance/features/grievance_list/widgets/grievance_list_card.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

class GrievanceListPage extends ConsumerStatefulWidget {
  const GrievanceListPage({super.key});

  @override
  ConsumerState<GrievanceListPage> createState() => _GrievanceListPageState();
}

class _GrievanceListPageState extends ConsumerState<GrievanceListPage> {
  static const Color primaryMaroon = Color(0xffA91145);

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(grievanceListControllerProvider).loadGrievances();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(grievanceListControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return MainLayout(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: primaryMaroon,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            l10n.allGrievances,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return ref
                  .read(grievanceListControllerProvider)
                  .refreshGrievances();
            },
            child: _buildBody(
              context,
              controller,
              l10n,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    GrievanceListController controller,
    AppLocalizations l10n,
  ) {
    // ----------------------------------------
    // LOADING
    // ----------------------------------------

    if (controller.isLoading) {
      return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) {
          return const _GrievanceCardShimmer();
        },
      );
    }

    // ----------------------------------------
    // ERROR
    // ----------------------------------------

    if (controller.errorMessage != null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 80,
        ),
        children: [
          const Icon(
            Icons.error_outline,
            size: 52,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 12),
          Text(
            controller.errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(grievanceListControllerProvider)
                    .loadGrievances();
              },
              child: Text(l10n.retry),
            ),
          ),
        ],
      );
    }

    // ----------------------------------------
    // EMPTY
    // ----------------------------------------

    if (controller.grievances.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 80,
        ),
        children: [
          const Icon(
            Icons.inbox_outlined,
            size: 52,
            color: Colors.black45,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.noGrievancesAvailable,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    // ----------------------------------------
    // SUCCESS
    // ----------------------------------------

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
      itemCount: controller.grievances.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final grievance = controller.grievances[index];

        return GrievanceListCard(
          grievance: grievance,
          onTap: () {
            context.push(
              '${AppRoutes.grievanceDetails}/${grievance.id}',
            );
          },
        );
      },
    );
  }
}

// ============================================================
// GRIEVANCE CARD SHIMMER
// ============================================================

class _GrievanceCardShimmer extends StatefulWidget {
  const _GrievanceCardShimmer();

  @override
  State<_GrievanceCardShimmer> createState() =>
      _GrievanceCardShimmerState();
}

class _GrievanceCardShimmerState extends State<_GrievanceCardShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final color = Color.lerp(
          const Color(0xffE8E8E8),
          const Color(0xffF5F5F5),
          _controller.value,
        )!;

        return Container(
          height: 190,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.black,
              width: 1.2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.orange,
                offset: Offset(3, 3),
                blurRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 15,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 70,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 13,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 13,
                width: 220,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 12,
                width: 260,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
