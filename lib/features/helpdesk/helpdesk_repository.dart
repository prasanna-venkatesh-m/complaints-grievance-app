import 'helpdesk_model.dart';

class HelpdeskRepository {
  List<HelpdeskContact> getContacts() {
    return const [
      HelpdeskContact(
        title: "Sanitation / SWM",
        subtitle: "Garbage clearance,\ndrain desilting",
        address:
            "Ward 172 Conservancy Depot,\nBazaar Rd, Saidapet, Chennai",
        emoji: "🗑️",
        phone: "04445678901",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Saidapet Taluk Office",
        subtitle: "Revenue services,\ncertificates & records",
        address:
            "Taluk Office,\nSaidapet, Chennai 600015",
        emoji: "🏛️",
        phone: "04424351600",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Chennai Traffic Police",
        subtitle: "Traffic violations,\nroad safety issues",
        address:
            "Traffic Police Office,\nGreater Chennai",
        emoji: "🚦",
        phone: "103",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Saidapet Government Hospital",
        subtitle: "Emergency care,\npublic health services",
        address:
            "Government Hospital,\nSaidapet, Chennai 600015",
        emoji: "🏥",
        phone: "04424351500",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Tamil Nadu Electricity Board (TANGEDCO)",
        subtitle: "Power outage,\nbilling complaints",
        address:
            "TANGEDCO Customer Service,\nChennai",
        emoji: "⚡",
        phone: "1912",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Chennai Corporation Ward Office",
        subtitle: "Birth/death certificates,\ncivic complaints",
        address:
            "Greater Chennai Corporation,\nZone 9 Office, Chennai",
        emoji: "🏢",
        phone: "1913",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Metro Water — Area 9",
        subtitle: "Water supply blocks & complaints",
        address:
            "Depot Office, 12 Duraaisamy Rd,\nSaidapet West, Chennai 600015",
        emoji: "🚰",
        phone: "04412345678",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "TNEB Saidapet Section",
        subtitle: "Fuse-off complaints & line faults",
        address:
            "TNEB Section Office, 4 West Jones Rd,\nSaidapet, Chennai 600015",
        emoji: "💡",
        phone: "04423456789",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "GCC Zone 9 — Roads",
        subtitle: "Potholes, road repairs,\nencroachment complaints",
        address:
            "Zonal Office, 28 Anna Main Rd,\nK.K Nagar, Chennai 600078",
        emoji: "🚧",
        phone: "04434567890",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Saidapet Police Station",
        subtitle: "Law & order, complaints,\ntraffic assistance",
        address:
            "Saidapet Police Station,\nAnna Salai, Saidapet, Chennai 600015",
        emoji: "👮",
        phone: "04423452300",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "CMWSSB Sewerage Complaint",
        subtitle: "Sewer blockage,\nunderground drainage issues",
        address:
            "Chennai Metro Water,\nArea 9, Chennai",
        emoji: "🚽",
        phone: "04445674567",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Tamil Nadu Civil Supplies",
        subtitle: "Ration card,\npublic distribution services",
        address:
            "Civil Supplies Office,\nChennai District",
        emoji: "🍚",
        phone: "1967",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Chennai Metropolitan Transport Corporation",
        subtitle: "Bus services,\nroute complaints",
        address:
            "MTC Office,\nPallavan Salai, Chennai",
        emoji: "🚌",
        phone: "149",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Sub Registrar Office — Saidapet",
        subtitle: "Property registration,\ndocument services",
        address:
            "Sub Registrar Office,\nSaidapet, Chennai",
        emoji: "📜",
        phone: "04424351551",
        mapUrl: "",
      ),

      HelpdeskContact(
        title: "Saidapet Post Office",
        subtitle: "Postal services,\nsavings & delivery",
        address:
            "Saidapet Head Post Office,\nSaidapet, Chennai 600015",
        emoji: "📮",
        phone: "04424351988",
        mapUrl: "",
      ),
    ];
  }
}