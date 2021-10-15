import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TfPhotoAvatar extends StatelessWidget {
  /// The url of image to be shown.
  final String imageUrl;

  /// Flag to indicated whether to use cached image or not.
  final bool useImageCache;

  /// Radius of the Avatar, defaults to 50.0.
  final double radius;

  /// The background color to fill the avatar, defaults to Colors.grey.
  final Color backgroundColor;

  /// Will resize the image in memory to have a certain width using [ResizeImage].
  final int? memoryCacheHeight;

  /// Will resize the image in memory to have a certain height using [ResizeImage].
  final int? memoryCacheWidth;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? imageFit;

  /// The path to the asset image to be shown till the network image is loading.
  final String? onLoadingImageAssetPath;

  /// The path to the asset image to be shown in the case their occured any error while loading network image.
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

  /// Creates a widget to show network image with implicit cache capabilities.
  ///
  /// [imageUrl]: The url of image to be shown.
  ///
  /// [radius]: Radius of the Avatar, defaults to 50.0.
  ///
  /// [backgroundColor]: The background color to fill the avatar, defaults to Colors.grey.
  ///
  /// [onLoadingImageAssetPath]: The path to the asset image to be shown till the network image is loading.
  ///
  /// [onErrorImageAssetPath]: The path to the asset image to be shown in the case their occured any error while loading network image.
  ///
  /// [memoryCacheHeight]: Will resize the image in memory to have a certain height using [ResizeImage].
  ///
  /// [memoryCacheWidth]: Will resize the image in memory to have a certain width using [ResizeImage].
  ///
  /// [imageFit]: How to inscribe the image into the space allocated during layout.
  ///
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

  /// Creates a widget to show network image without cache capabilities.
  ///
  /// [imageUrl]: The url of image to be shown.
  ///
  /// [radius]: Radius of the Avatar, defaults to 50.0.
  ///
  /// [backgroundColor]: The background color to fill the avatar, defaults to Colors.grey.
  ///
  /// [onLoadingImageAssetPath]: The path to the asset image to be shown till the network image is loading.
  ///
  /// [onErrorImageAssetPath]: The path to the asset image to be shown in the case their occured any error while loading network image.
  ///
  /// [imageFit]: How to inscribe the image into the space allocated during layout.
  ///
  ///
  /// [imageCacheWidth] or [imageCacheHeight] are provided, it indicates to the
  /// engine that the respective image should be decoded at the specified size.
  /// The image will be rendered to the constraints of the layout or [width]
  /// and [height] regardless of these parameters. These parameters are primarily
  /// intended to reduce the memory usage of [ImageCache].
  ///
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
    // depending on the flag to use cache, return the corresponding widget
    if (useImageCache) {
      return _buildCachedAvatar();
    } else {
      return _buildUncachedAvatar();
    }
  }

  /// widget to be shown if no image exist
  Widget get onImageErrorWidget => CircleAvatar(
        backgroundColor: backgroundColor,
        radius: radius,
        backgroundImage: onErrorImageAssetPath == null
            ? null
            : AssetImage(onErrorImageAssetPath!),
      );

  /// placeholder widget while image loads
  Widget get onImageLoadingWidget => CircleAvatar(
        backgroundColor: backgroundColor,
        radius: radius,
        backgroundImage: onLoadingImageAssetPath == null
            ? null
            : AssetImage(onLoadingImageAssetPath!),
      );

  /// Builds a circular avatar without cache
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

  /// Builds a circular avatar with cache
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
