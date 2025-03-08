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

import '../../../_core/logm.dart';

class ARViewModel extends ChangeNotifier {
  Furniture? furniture;

  late ARObjectManager _objectManager;
  late ARAnchorManager _anchorManager;

  bool isLoading = false;

  bool isDetectedFirstPlane = false;

  ARNode? placedObjectNode;

  void initialize(Furniture furniture) {
    this.furniture = furniture;
    isLoading = false;
    isDetectedFirstPlane = false;
    placedObjectNode = null;
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
      handlePans: true,
      handleRotation: true,
    );

    _objectManager = objectManager;
    _anchorManager = anchorManager; // Isso vem depois por necessidade

    sessionManager.onPlaneOrPointTap = _onPlaneTapped;

    sessionManager.onPlaneDetected = (i) {
      isDetectedFirstPlane = true;
      notifyListeners();
    };

    _objectManager.onPanStart = _onPanStarted;
    _objectManager.onPanChange = _onPanChanged;
    _objectManager.onPanEnd = _onPanEnded;
    _objectManager.onRotationStart = _onRotationStarted;
    _objectManager.onRotationChange = _onRotationChanged;
    _objectManager.onRotationEnd = _onRotationEnded;
  }

  void zoomIn() {
    if (placedObjectNode != null) {
      placedObjectNode!.scale *= 1.1;
      logM(placedObjectNode!.scale);
      notifyListeners();
    }
  }

  void zoomOut() {
    if (placedObjectNode != null) {
      placedObjectNode!.scale *= 0.9;
      logM(placedObjectNode!.scale);
      notifyListeners();
    }
  }

  Future<void> _onPlaceObjectClicked(
    Furniture furniture, {
    ARPlaneAnchor? planeAnchor,
  }) async {
    if (placedObjectNode != null) {
      _objectManager.removeNode(placedObjectNode!);
      placedObjectNode = null;
    }

    ARNode newNode = ARNode(
      type: NodeType.webGLB,
      uri: furniture.glb,
      scale: Vector3(0.2, 0.2, 0.2),
      // position: Vector3(0, 0, 0),
      // eulerAngles: Vector3(0, 0, 0),
      // rotation: Vector4(0, 0, 0, 0),
    );

    _toggleLoading();

    bool? result = await _objectManager.addNode(
      newNode,
      planeAnchor: planeAnchor,
    );

    if (result != null && result) {
      placedObjectNode = newNode;
    }

    _toggleLoading();
  }

  Future<void> _onPlaneTapped(List<ARHitTestResult> listResults) async {
    ARHitTestResult hitResult = listResults.firstWhere(
      (ARHitTestResult hit) => hit.type == ARHitTestResultType.plane,
    );

    // Mostra a distância, interessante
    logM(hitResult.distance);

    ARPlaneAnchor newAnchor = ARPlaneAnchor(
      transformation: hitResult.worldTransform,
    );

    bool? result = await _anchorManager.addAnchor(newAnchor);

    if (result != null && result) {
      if (furniture != null) {
        _onPlaceObjectClicked(furniture!, planeAnchor: newAnchor);
      }
    }
  }

  void _toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void _onPanStarted(String nodeName) {
    logM("Started panning node $nodeName");
  }

  void _onPanChanged(String nodeName) {
    logM("Continued panning node $nodeName");
  }

  void _onPanEnded(String nodeName, Matrix4 newTransform) {
    logM("Ended panning node $nodeName");
    _applyTransformation(newTransform);
  }

  void _onRotationStarted(String nodeName) {
    logM("Started rotating node $nodeName");
  }

  void _onRotationChanged(String nodeName) {
    logM("Continued rotating node $nodeName");
  }

  void _onRotationEnded(String nodeName, Matrix4 newTransform) {
    logM("Ended rotating node $nodeName");
    _applyTransformation(newTransform);
  }

  void _applyTransformation(Matrix4 newTransformation) {
    if (placedObjectNode != null) {
      placedObjectNode!.transform = newTransformation;
    }
  }
}
