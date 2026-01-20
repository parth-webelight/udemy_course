# favorite_places_app

A new Flutter project.

## Getting Started

# Favorite Places App

A Flutter application for storing and managing your favorite places with images and location data.

## Features

- ✅ **SQLite Local Database**: Persistent storage for all your places
- ✅ **Riverpod State Management**: Efficient state management with Consumer widgets
- ✅ **CRUD Operations**: Create, Read, Update, Delete functionality
- ✅ **Image Capture**: Take photos or select from gallery
- ✅ **Location Services**: Get current GPS location
- ✅ **Modern UI**: Clean, responsive design with Material 3
- ✅ **Hero Animations**: Smooth transitions between screens

## Architecture

- **State Management**: Flutter Riverpod
- **Database**: SQLite with sqflite package
- **Image Handling**: image_picker package
- **Location Services**: location package
- **UI**: Material 3 design with Google Fonts

## Key Components

### Database Layer
- `DBHelper`: Handles all SQLite operations
- Automatic database creation and migration
- CRUD operations for places data

### State Management
- `UserPlacesNotifier`: Manages places state with Riverpod
- Automatic data loading from database
- Real-time UI updates

### UI Components
- `PlacesScreen`: Main screen with places list
- `AddPlacesScreen`: Form for adding new places
- `PlacesDetailScreen`: Detailed view of individual places
- `ImageInput`: Camera/gallery image selection
- `LocationInput`: GPS location capture

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

## Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.5.1
  sqflite: ^2.3.3+1
  image_picker: ^1.2.1
  location: ^8.0.1
  google_fonts: ^7.0.2
  path: ^1.9.0
```

## Permissions

### Android
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### iOS
Add to `ios/Runner/Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take photos of places</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to save place locations</string>
```
