import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TfPhotoAvatar extends StatelessWidget {
  final String imageUrl;
  final bool useImageCache;
  final double radius;
  final Color backgroundColor;
  final ImageProvider? onErrorImage;
  final ImageProvider? onLoadingImage;
  final int? memoryCacheHeight;
  final int? memoryCacheWidth;
  final BoxFit? imageFit;
  final String? placeholderAssetPath;

  const TfPhotoAvatar._({
    Key? key,
    required this.imageUrl,
    this.useImageCache = false,
    this.radius = 50,
    this.backgroundColor = Colors.grey,
    this.onErrorImage,
    this.onLoadingImage,
    this.memoryCacheHeight,
    this.memoryCacheWidth,
    this.imageFit,
    this.placeholderAssetPath,
  }) : super(key: key);

  factory TfPhotoAvatar.cached(
      {required String imageUrl,
      double radius = 50,
      Color backgroundColor = Colors.grey,
      required ImageProvider onErrorImage,
      required ImageProvider onLoadingImage,
      int? memoryCacheHeight,
      int? memoryCacheWidth,
      BoxFit? imageFit}) {
    return TfPhotoAvatar._(
      imageUrl: imageUrl,
      useImageCache: true,
      radius: radius,
      backgroundColor: backgroundColor,
      onErrorImage: onErrorImage,
      onLoadingImage: onLoadingImage,
      memoryCacheHeight: memoryCacheHeight,
      memoryCacheWidth: memoryCacheWidth,
    );
  }

  factory TfPhotoAvatar.noncached({
    required String imageUrl,
    double radius = 50,
    Color backgroundColor = Colors.grey,
    required String placeholderAssetPath,
    int? imageCacheHeight,
    int? imageCacheWidth,
    BoxFit? imageFit,
  }) {
    return TfPhotoAvatar._(
      imageUrl: imageUrl,
      useImageCache: false,
      radius: radius,
      backgroundColor: backgroundColor,
      placeholderAssetPath: placeholderAssetPath,
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
        backgroundImage: onErrorImage,
      );

  // placeholder widget while image loads
  Widget get onImageLoadingWidget => CircleAvatar(
        backgroundColor: backgroundColor,
        radius: radius,
        backgroundImage: onLoadingImage,
      );

  Widget _buildUncachedAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: FadeInImage.assetNetwork(
        placeholder:
            placeholderAssetPath!, // placeholderAssetPath can never be null here
        image: imageUrl,
        fit: imageFit,
        height: 2 * radius,
        width: 2 * radius,
        imageCacheHeight: memoryCacheHeight, imageCacheWidth: memoryCacheWidth,
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
