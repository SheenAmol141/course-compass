import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CardTemplate extends StatelessWidget {
  final Widget child;
  const CardTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          child: child,
        ));
  }
}

// [
//       Expanded(
//           flex: 1,
//           child: Container(
//             color: LIGHT_GRAY,
//             child: Row(
//               children: [
//                 Expanded(child: Container()),

//                 //CONTENT HERE expanded below ----------------------- gray
//                 Expanded(
//                     flex: 3,
//                     child: Container(
//                       child: Text("data"),
//                     ))
//               ],
//             ),
//           )),
//       Expanded(
//           flex: 2,
//           child: Container(
//             color: Colors.white,
//             child: Row(
//               children: [
//                 Expanded(child: Container()),
//                 //CONTENT HERE expanded below ----------------------- white
//                 Expanded(flex: 3, child: Container())
//               ],
//             ),
//           )),
//     ]

class ClickWidget extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  const ClickWidget({super.key, required this.child, required this.onTap});

  @override
  State<ClickWidget> createState() => _ClickWidgetState();
}

class _ClickWidgetState extends State<ClickWidget> {
  double opacityLev = 1;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          opacityLev = 0.9;
        });
      },
      onExit: (event) {
        setState(() {
          opacityLev = 1;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
            duration: Duration(milliseconds: 150),
            opacity: opacityLev,
            child: widget.child),
      ),
    );
  }
}

class FirebaseStorageImage extends StatefulWidget {
  String filename;
  FirebaseStorageImage({super.key, required this.filename});

  @override
  State<FirebaseStorageImage> createState() => _FirebaseStorageImageState();
}

class _FirebaseStorageImageState extends State<FirebaseStorageImage> {
  late String imageUrl;
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageUrl = '';

    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final ref = storage.ref().child('campuses/${widget.filename}.png');
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl);
  }
}

class FirebaseImageWidget extends StatelessWidget {
  final String imageUrl;

  const FirebaseImageWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref().child(imageUrl).getDownloadURL(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading image: ${snapshot.error}');
        } else {
          final imageUrl = snapshot.data as String;
          return Image.network(imageUrl);
        }
      },
    );
  }
}
