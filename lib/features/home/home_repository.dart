import 'home_model.dart';

class HomeRepository {
  List<DashboardStat> dashboardStats() {
    return [
      DashboardStat(title: 'Resolved', value: '1,284'),
      DashboardStat(title: 'In Progress', value: '46'),
      DashboardStat(title: 'Avg Resolution', value: '4.2d'),
    ];
  }

  Future<List<LatestUpdate>> getLatestUpdates() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      LatestUpdate(
        id: "1",
        category: "INFRASTRUCTURE",
        title: "Saidapet bridge repair — Phase 2 sanctioned",
        shortDescription: "₹4.2 Cr approved. Work starts first week of August.",
        fullContent:
            "The Government has sanctioned Phase 2 of the Saidapet bridge repair project. "
            "The work includes structural reinforcement, road resurfacing, improved drainage, "
            "street lighting, and pedestrian pathways. Officials have confirmed that work "
            "will commence during the first week of August and is expected to finish within six months.",
        images: [
          "https://picsum.photos/800/500?1",
          "https://picsum.photos/800/500?2",
        ],
        videos: [
          "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4",
        ],
        postedOn: DateTime.now(),
        links: ["https://yourwebsite.com/update/1"],
        shareUrl: "https://yourwebsite.com/update/1",
      ),

      LatestUpdate(
        id: "2",
        category: "TRANSPORT",
        title: "New electric buses introduced across Chennai routes",
        shortDescription:
            "50 electric buses added to reduce pollution and improve connectivity.",
        fullContent:
            "The Transport Department has introduced 50 new electric buses across major "
            "Chennai routes. The initiative aims to reduce carbon emissions, improve passenger "
            "comfort, and provide affordable public transportation. More electric buses are "
            "expected to be added in the upcoming months.",
        images: [
          "https://picsum.photos/800/500?3",
          "https://picsum.photos/800/500?4",
        ],
        videos: [],
        postedOn: DateTime.now().subtract(const Duration(days: 2)),
        links: ["https://yourwebsite.com/update/2"],
        shareUrl: "https://yourwebsite.com/update/2",
      ),

      LatestUpdate(
        id: "3",
        category: "HEALTH",
        title: "Government hospital upgraded with new facilities",
        shortDescription:
            "New ICU units and advanced medical equipment installed.",
        fullContent:
            "The city government hospital has completed its modernization project with "
            "new ICU facilities, upgraded emergency services, and advanced diagnostic equipment. "
            "The upgrade will help thousands of residents access better healthcare services.",
        images: ["https://picsum.photos/800/500?5"],
        videos: [
          "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4",
        ],
        postedOn: DateTime.now().subtract(const Duration(days: 5)),
        links: ["https://yourwebsite.com/update/3"],
        shareUrl: "https://yourwebsite.com/update/3",
      ),

      LatestUpdate(
        id: "4",
        category: "EDUCATION",
        title: "Smart classrooms launched in government schools",
        shortDescription:
            "Digital learning facilities introduced in 25 schools.",
        fullContent:
            "The Education Department has launched smart classroom facilities in 25 "
            "government schools. The project includes interactive boards, digital learning "
            "content, improved internet connectivity, and teacher training programs.",
        images: [
          "https://picsum.photos/800/500?6",
          "https://picsum.photos/800/500?7",
        ],
        videos: [],
        postedOn: DateTime.now().subtract(const Duration(days: 7)),
        links: ["https://yourwebsite.com/update/4"],
        shareUrl: "https://yourwebsite.com/update/4",
      ),

      LatestUpdate(
        id: "5",
        category: "ENVIRONMENT",
        title: "City lake restoration project begins",
        shortDescription:
            "₹8 Cr allocated for cleaning and ecosystem improvement.",
        fullContent:
            "The lake restoration project has officially started with an allocated budget "
            "of ₹8 Cr. The project includes water cleaning, removal of waste materials, "
            "plantation around the lake area, and development of walking paths for residents.",
        images: [
          "https://picsum.photos/800/500?8",
          "https://picsum.photos/800/500?9",
        ],
        videos: [],
        postedOn: DateTime.now().subtract(const Duration(days: 10)),
        links: ["https://yourwebsite.com/update/5"],
        shareUrl: "https://yourwebsite.com/update/5",
      ),

      LatestUpdate(
        id: "6",
        category: "PUBLIC SAFETY",
        title: "New CCTV monitoring system installed",
        shortDescription: "500 smart cameras added across important junctions.",
        fullContent:
            "The city administration has installed 500 smart CCTV cameras across "
            "major junctions and public areas. The system will improve traffic monitoring, "
            "crime prevention, and emergency response time.",
        images: ["https://picsum.photos/800/500?10"],
        videos: [],
        postedOn: DateTime.now().subtract(const Duration(days: 15)),
        links: ["https://yourwebsite.com/update/6"],
        shareUrl: "https://yourwebsite.com/update/6",
      ),
    ];
  }
}
