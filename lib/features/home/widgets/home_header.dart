import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String userName = '';
  String userArea = '';
  String userStreet = '';

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    final userJson = prefs.getString('user');

    if (userJson == null || userJson.isEmpty) {
      return;
    }

    try {
      final decodedUser = jsonDecode(userJson);

      if (decodedUser is! Map) {
        return;
      }

      final name = decodedUser['Name']?.toString().trim() ?? '';
      final area = decodedUser['Area']?.toString().trim() ?? '';
      final street = decodedUser['Street']?.toString().trim() ?? '';

      if (mounted) {
        setState(() {
          userName = name;
          userArea = area;
          userStreet = street;
        });
      }
    } catch (e) {
      debugPrint('Error loading user from local storage: $e');
    }
  }

  String get firstLetter {
    if (userName.isEmpty) {
      return 'U';
    }

    return userName.trim()[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0XFFa91145),
      ),
      child: Column(
        children: [
          // =========================================================
          // TVK QUOTE
          // =========================================================

          Container(
            padding: const EdgeInsets.only(bottom: 3),
            child: const Text(
              'பிறப்பொக்கும் எல்லா உயிர்க்கும்',
              style: TextStyle(
                letterSpacing: 0.7,
                color: Colors.yellow,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // =========================================================
          // USER DETAILS
          // =========================================================

          Row(
            children: [
              // =====================================================
              // PROFILE AVATAR
              // =====================================================

              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.yellow,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Text(
                        firstLetter,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFFa91145),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // =====================================================
              // NAME + AREA + STREET
              // =====================================================

              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // =================================================
                      // USER NAME
                      // =================================================

                      Text(
                        userName.isEmpty
                            ? 'USER'
                            : userName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 6),

                      // =================================================
                      // AREA + STREET
                      // =================================================

                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          // AREA
                          if (userArea.isNotEmpty) ...[
                            const Text(
                              'Area: ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Flexible(
                              child: Text(
                                userArea,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],

                          // SEPARATOR
                          if (userArea.isNotEmpty &&
                              userStreet.isNotEmpty)
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(
                                horizontal: 7,
                              ),
                              child: Text(
                                '•',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),

                          // STREET
                          if (userStreet.isNotEmpty) ...[
                            const Text(
                              'Street: ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Flexible(
                              child: Text(
                                userStreet,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],

                          // FALLBACK
                          if (userArea.isEmpty &&
                              userStreet.isEmpty)
                            const Text(
                              'Location not available',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}