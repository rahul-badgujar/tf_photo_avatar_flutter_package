# tf_photo_avatar

tf_photo_avatar is the Tenfins Circular Photo Avatar Widget. It supports Cached and Non-cached Image options.

## Supported Dart Versions

**Dart SDK version ">=2.12.0 <3.0.0"**

## Installation

Add the Package

```yaml
dependencies:
  tf_photo_avatar: ^1.0.0
```

## How to use

Import the package in your dart file

```dart
import 'package:tf_photo_avatar/tf_photo_avatar.dart';
```

To create a photo avatar with image caching support.

```dart
     TfPhotoAvatar.cached(
        imageUrl: 'www.images.com/img1.png',
        onErrorImageAssetPath: 'assets/images/error.png',
        onLoadingImageAssetPath: 'assets/images/loading.png',
        radius: 90,
        memoryCacheHeight: 100,
        memoryCacheWidth: 100,
        imageFit: BoxFit.fill,
    ),
```

To create a photo avatar without image caching support.

```dart
    TfPhotoAvatar.noncached(
        imageUrl: 'www.images.com/img1.png',
        onLoadingImageAssetPath: 'assets/images/loading.png',
        onErrorImageAssetPath: 'assets/images/error.png',
        radius: 90,
        imageCacheHeight: 100,
        imageCacheWidth: 100,
        imageFit: BoxFit.fill,
    ),
```
