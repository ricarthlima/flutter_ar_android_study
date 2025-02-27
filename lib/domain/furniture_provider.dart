import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/data/services/furniture_service.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'models/furniture_infos.dart';
import '../_core/total_furniture.dart';

class FurnitureProvider extends ChangeNotifier {
  static const String _urlBase =
      "https://raw.githubusercontent.com/ricarthlima/ar-mobilia/refs/heads/main/";

  static const String _pathPrint = "prints/";
  static const String _path3D = "3d/";

  List<Furniture> listFurniture = [];

  Future<void> initialize() async {
    List<FurnitureInfos> listInfos =
        await FurnitureService().getFurnitureList();

    listFurniture = List.generate(
      totalFurniture,
      (index) {
        index++;
        FurnitureInfos infos = listInfos.firstWhere((e) => e.id == "00$index");
        return Furniture(
          name: infos.name,
          description: infos.description,
          price: infos.price,
          capture: getCapture(index),
          captureWA: getCaptureWithoutAlpha(index),
          glb: getGLB(index),
          glbZip: getZipGLB(index),
          glTFZip: getZipGLTF(index),
        );
      },
    );
  }

  static String getCapture(int index) {
    // assert(index <= totalFurniture || index < 1, "Índice incorreto");
    return "$_urlBase${_pathPrint}cap00$index.png";
  }

  static String getCaptureWithoutAlpha(int index) {
    // assert(index > totalFurniture || index < 1, "Índice incorreto");
    return "$_urlBase${_pathPrint}cap00$index-wa.png";
  }

  static String getZipGLTF(int index) {
    // assert(index > totalFurniture || index < 1, "Índice incorreto");
    return "$_urlBase${_path3D}00$index-glTF.zip";
  }

  static String getZipGLB(int index) {
    // assert(index > totalFurniture || index < 1, "Índice incorreto");
    return "$_urlBase${_path3D}00$index-glb.zip";
  }

  static String getGLB(int index) {
    // assert(index > totalFurniture || index < 1, "Índice incorreto");
    return "$_urlBase${_path3D}00$index.glb";
  }
}
