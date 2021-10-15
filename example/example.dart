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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cachedImage(),
              noncachedImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget noncachedImage() {
    return Column(
      children: [
        TfPhotoAvatar.noncached(
          imageUrl: testImageUrl,
          placeholderAssetPath: testPlaceholderAssetPath,
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
          onErrorImage: const AssetImage(testErrorImageAssetPath),
          onLoadingImage: const AssetImage(testPlaceholderAssetPath),
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
