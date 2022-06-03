import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/models/wallpapermodel.dart';
import 'package:wallpaper/screens/viewimage.dart';

//api key
var myapikey = "563492ad6f9170000100000178826402ba084330afbded472de7bf19";

Widget Wallpapers({required List<Wallpapermodel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: GridView.count(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 6.0,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        children: wallpapers.map((wallpaper) {
          return GridTile(
              child: Container(
                  child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            photographer: wallpaper.photographer,
                            imgurl: wallpaper.src.portrait,
                          )));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  wallpaper.src.portrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )));
        }).toList()),
  );
}

class WallpapersList extends StatefulWidget {
  List<Wallpapermodel> wallpapers;
  WallpapersList({Key? key, required this.wallpapers, context})
      : super(key: key);

  @override
  State<WallpapersList> createState() => _WallpapersListState();
}

class _WallpapersListState extends State<WallpapersList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.count(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 6.0,
          childAspectRatio: 0.6,
          mainAxisSpacing: 6.0,
          children: widget.wallpapers.map((wallpaper) {
            return GridTile(
                child: Container(
                    child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageView(
                            imgurl: wallpaper.src.portrait,
                            photographer: wallpaper.photographer)));
              },
              child: Hero(
                tag: wallpaper.src.portrait,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: wallpaper.src.portrait,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )));
          }).toList()),
    );
  }
}

class loading_widget extends StatelessWidget {
  const loading_widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(
          height: 20,
        ),
        Text(
          "Loading Wallpapers",
          style: TextStyle(color: Color.fromRGBO(234, 174, 52, 10)),
        )
      ],
    );
  }
}

class error_widget extends StatelessWidget {
  const error_widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
          size: 30,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Enter Search query ",
          style: TextStyle(color: Color.fromRGBO(234, 174, 52, 10)),
        )
      ],
    );
  }
}
