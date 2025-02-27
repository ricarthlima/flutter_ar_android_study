import 'package:ar_flutter_plugin_2/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_2/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_2/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_2/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_2/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin_2/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:vector_math/vector_math_64.dart';

class ARViewModel extends ChangeNotifier {
  late ARObjectManager _objectManager;
  late ARAnchorManager _anchorManager;

  bool isLoading = false;

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

      //handles
      handleTaps: true,
    );

    _objectManager = objectManager;
    _anchorManager = anchorManager; // Isso vem depois por necessidade

    sessionManager.onPlaneOrPointTap = onPlaneTapped;
  }

  Future<void> onPlaceObjectClicked(Furniture furniture) async {
    ARNode newNode = ARNode(
      type: NodeType.webGLB,
      uri: furniture.glb,
      scale: Vector3(0.2, 0.2, 0.2),
      // position: Vector3(0, 0, 0),
      // eulerAngles: Vector3(0, 0, 0),
      // rotation: Vector4(0, 0, 0, 0),
    );

    toggleLoading();
    await _objectManager.addNode(newNode);
    toggleLoading();
  }

  Future<void> onPlaneTapped(List<ARHitTestResult> listResults) async {
    ARHitTestResult hitResult = listResults.firstWhere(
      (ARHitTestResult hit) => hit.type == ARHitTestResultType.plane,
    );

    ARPlaneAnchor newAnchor = ARPlaneAnchor(
      transformation: hitResult.worldTransform,
    );

    bool? result = await _anchorManager.addAnchor(newAnchor);

    if (result != null && result) {}
  }

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
