enum GrievanceTab { fileNew, myGrievances }

class GrievanceModel {
  final String id;
  final String title;
  final String status;
  final int rating;
  final String date;

  const GrievanceModel({
    required this.id,
    required this.title,
    required this.status,
    required this.rating,
    required this.date
  });
}

class DropdownData {
  final List<String> wards;
  final List<String> areas;
  final List<String> streets;

  DropdownData({
    required this.wards,
    required this.areas,
    required this.streets,
  });
}
