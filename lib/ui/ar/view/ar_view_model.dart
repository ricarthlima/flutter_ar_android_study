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
  Furniture? furniture;

  late ARObjectManager _objectManager;
  late ARAnchorManager _anchorManager;

  bool isLoading = false;

  bool isDetectedFirstPlane = false;

  void initialize(Furniture furniture) {
    this.furniture = furniture;
    isLoading = false;
    isDetectedFirstPlane = false;
    notifyListeners();
  }

  void onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
    ARLocationManager locationManager,
  ) {
    sessionManager.onInitialize(
      showFeaturePoints: false,
      showAnimatedGuide: false,
      showWorldOrigin: false,
      showPlanes: true,

      //handles
      handleTaps: true,
    );

    _objectManager = objectManager;
    _anchorManager = anchorManager; // Isso vem depois por necessidade

    sessionManager.onPlaneOrPointTap = onPlaneTapped;

    sessionManager.onPlaneDetected = (i) {
      isDetectedFirstPlane = true;
      notifyListeners();
    };
  }

  Future<void> onPlaceObjectClicked(
    Furniture furniture, {
    ARPlaneAnchor? planeAnchor,
  }) async {
    ARNode newNode = ARNode(
      type: NodeType.webGLB,
      uri: furniture.glb,
      scale: Vector3(0.2, 0.2, 0.2),
      // position: Vector3(0, 0, 0),
      // eulerAngles: Vector3(0, 0, 0),
      // rotation: Vector4(0, 0, 0, 0),
    );

    toggleLoading();
    await _objectManager.addNode(newNode, planeAnchor: planeAnchor);
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

    if (result != null && result) {
      if (furniture != null) {
        onPlaceObjectClicked(furniture!, planeAnchor: newAnchor);
      }
    }
  }

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
