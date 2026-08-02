import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../location_picker_controller.dart';
import '../location_picker_model.dart';

class LocationMap extends StatefulWidget {
  final Function(LocationPickerModel) onLocationSelected;

  const LocationMap({super.key, required this.onLocationSelected});

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  late final LocationPickerController controller;

  bool _mapReady = false;

  @override
  void initState() {
    super.initState();

    controller = LocationPickerController();

    controller.initialize().then((_) {
      if (!mounted) return;

      if (_mapReady && controller.currentLocation != null) {
        controller.mapController.move(controller.currentLocation!, 17);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.currentLocation == null) {
          return Center(
            child: ElevatedButton(
              onPressed: controller.initialize,
              child: const Text("Enable Location"),
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black87, width: 1.5),
            boxShadow: const [
              BoxShadow(color: Color(0xffffc107), offset: Offset(4, 4)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        FlutterMap(
                          mapController: controller.mapController,
                          options: MapOptions(
                            initialCenter: controller.currentLocation!,
                            initialZoom: 17,

                            onMapReady: () {
                              _mapReady = true;

                              if (controller.currentLocation != null) {
                                controller.mapController.move(
                                  controller.currentLocation!,
                                  17,
                                );
                              }
                            },

                            // Fires only when map movement ends
                            onMapEvent: (event) async {
                              if (event is MapEventMoveEnd) {
                                final center =
                                    controller.mapController.camera.center;

                                await controller.onCameraMoved(center);
                              }
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                              userAgentPackageName: "com.android.application",
                            ),
                          ],
                        ),

                        const IgnorePointer(
                          child: Center(
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 52,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: FloatingActionButton.small(
                            heroTag: "gps_button",
                            backgroundColor: Colors.white,
                            onPressed: () async {
                              await controller.moveToCurrentLocation();
                            },
                            child: const Icon(
                              Icons.my_location,
                              color: Color(0xffA00037),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.address.isEmpty
                        ? "Selected location"
                        : controller.address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xffA00037),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${controller.selectedLocation!.latitude.toStringAsFixed(6)}, "
                    "${controller.selectedLocation!.longitude.toStringAsFixed(6)}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
