import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class ImageView extends StatefulWidget {
  final String imgurl;
  final String photographer;
  const ImageView({Key? key, required this.imgurl, required this.photographer})
      : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool zoom = false;

  @override
  void initState() {
    setState(() {
      zoom = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: zoom
          ? null
          : AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color.fromRGBO(234, 174, 52, 10),
                ),
              ),
              elevation: 0.0,
              centerTitle: true,
              title: const Text(
                "WallEagle",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              backgroundColor: Colors.transparent),
      backgroundColor: const Color.fromRGBO(46, 52, 59, 90),
      body: Stack(
        children: [
          Hero(
            tag: widget.imgurl,
            child: Center(
              child: Container(
                  height: zoom
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.height * 0.85,
                  width: zoom
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width * 0.9,
                  child: zoom
                      ? CachedNetworkImage(
                          imageUrl: widget.imgurl,
                          fit: BoxFit.cover,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: CachedNetworkImage(
                            imageUrl: widget.imgurl,
                            fit: BoxFit.cover,
                          ),
                        )),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: const Material(
                    color: Color.fromRGBO(109, 109, 108, 0.6),
                    elevation: 12,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    shadowColor: Color.fromRGBO(29, 33, 37, 1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 34, top: 3.5, right: 34, bottom: 10),
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: const Color.fromRGBO(29, 33, 37, 0.9),
                    elevation: 12,
                    shadowColor: const Color.fromRGBO(29, 33, 37, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            splashColor: const Color.fromRGBO(234, 174, 52, 10),
                            iconSize: 30,
                            onPressed: () {
                              if (zoom) {
                                setState(() {
                                  zoom = false;
                                });
                              } else {
                                setState(() {
                                  zoom = true;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.image_rounded,
                              color: Color.fromARGB(255, 90, 90, 58),
                            )),
                        IconButton(
                            splashColor: const Color.fromRGBO(234, 174, 52, 10),
                            iconSize: 30,
                            onPressed: () {
                              showDetail(
                                  context: context,
                                  photographer: widget.photographer);
                            },
                            icon: const Icon(
                              Icons.info_outline_rounded,
                              color: Color.fromRGBO(109, 109, 108, 1),
                            )),
                        IconButton(
                            splashColor: const Color.fromRGBO(234, 174, 52, 10),
                            iconSize: 30,
                            onPressed: () {
                              showAlertDialog(
                                  context: context, imgurl: widget.imgurl);
                            },
                            icon: const Icon(
                              Icons.download_rounded,
                              color: Color.fromRGBO(109, 109, 108, 1),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _setwallpaper({required location, required imageurl}) async {
    var file = await DefaultCacheManager().getSingleFile(imageurl);
    try {
      WallpaperManagerFlutter().setwallpaperfromFile(file, location);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wallpaper updated Successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      print(e);
    }
  }

  void showAlertDialog(
      {required BuildContext context, required String imgurl}) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: new Text("Set Image as"),
              content: Container(
                height: 175.7,
                child: Column(
                  children: [
                    FlatButton(
                        onPressed: () {
                          _setwallpaper(
                              location: WallpaperManagerFlutter.HOME_SCREEN,
                              imageurl: imgurl);
                          Navigator.pop(context);
                        },
                        child: const Text("Home Screen")),
                    const Divider(
                      thickness: 2,
                    ),
                    FlatButton(
                        onPressed: () {
                          _setwallpaper(
                              location: WallpaperManagerFlutter.LOCK_SCREEN,
                              imageurl: imgurl);
                          Navigator.pop(context);
                        },
                        child: const Text("ScreenLock")),
                    const Divider(
                      thickness: 2,
                    ),
                    FlatButton(
                        onPressed: () {
                          _setwallpaper(
                              location: WallpaperManagerFlutter.BOTH_SCREENS,
                              imageurl: imgurl);
                          Navigator.pop(context);
                        },
                        child: const Text("Both")),
                  ],
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  void showDetail(
      {required BuildContext context, required String photographer}) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: new Text("Photo Deatils"),
              content: Text("Created by: $photographer"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}
