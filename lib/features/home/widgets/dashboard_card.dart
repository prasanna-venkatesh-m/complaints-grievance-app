import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Heading (Outside Black Card)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "GRIEVANCE DASHBOARD",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFE91E63), // Pink
                            Color(0xFFFFC107), // Yellow
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
            ],
          ),

          /// Black Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xff1A1A1A),
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                // Yellow offset shadow
                BoxShadow(
                  color: Colors.orange,
                  blurRadius: 0,
                  spreadRadius: 0,
                  offset: Offset(4, 5),
                ),

                // Soft black shadow
                // BoxShadow(
                //   color: Colors.black38,
                //   blurRadius: 12,
                //   offset: Offset(0, 5),
                // ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Remove the "GRIEVANCE DASHBOARD" Text from here
                Row(
                  children: const [
                    Expanded(
                      child: _StatCard(number: "1,284", title: "RESOLVED"),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(number: "46", title: "IN PROGRESS"),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        number: "4.2d",
                        title: "AVG.\nRESOLUTION",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Your ticket: Streetlight outage",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      "#SDP-0148",
                      style: TextStyle(
                        color: Color(0xFFFFC107),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: .72,
                    minHeight: 6,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation(Color(0xFFFFC107)),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Forwarded to TNEB Saidapet · Expected closure 16 Jul",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String number;
  final String title;

  const _StatCard({required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    const Color yellow = Color(0xFFFFC107);

    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: const Color(0xff262626),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: yellow.withOpacity(.35)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: const TextStyle(
              color: yellow,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
