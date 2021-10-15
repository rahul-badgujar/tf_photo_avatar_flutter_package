import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TfPhotoAvatar extends StatelessWidget {
  final String imageUrl;
  final bool useImageCache;
  final double radius;
  final Color backgroundColor;
  final int? memoryCacheHeight;
  final int? memoryCacheWidth;
  final BoxFit? imageFit;
  final String? onLoadingImageAssetPath;
  final String? onErrorImageAssetPath;

  const TfPhotoAvatar._({
    Key? key,
    required this.imageUrl,
    this.useImageCache = false,
    this.radius = 50,
    this.backgroundColor = Colors.grey,
    this.memoryCacheHeight,
    this.memoryCacheWidth,
    this.imageFit,
    this.onLoadingImageAssetPath,
    this.onErrorImageAssetPath,
  }) : super(key: key);

  factory TfPhotoAvatar.cached(
      {required String imageUrl,
      double radius = 50,
      Color backgroundColor = Colors.grey,
      String? onLoadingImageAssetPath,
      String? onErrorImageAssetPath,
      int? memoryCacheHeight,
      int? memoryCacheWidth,
      BoxFit? imageFit}) {
    return TfPhotoAvatar._(
      imageUrl: imageUrl,
      useImageCache: true,
      radius: radius,
      backgroundColor: backgroundColor,
      onLoadingImageAssetPath: onLoadingImageAssetPath,
      onErrorImageAssetPath: onErrorImageAssetPath,
      memoryCacheHeight: memoryCacheHeight,
      memoryCacheWidth: memoryCacheWidth,
    );
  }

  factory TfPhotoAvatar.noncached({
    required String imageUrl,
    double radius = 50,
    Color backgroundColor = Colors.grey,
    String? onLoadingImageAssetPath,
    String? onErrorImageAssetPath,
    int? imageCacheHeight,
    int? imageCacheWidth,
    BoxFit? imageFit,
  }) {
    return TfPhotoAvatar._(
      imageUrl: imageUrl,
      useImageCache: false,
      radius: radius,
      backgroundColor: backgroundColor,
      onLoadingImageAssetPath: onLoadingImageAssetPath,
      onErrorImageAssetPath: onErrorImageAssetPath,
      imageFit: imageFit,
      memoryCacheHeight: imageCacheHeight,
      memoryCacheWidth: imageCacheWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (useImageCache) {
      return _buildCachedAvatar();
    } else {
      return _buildUncachedAvatar();
    }
  }

  // widget to be shown if no image exist
  Widget get onImageErrorWidget => CircleAvatar(
        backgroundColor: backgroundColor,
        radius: radius,
        backgroundImage: onErrorImageAssetPath == null
            ? null
            : AssetImage(onErrorImageAssetPath!),
      );

  // placeholder widget while image loads
  Widget get onImageLoadingWidget => CircleAvatar(
        backgroundColor: backgroundColor,
        radius: radius,
        backgroundImage: onLoadingImageAssetPath == null
            ? null
            : AssetImage(onLoadingImageAssetPath!),
      );

  Widget _buildUncachedAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: FadeInImage.assetNetwork(
        placeholder:
            onLoadingImageAssetPath!, // placeholderAssetPath can never be null here
        image: imageUrl,
        fit: imageFit,
        height: 2 * radius,
        width: 2 * radius,
        imageCacheHeight: memoryCacheHeight, imageCacheWidth: memoryCacheWidth,
        imageErrorBuilder: (context, error, stackTrace) => onImageErrorWidget,
      ),
    );
  }

  Widget _buildCachedAvatar() {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: imageFit,
      memCacheHeight: memoryCacheHeight,
      memCacheWidth: memoryCacheWidth,
      height: 2 * radius,
      width: 2 * radius,
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          backgroundColor: backgroundColor,
          backgroundImage: imageProvider,
          radius: radius,
        );
      },
      placeholder: (context, url) {
        return onImageLoadingWidget;
      },
      errorWidget: (context, url, error) {
        return onImageErrorWidget;
      },
    );
  }
}
