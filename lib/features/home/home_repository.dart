import 'home_model.dart';

class HomeRepository {
  List<DashboardStat> dashboardStats() {
    return [
      DashboardStat(title: 'Resolved', value: '1,284'),
      DashboardStat(title: 'In Progress', value: '46'),
      DashboardStat(title: 'Avg Resolution', value: '4.2d'),
    ];
  }

  List<HomeUpdate> latestUpdates() {
    return [
      HomeUpdate(
        category: 'INFRASTRUCTURE',
        title: 'Saidapet bridge repair — Phase 2 sanctioned',
        subtitle: '₹4.2 Cr approved. Work starts first week of August.',
      ),
    ];
  }
}
