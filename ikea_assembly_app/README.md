# 🚀 IKEA Assembly App - Complete Setup Guide

## 📦 Step 1: Create Project & Install Dependencies

```bash
# Create Flutter project
flutter create ikea_assembly_app
cd ikea_assembly_app

# Install all dependencies
flutter pub add firebase_core firebase_auth cloud_firestore firebase_storage google_sign_in cached_network_image flutter_staggered_animations model_viewer_plus google_fonts provider shared_preferences flutter_svg lottie intl

# Install Firebase CLI
curl -sL https://firebase.tools | bash  # macOS/Linux
# OR for Windows: iwr -useb https://firebase.tools | iex

# Login to Firebase
firebase login

# Initialize Firebase
firebase init
# Select: Firestore, Storage, Authentication

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for Flutter
flutterfire configure
```

---

## 🔥 Step 2: Firebase Console Setup

### A) Go to [Firebase Console](https://console.firebase.google.com)

### B) Enable Authentication:
1. Go to **Authentication** → **Sign-in method**
2. Enable **Email/Password**
3. Enable **Google Sign-in**

### C) Create Firestore Database:
1. Go to **Firestore Database** → **Create Database**
2. Start in **Production mode**
3. Choose your region

### D) Set up Storage:
1. Go to **Storage** → **Get Started**
2. Start in **Production mode**

### E) Add Sample Data in Firestore:

**Collection: `furniture`**
```json
{
  "name": "MALM Bed Frame",
  "category": "Beds",
  "description": "Queen size bed frame with adjustable sides",
  "imageUrl": "https://www.ikea.com/us/en/images/products/malm-bed-frame__0638608_pe699032_s5.jpg",
  "model3dUrl": "https://your-storage.com/models/malm-bed.glb",
  "difficulty": "Medium",
  "estimatedTime": 45,
  "rating": 4.5,
  "reviewCount": 120,
  "tags": ["bedroom", "modern", "storage"],
  "isActive": true,
  "materials": [
    {
      "id": "mat_001",
      "name": "Side Panel",
      "description": "Main side panel with pre-drilled holes",
      "quantity": 2,
      "imageUrl": "https://example.com/side-panel.jpg",
      "model3dUrl": "https://example.com/side-panel.glb",
      "type": "panel",
      "dimensions": {
        "length": 2100,
        "width": 300,
        "height": 20
      },
      "material": "wood",
      "color": "white",
      "notes": ["Handle with care", "Check for damage"]
    },
    {
      "id": "mat_002",
      "name": "Wood Screws",
      "description": "Phillips head screws",
      "quantity": 16,
      "imageUrl": "https://example.com/screw.jpg",
      "model3dUrl": "",
      "type": "screw",
      "dimensions": {
        "length": 40,
        "diameter": 4
      },
      "material": "metal",
      "color": "silver",
      "notes": ["Use provided screwdriver"]
    }
  ],
  "steps": [
    {
      "stepNumber": 1,
      "title": "Prepare the workspace",
      "description": "Clear a large flat area and lay out all parts. Check against the parts list.",
      "imageUrl": "https://example.com/step1.jpg",
      "model3dUrl": "https://example.com/step1.glb",
      "requiredMaterials": ["mat_001"],
      "tools": ["screwdriver"],
      "estimatedTime": 5,
      "difficulty": "Easy",
      "warnings": ["Ensure all parts are present before starting"],
      "tips": ["Sort screws by size", "Keep instructions nearby"],
      "videoUrl": ""
    },
    {
      "stepNumber": 2,
      "title": "Attach side panels",
      "description": "Align side panels with headboard. Insert screws and tighten in a cross pattern.",
      "imageUrl": "https://example.com/step2.jpg",
      "model3dUrl": "https://example.com/step2.glb",
      "requiredMaterials": ["mat_001", "mat_002"],
      "tools": ["screwdriver", "allen key"],
      "estimatedTime": 15,
      "difficulty": "Medium",
      "warnings": ["Do not overtighten screws"],
      "tips": ["Have someone help hold panels", "Tighten gradually"],
      "videoUrl": ""
    }
  ],
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z"
}
```

**Add more furniture items** with different categories:
- BILLY Bookcase (category: "Shelves")
- MICKE Desk (category: "Desks")
- POÄNG Chair (category: "Chairs")
- KALLAX Storage (category: "Storage")

**Collection: `categories`**
```json
[
  { "name": "Beds", "icon": "bed", "order": 1 },
  { "name": "Desks", "icon": "desk", "order": 2 },
  { "name": "Chairs", "icon": "chair", "order": 3 },
  { "name": "Storage", "icon": "storage", "order": 4 },
  { "name": "Tables", "icon": "table", "order": 5 },
  { "name": "Shelves", "icon": "shelves", "order": 6 }
]
```

---

## 📁 Step 3: File Structure

Create this exact structure:

```
ikea_assembly_app/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart (auto-generated)
│   ├── models/
│   │   ├── furniture_model.dart
│   │   ├── material_model.dart
│   │   ├── assembly_step_model.dart
│   │   └── user_model.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── firestore_service.dart
│   │   └── storage_service.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   └── furniture_provider.dart
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── furniture/
│   │   │   ├── furniture_detail_screen.dart
│   │   │   └── material_3d_viewer_screen.dart
│   │   └── profile/
│   │       └── profile_screen.dart
│   ├── widgets/
│   │   ├── furniture_card.dart
│   │   ├── material_card.dart
│   │   ├── step_card.dart
│   │   └── custom_button.dart
│   └── utils/
│       ├── constants.dart
│       └── theme.dart
├── assets/
│   ├── images/
│   ├── animations/
│   └── icons/
├── android/
├── ios/
├── firestore.rules
├── storage.rules
└── pubspec.yaml
```

---

## 🔐 Step 4: Copy Security Rules

### firestore.rules
**Already provided above** - Copy to root of project

### storage.rules  
**Already provided above** - Copy to root of project

Deploy rules:
```bash
firebase deploy --only firestore:rules
firebase deploy --only storage:rules
```

---

## 📱 Step 5: Android Setup

Edit `android/app/build.gradle`:

```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.yourcompany.ikea_assembly_app"
        minSdkVersion 21  // Important for Firebase
        targetSdkVersion 34
        multiDexEnabled true
    }
}

dependencies {
    implementation 'com.google.android.gms:play-services-auth:20.7.0'
}
```

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest>
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
</manifest>
```

---

## 🍎 Step 6: iOS Setup

Edit `ios/Runner/Info.plist`:

```xml
<dict>
    <!-- Add Google Sign In -->
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>YOUR_REVERSED_CLIENT_ID</string>
            </array>
        </dict>
    </array>
    
    <!-- Minimum iOS version -->
    <key>MinimumOSVersion</key>
    <string>12.0</string>
</dict>
```

Update `ios/Podfile`:

```ruby
platform :ios, '12.0'

# Add this at the top
$iOSVersion = '12.0'

target 'Runner' do
  use_frameworks!
  use_modular_headers!
  
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

Run:
```bash
cd ios
pod install
cd ..
```

---

## 🎨 Step 7: Remaining Widget Files

### lib/widgets/furniture_card.dart

```dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/furniture_model.dart';
import '../utils/theme.dart';

class FurnitureCard extends StatelessWidget {
  final Furniture furniture;
  final VoidCallback onTap;

  const FurnitureCard({
    Key? key,
    required this.furniture,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppTheme.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'furniture_${furniture.id}',
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackgroundDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: furniture.imageUrl,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.secondaryColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.chair,
                            size: 64,
                            color: AppTheme.textTertiary,
                          ),
                        ),
                      ),
                      if (furniture.has3DModel)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppTheme.accentColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.view_in_ar,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 12,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${furniture.estimatedTime}m',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    furniture.name,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.getDifficultyColor(furniture.difficulty)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          furniture.difficulty,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: AppTheme.getDifficultyColor(furniture.difficulty),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 2),
                      Text(
                        furniture.rating.toStringAsFixed(1),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## ⚡ Step 8: Run the App

```bash
# Clean and get packages
flutter clean
flutter pub get

# For Android
flutter run

# For iOS
flutter run -d ios

# For Web (limited 3D support)
flutter run -d chrome
```

---

## 🎯 Step 9: Test Features

### A) Authentication
1. Register new account with email/password
2. Sign in with Google
3. Test password reset

### B) Browse Furniture
1. View all categories
2. Search furniture by name
3. Filter by category

### C) Furniture Details
1. View 3D model (if available)
2. Browse materials list
3. Follow assembly steps

### D) User Features
1. Add to favorites
2. Track assembly progress
3. View profile

---

## 🐛 Common Issues & Solutions

### Issue: Firebase not initialized
```bash
flutter clean
rm -rf ios/Pods ios/.symlinks ios/Podfile.lock
cd ios && pod install && cd ..
flutter run
```

### Issue: Google Sign In not working
- Check SHA-1 fingerprint in Firebase Console
- Ensure google-services.json (Android) is in correct location
- Verify GoogleService-Info.plist (iOS) is added to Xcode

### Issue: 3D models not loading
- Check CORS settings on your storage
- Verify model URLs are accessible
- Use .glb format for best compatibility

---

## 📊 Performance Tips

1. **Image Optimization**: Use cached_network_image for all images
2. **Lazy Loading**: Implement pagination for large furniture lists
3. **3D Models**: Compress models to < 5MB each
4. **Offline Support**: Add local caching for favorites
5. **Analytics**: Track user behavior with Firebase Analytics

---

## 🚀 Deployment

### Android:
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS:
```bash
flutter build ios --release
# Then open Xcode and archive
```

---

## 📚 Next Steps

1. **Add AR Features**: Integrate ARCore/ARKit
2. **Push Notifications**: Notify assembly progress
3. **Social Sharing**: Share completed projects
4. **Offline Mode**: Cache furniture data
5. **Admin Panel**: Manage furniture from app
6. **Multi-language**: i18n support
7. **Video Tutorials**: Integrate video steps
8. **Community Reviews**: User-generated content

---

## 🔗 Useful Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [Flutter Documentation](https://docs.flutter.dev)
- [3D Model Formats](https://modelviewer.dev)
- [IKEA Assembly Instructions](https://www.ikea.com/assembly)

---

## ✅ Checklist

- [ ] Flutter project created
- [ ] Firebase configured
- [ ] All dependencies installed
- [ ] Security rules deployed
- [ ] Sample data added to Firestore
- [ ] Authentication working
- [ ] App running successfully
- [ ] 3D models loading
- [ ] All features tested

---

**🎉 Congratulations! Your IKEA Assembly App is ready!**

For support, issues, or contributions, please contact your development team.