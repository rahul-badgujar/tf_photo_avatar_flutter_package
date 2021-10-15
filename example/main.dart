import 'package:flutter/material.dart';
import 'package:tf_photo_avatar/tf_photo_avatar.dart';

const testImageUrl = 'https://avatars.githubusercontent.com/u/44890430?v=4';
const testPlaceholderAssetPath = 'assets/gif/loading_spinner.gif';
const testErrorImageAssetPath = 'assets/icons/user.png';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<bool> showCachedImage = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: showCachedImage,
              builder: (context, useCachedImage, _) {
                if (useCachedImage) {
                  return cachedImage();
                } else {
                  return noncachedImage();
                }
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: showCachedImage,
                  builder: (context, useCachedImage, _) {
                    return Checkbox(
                      value: useCachedImage,
                      onChanged: (newVal) {
                        showCachedImage.value = newVal ?? false;
                      },
                    );
                  },
                ),
                const Text(
                  'Change Cache Status',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget noncachedImage() {
    return Column(
      children: [
        TfPhotoAvatar.noncached(
          imageUrl: testImageUrl,
          onLoadingImageAssetPath: testPlaceholderAssetPath,
          onErrorImageAssetPath: testErrorImageAssetPath,
          radius: 90,
          imageCacheHeight: 100,
          imageCacheWidth: 100,
          imageFit: BoxFit.fill,
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Non Cached Image',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget cachedImage() {
    return Column(
      children: [
        TfPhotoAvatar.cached(
          imageUrl: testImageUrl,
          onErrorImageAssetPath: testErrorImageAssetPath,
          onLoadingImageAssetPath: testPlaceholderAssetPath,
          radius: 90,
          memoryCacheHeight: 100,
          memoryCacheWidth: 100,
          imageFit: BoxFit.fill,
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Cached Image',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
