
import 'package:flutter/foundation.dart';

/// Modèle de meuble IKEA avec support 3D complet
class FurnitureModel {
  final String id;
  final String name;
  final String description;
  final String category;
  
  // 3D Model Properties
  final String glbModelPath; // Chemin vers le fichier .glb
  final String? thumbnailPath;
  final List<String> animationNames; // Noms des animations disponibles
  final String? environmentMap; // HDR pour éclairage réaliste
  
  // Dimensions réelles (en mètres)
  final double width;
  final double height;
  final double depth;
  
  // PBR Materials
  final MaterialProperties materials;
  
  // Assembly Steps
  final List<AssemblyStep> assemblySteps;
  final int currentStepIndex;
  
  // AR Support
  final bool arEnabled;
  final String? iosUSDZPath; // Pour AR sur iOS
  
  // Animation State
  final AnimationState animationState;
  
  // User Progress
  final double completionPercentage;
  final DateTime? lastUpdated;

  const FurnitureModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.glbModelPath,
    this.thumbnailPath,
    this.animationNames = const [],
    this.environmentMap = 'neutral',
    required this.width,
    required this.height,
    required this.depth,
    required this.materials,
    this.assemblySteps = const [],
    this.currentStepIndex = 0,
    this.arEnabled = true,
    this.iosUSDZPath,
    this.animationState = AnimationState.idle,
    this.completionPercentage = 0.0,
    this.lastUpdated,
  });

  // Factory pour créer depuis JSON
  factory FurnitureModel.fromJson(Map<String, dynamic> json) {
    return FurnitureModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      glbModelPath: json['glbModelPath'] as String,
      thumbnailPath: json['thumbnailPath'] as String?,
      animationNames: (json['animationNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      environmentMap: json['environmentMap'] as String? ?? 'neutral',
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
      materials: MaterialProperties.fromJson(
          json['materials'] as Map<String, dynamic>),
      assemblySteps: (json['assemblySteps'] as List<dynamic>?)
              ?.map((e) => AssemblyStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      currentStepIndex: json['currentStepIndex'] as int? ?? 0,
      arEnabled: json['arEnabled'] as bool? ?? true,
      iosUSDZPath: json['iosUSDZPath'] as String?,
      animationState: AnimationState.values.firstWhere(
        (e) => e.name == json['animationState'],
        orElse: () => AnimationState.idle,
      ),
      completionPercentage:
          (json['completionPercentage'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'glbModelPath': glbModelPath,
      'thumbnailPath': thumbnailPath,
      'animationNames': animationNames,
      'environmentMap': environmentMap,
      'width': width,
      'height': height,
      'depth': depth,
      'materials': materials.toJson(),
      'assemblySteps': assemblySteps.map((e) => e.toJson()).toList(),
      'currentStepIndex': currentStepIndex,
      'arEnabled': arEnabled,
      'iosUSDZPath': iosUSDZPath,
      'animationState': animationState.name,
      'completionPercentage': completionPercentage,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  // CopyWith pour immutabilité
  FurnitureModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? glbModelPath,
    String? thumbnailPath,
    List<String>? animationNames,
    String? environmentMap,
    double? width,
    double? height,
    double? depth,
    MaterialProperties? materials,
    List<AssemblyStep>? assemblySteps,
    int? currentStepIndex,
    bool? arEnabled,
    String? iosUSDZPath,
    AnimationState? animationState,
    double? completionPercentage,
    DateTime? lastUpdated,
  }) {
    return FurnitureModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      glbModelPath: glbModelPath ?? this.glbModelPath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      animationNames: animationNames ?? this.animationNames,
      environmentMap: environmentMap ?? this.environmentMap,
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
      materials: materials ?? this.materials,
      assemblySteps: assemblySteps ?? this.assemblySteps,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      arEnabled: arEnabled ?? this.arEnabled,
      iosUSDZPath: iosUSDZPath ?? this.iosUSDZPath,
      animationState: animationState ?? this.animationState,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  // Helpers
  bool get isCompleted => completionPercentage >= 100.0;
  bool get hasNextStep => currentStepIndex < assemblySteps.length - 1;
  bool get hasPreviousStep => currentStepIndex > 0;
  AssemblyStep? get currentStep =>
      assemblySteps.isNotEmpty ? assemblySteps[currentStepIndex] : null;
}

/// Propriétés matériaux PBR pour réalisme
class MaterialProperties {
  final double metallic; // 0.0 - 1.0
  final double roughness; // 0.0 - 1.0
  final String? baseColorTexture;
  final String? normalMapTexture;
  final String? roughnessMapTexture;
  final String? metallicMapTexture;
  final String? aoMapTexture; // Ambient Occlusion
  final double exposure;

  const MaterialProperties({
    this.metallic = 0.0,
    this.roughness = 0.5,
    this.baseColorTexture,
    this.normalMapTexture,
    this.roughnessMapTexture,
    this.metallicMapTexture,
    this.aoMapTexture,
    this.exposure = 1.0,
  });

  factory MaterialProperties.fromJson(Map<String, dynamic> json) {
    return MaterialProperties(
      metallic: (json['metallic'] as num?)?.toDouble() ?? 0.0,
      roughness: (json['roughness'] as num?)?.toDouble() ?? 0.5,
      baseColorTexture: json['baseColorTexture'] as String?,
      normalMapTexture: json['normalMapTexture'] as String?,
      roughnessMapTexture: json['roughnessMapTexture'] as String?,
      metallicMapTexture: json['metallicMapTexture'] as String?,
      aoMapTexture: json['aoMapTexture'] as String?,
      exposure: (json['exposure'] as num?)?.toDouble() ?? 1.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metallic': metallic,
      'roughness': roughness,
      'baseColorTexture': baseColorTexture,
      'normalMapTexture': normalMapTexture,
      'roughnessMapTexture': roughnessMapTexture,
      'metallicMapTexture': metallicMapTexture,
      'aoMapTexture': aoMapTexture,
      'exposure': exposure,
    };
  }
}

/// Étape d'assemblage avec animation 3D
class AssemblyStep {
  final int stepNumber;
  final String title;
  final String description;
  final String animationName; // Animation à jouer pour cette étape
  final double animationStartTime; // Timestamp début (secondes)
  final double animationEndTime; // Timestamp fin
  final List<String> tools; // Outils nécessaires
  final List<String> parts; // Pièces nécessaires
  final String? instructionImagePath;
  final Duration estimatedDuration;

  const AssemblyStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.animationName,
    this.animationStartTime = 0.0,
    this.animationEndTime = 0.0,
    this.tools = const [],
    this.parts = const [],
    this.instructionImagePath,
    this.estimatedDuration = const Duration(minutes: 5),
  });

  factory AssemblyStep.fromJson(Map<String, dynamic> json) {
    return AssemblyStep(
      stepNumber: json['stepNumber'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      animationName: json['animationName'] as String,
      animationStartTime:
          (json['animationStartTime'] as num?)?.toDouble() ?? 0.0,
      animationEndTime: (json['animationEndTime'] as num?)?.toDouble() ?? 0.0,
      tools: (json['tools'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      instructionImagePath: json['instructionImagePath'] as String?,
      estimatedDuration: Duration(
          minutes: json['estimatedDurationMinutes'] as int? ?? 5),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'title': title,
      'description': description,
      'animationName': animationName,
      'animationStartTime': animationStartTime,
      'animationEndTime': animationEndTime,
      'tools': tools,
      'parts': parts,
      'instructionImagePath': instructionImagePath,
      'estimatedDurationMinutes': estimatedDuration.inMinutes,
    };
  }
}

/// États d'animation possibles
enum AnimationState {
  idle, // Au repos
  assembling, // En cours de montage
  disassembling, // En cours de démontage
  rotating, // Rotation automatique
  paused, // Mise en pause
  completed, // Animation terminée
}import 'package:flutter/foundation.dart';

/// Modèle de meuble IKEA avec support 3D complet
class FurnitureModel {
  final String id;
  final String name;
  final String description;
  final String category;
  
  // 3D Model Properties
  final String glbModelPath; // Chemin vers le fichier .glb
  final String? thumbnailPath;
  final List<String> animationNames; // Noms des animations disponibles
  final String? environmentMap; // HDR pour éclairage réaliste
  
  // Dimensions réelles (en mètres)
  final double width;
  final double height;
  final double depth;
  
  // PBR Materials
  final MaterialProperties materials;
  
  // Assembly Steps
  final List<AssemblyStep> assemblySteps;
  final int currentStepIndex;
  
  // AR Support
  final bool arEnabled;
  final String? iosUSDZPath; // Pour AR sur iOS
  
  // Animation State
  final AnimationState animationState;
  
  // User Progress
  final double completionPercentage;
  final DateTime? lastUpdated;

  const FurnitureModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.glbModelPath,
    this.thumbnailPath,
    this.animationNames = const [],
    this.environmentMap = 'neutral',
    required this.width,
    required this.height,
    required this.depth,
    required this.materials,
    this.assemblySteps = const [],
    this.currentStepIndex = 0,
    this.arEnabled = true,
    this.iosUSDZPath,
    this.animationState = AnimationState.idle,
    this.completionPercentage = 0.0,
    this.lastUpdated,
  });

  // Factory pour créer depuis JSON
  factory FurnitureModel.fromJson(Map<String, dynamic> json) {
    return FurnitureModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      glbModelPath: json['glbModelPath'] as String,
      thumbnailPath: json['thumbnailPath'] as String?,
      animationNames: (json['animationNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      environmentMap: json['environmentMap'] as String? ?? 'neutral',
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
      materials: MaterialProperties.fromJson(
          json['materials'] as Map<String, dynamic>),
      assemblySteps: (json['assemblySteps'] as List<dynamic>?)
              ?.map((e) => AssemblyStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      currentStepIndex: json['currentStepIndex'] as int? ?? 0,
      arEnabled: json['arEnabled'] as bool? ?? true,
      iosUSDZPath: json['iosUSDZPath'] as String?,
      animationState: AnimationState.values.firstWhere(
        (e) => e.name == json['animationState'],
        orElse: () => AnimationState.idle,
      ),
      completionPercentage:
          (json['completionPercentage'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'glbModelPath': glbModelPath,
      'thumbnailPath': thumbnailPath,
      'animationNames': animationNames,
      'environmentMap': environmentMap,
      'width': width,
      'height': height,
      'depth': depth,
      'materials': materials.toJson(),
      'assemblySteps': assemblySteps.map((e) => e.toJson()).toList(),
      'currentStepIndex': currentStepIndex,
      'arEnabled': arEnabled,
      'iosUSDZPath': iosUSDZPath,
      'animationState': animationState.name,
      'completionPercentage': completionPercentage,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  // CopyWith pour immutabilité
  FurnitureModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? glbModelPath,
    String? thumbnailPath,
    List<String>? animationNames,
    String? environmentMap,
    double? width,
    double? height,
    double? depth,
    MaterialProperties? materials,
    List<AssemblyStep>? assemblySteps,
    int? currentStepIndex,
    bool? arEnabled,
    String? iosUSDZPath,
    AnimationState? animationState,
    double? completionPercentage,
    DateTime? lastUpdated,
  }) {
    return FurnitureModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      glbModelPath: glbModelPath ?? this.glbModelPath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      animationNames: animationNames ?? this.animationNames,
      environmentMap: environmentMap ?? this.environmentMap,
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
      materials: materials ?? this.materials,
      assemblySteps: assemblySteps ?? this.assemblySteps,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      arEnabled: arEnabled ?? this.arEnabled,
      iosUSDZPath: iosUSDZPath ?? this.iosUSDZPath,
      animationState: animationState ?? this.animationState,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  // Helpers
  bool get isCompleted => completionPercentage >= 100.0;
  bool get hasNextStep => currentStepIndex < assemblySteps.length - 1;
  bool get hasPreviousStep => currentStepIndex > 0;
  AssemblyStep? get currentStep =>
      assemblySteps.isNotEmpty ? assemblySteps[currentStepIndex] : null;
}

/// Propriétés matériaux PBR pour réalisme
class MaterialProperties {
  final double metallic; // 0.0 - 1.0
  final double roughness; // 0.0 - 1.0
  final String? baseColorTexture;
  final String? normalMapTexture;
  final String? roughnessMapTexture;
  final String? metallicMapTexture;
  final String? aoMapTexture; // Ambient Occlusion
  final double exposure;

  const MaterialProperties({
    this.metallic = 0.0,
    this.roughness = 0.5,
    this.baseColorTexture,
    this.normalMapTexture,
    this.roughnessMapTexture,
    this.metallicMapTexture,
    this.aoMapTexture,
    this.exposure = 1.0,
  });

  factory MaterialProperties.fromJson(Map<String, dynamic> json) {
    return MaterialProperties(
      metallic: (json['metallic'] as num?)?.toDouble() ?? 0.0,
      roughness: (json['roughness'] as num?)?.toDouble() ?? 0.5,
      baseColorTexture: json['baseColorTexture'] as String?,
      normalMapTexture: json['normalMapTexture'] as String?,
      roughnessMapTexture: json['roughnessMapTexture'] as String?,
      metallicMapTexture: json['metallicMapTexture'] as String?,
      aoMapTexture: json['aoMapTexture'] as String?,
      exposure: (json['exposure'] as num?)?.toDouble() ?? 1.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metallic': metallic,
      'roughness': roughness,
      'baseColorTexture': baseColorTexture,
      'normalMapTexture': normalMapTexture,
      'roughnessMapTexture': roughnessMapTexture,
      'metallicMapTexture': metallicMapTexture,
      'aoMapTexture': aoMapTexture,
      'exposure': exposure,
    };
  }
}

/// Étape d'assemblage avec animation 3D
class AssemblyStep {
  final int stepNumber;
  final String title;
  final String description;
  final String animationName; // Animation à jouer pour cette étape
  final double animationStartTime; // Timestamp début (secondes)
  final double animationEndTime; // Timestamp fin
  final List<String> tools; // Outils nécessaires
  final List<String> parts; // Pièces nécessaires
  final String? instructionImagePath;
  final Duration estimatedDuration;

  const AssemblyStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.animationName,
    this.animationStartTime = 0.0,
    this.animationEndTime = 0.0,
    this.tools = const [],
    this.parts = const [],
    this.instructionImagePath,
    this.estimatedDuration = const Duration(minutes: 5),
  });

  factory AssemblyStep.fromJson(Map<String, dynamic> json) {
    return AssemblyStep(
      stepNumber: json['stepNumber'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      animationName: json['animationName'] as String,
      animationStartTime:
          (json['animationStartTime'] as num?)?.toDouble() ?? 0.0,
      animationEndTime: (json['animationEndTime'] as num?)?.toDouble() ?? 0.0,
      tools: (json['tools'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      instructionImagePath: json['instructionImagePath'] as String?,
      estimatedDuration: Duration(
          minutes: json['estimatedDurationMinutes'] as int? ?? 5),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'title': title,
      'description': description,
      'animationName': animationName,
      'animationStartTime': animationStartTime,
      'animationEndTime': animationEndTime,
      'tools': tools,
      'parts': parts,
      'instructionImagePath': instructionImagePath,
      'estimatedDurationMinutes': estimatedDuration.inMinutes,
    };
  }
}

/// États d'animation possibles
enum AnimationState {
  idle, // Au repos
  assembling, // En cours de montage
  disassembling, // En cours de démontage
  rotating, // Rotation automatique
  paused, // Mise en pause
  completed, // Animation terminée
}