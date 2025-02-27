import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/ar_view_model.dart';

class ARScreen extends StatelessWidget {
  const ARScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arVM = Provider.of<ARViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(arVM.furniture!.name)),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: arVM.onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Visibility(
            visible: arVM.isLoading,
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                onPressed: () => arVM.onPlaceObjectClicked(arVM.furniture!),
                child: Text("Posicionar mobília"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
