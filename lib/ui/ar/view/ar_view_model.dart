import 'package:ar_flutter_plugin_2/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_2/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_2/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';

class ARViewModel extends ChangeNotifier {
  late ARObjectManager _objectManager;

  void onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
    ARLocationManager locationManager,
  ) {
    sessionManager.onInitialize(
      showFeaturePoints: true,
      showAnimatedGuide: true,
      showWorldOrigin: true,
      showPlanes: true,
    );

    _objectManager = objectManager;
  }

  Future<void> onPlaceObjectClicked(Furniture furniture) async {
    ARNode newNode = ARNode(type: NodeType.webGLB, uri: furniture.glb);
    await _objectManager.addNode(newNode);
  }
}
