import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/ui/ar/widgets/overlap_furniture.dart';
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
            planeDetectionConfig: PlaneDetectionConfig.horizontal,
          ),
          Visibility(
            visible: arVM.isLoading,
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
          OverlapFurniture(
            furniture: arVM.furniture!,
            isDetectedFirstPlane: arVM.isDetectedFirstPlane,
          ),
        ],
      ),
    );
  }
}
