import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:provider/provider.dart';

import 'view/ar_view_model.dart';

class ARScreen extends StatelessWidget {
  final Furniture furniture;

  const ARScreen({
    super.key,
    required this.furniture,
  });

  @override
  Widget build(BuildContext context) {
    final arVM = Provider.of<ARViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(furniture.name)),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: arVM.onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                onPressed: () => arVM.onPlaceObjectClicked(furniture),
                child: Text("Posicionar mobília"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
