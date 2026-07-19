import 'grievance_model.dart';

class GrievanceRepository {
  List<GrievanceModel> getGrievances() {
    return const [
      GrievanceModel(
        id: "SDP-2607-0148",
        title: "Streetlight outage — Duraisamy Nagar 2nd St.",
        status: "In Progress",
        rating: 0,
        date: "Expected by 16 Jul",
      ),
      GrievanceModel(
        id: "SDP-2606-0981",
        title: "Garbage pile-up — Bazaar Road market",
        status: "Resolved",
        rating: 5,
        date: "05 Jul",
      ),
      GrievanceModel(
        id: "SDP-2605-0712",
        title: "Water contamination — Ward 172",
        status: "Resolved",
        rating: 4,
        date: "28 Jun",
      ),
    ];
  }

  Future<List<String>> getWards() async {
    return ["Ward 170", "Ward 171", "Ward 172"];
  }

  Future<List<String>> getAreas() async {
    return ["Duraisamy Nagar", "Ashok Nagar", "Anna Nagar"];
  }

  Future<List<String>> getStreets() async {
    return ["1st Street", "2nd Street", "3rd Street"];
  }
}