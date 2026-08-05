class DashboardStat {
  final String title;
  final String value;

  DashboardStat({required this.title, required this.value});
}

// =======================
// LATEST UPDATES
// =======================

class LatestUpdate {
  final String id;
  final String category;
  final String title;
  final String shortDescription;
  final String fullContent;
  final List<String> images;
  final List<String> videos;
  final DateTime postedOn;
  final List<String> links;
  final String shareUrl;

  const LatestUpdate({
    required this.id,
    required this.category,
    required this.title,
    required this.shortDescription,
    required this.fullContent,
    required this.images,
    required this.videos,
    required this.postedOn,
    required this.links,
    required this.shareUrl,
  });

  factory LatestUpdate.fromJson(Map<String, dynamic> json) {
    return LatestUpdate(
      id: json["id"],
      category: json["category"],
      title: json["title"],
      shortDescription: json["shortDescription"],
      fullContent: json["fullContent"],
      images: List<String>.from(json["images"]),
      videos: List<String>.from(json["videos"]),
      postedOn: DateTime.parse(json["postedOn"]),
      links: List<String>.from(json["links"]),
      shareUrl: json["shareUrl"],
    );
  }
}
