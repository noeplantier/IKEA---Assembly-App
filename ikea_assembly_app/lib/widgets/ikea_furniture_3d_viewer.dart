import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Furniture3DViewer extends StatelessWidget {
  final String furnitureId;
  final String furnitureName;
  final bool autoRotate;
  final bool enableAR;

  const Furniture3DViewer({
    Key? key,
    required this.furnitureId,
    required this.furnitureName,
    this.autoRotate = true,
    this.enableAR = true,
  }) : super(key: key);

  String get modelUrl {
    // URL automatique vers les modèles 3D IKEA
    return 'https://www.ikea.com/global/en/3d-models/$furnitureId.glb';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: ModelViewer(
          src: modelUrl,
          alt: 'Modèle 3D de $furnitureName',
          ar: enableAR,
          arModes: const ['scene-viewer', 'webxr', 'quick-look'],
          autoRotate: autoRotate,
          cameraControls: true,
          touchAction: TouchAction.panY,
          disableZoom: false,
          backgroundColor: const Color(0xFFF5F5F5),
          // Paramètres pour un rendu ULTRA RÉALISTE
          shadowIntensity: 1.0,
          shadowSoftness: 0.8,
          exposure: 1.0,
          environmentImage: 'neutral',
          autoPlay: true,
          // Animations
          animationName: 'assembly',
          animationCrossfadeDuration: 300,
          // Performance
          loading: Loading.eager,
          reveal: Reveal.auto,
          // Interaction
          interpolationDecay: 200,
          cameraOrbit: 'auto auto 105%',
          fieldOfView: '30deg',
          minCameraOrbit: 'auto auto 5%',
          maxCameraOrbit: 'auto auto 500%',
        ),
      ),
    );
  }
}
