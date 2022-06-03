import 'dart:convert';

import 'dart:ui';

import 'package:wallpaper/screens/viewimage.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/models/wallpapermodel.dart';
import 'package:wallpaper/screens/customwidgets.dart';
import 'package:wallpaper/screens/search.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  List<Wallpapermodel> wallpapers = [];
  List<Wallpapermodel> science = [];
  List<Wallpapermodel> technology = [];
  List<Wallpapermodel> nature = [];
  List<Wallpapermodel> dark = [];
  late TabController tabController;
  String text = '';

  fetchTrending() async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=300"),
        headers: {"Authorization": myapikey});
    print(response.body.toString());
    Map<String, dynamic> jsondata = jsonDecode(response.body);
    jsondata["photos"].forEach((element) {
      // print(element);
      Wallpapermodel wallpapermodel;
      wallpapermodel = Wallpapermodel.fromMap(element);
      wallpapers.add(wallpapermodel);

      print(wallpapers.toString());
    });

    setState(() {});
  }

  Science() async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=science&per_page=300"),
        headers: {"Authorization": myapikey});
    print(response.body.toString());
    Map<String, dynamic> jsondata = jsonDecode(response.body);
    jsondata["photos"].forEach((element) {
      // print(element);
      Wallpapermodel wallpapermodel;
      wallpapermodel = Wallpapermodel.fromMap(element);
      science.add(wallpapermodel);

      print(science.toString());
    });

    setState(() {});
  }

  Technology() async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=technology&per_page=300"),
        headers: {"Authorization": myapikey});
    print(response.body.toString());
    Map<String, dynamic> jsondata = jsonDecode(response.body);
    jsondata["photos"].forEach((element) {
      // print(element);
      Wallpapermodel wallpapermodel;
      wallpapermodel = Wallpapermodel.fromMap(element);
      technology.add(wallpapermodel);

      print(technology.toString());
    });

    setState(() {});
  }

  //Nature
  Nature() async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=nature&per_page=300"),
        headers: {"Authorization": myapikey});
    print(response.body.toString());
    Map<String, dynamic> jsondata = jsonDecode(response.body);
    jsondata["photos"].forEach((element) {
      // print(element);
      Wallpapermodel wallpapermodel;
      wallpapermodel = Wallpapermodel.fromMap(element);
      nature.add(wallpapermodel);

      print(nature.toString());
    });

    setState(() {});
  }

  //dark
  Dark() async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=dark&per_page=300"),
        headers: {"Authorization": myapikey});
    print(response.body.toString());
    Map<String, dynamic> jsondata = jsonDecode(response.body);
    jsondata["photos"].forEach((element) {
      // print(element);
      Wallpapermodel wallpapermodel;
      wallpapermodel = Wallpapermodel.fromMap(element);
      dark.add(wallpapermodel);

      print(dark.toString());
    });

    setState(() {});
  }

  @override
  void initState() {
    fetchTrending();
    Science();
    Technology();
    Nature();
    Dark();
    List category = [
      'Trending...',
      'Science...',
      'Technology...',
      'Nature...',
      'Dark...'
    ];
    tabController = TabController(length: 5, vsync: this);
    text = category[tabController.index];
    tabController.addListener(() {
      setState(() {
        text = category[tabController.index];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 52, 59, 90),
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        // // try {
                        // //   fetchTrending();
                        // // } catch (e) {
                        // //   print(e.toString());
                        // // }

                        // Navigator.push
                        //

                        //(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const ImageView(
                        //             imgurl: "assets/images/new.png")));
                      },
                      icon: const Icon(
                        Icons.home,
                        color: Color.fromRGBO(234, 174, 52, 10),
                      ),
                    ),
                    const Text(
                      "WallEagle",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Search(),
                            ),
                          );
                        },
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        mini: true,
                        elevation: 0.0,
                        child: const Icon(
                          Icons.search_outlined,
                          color: Color.fromRGBO(234, 174, 52, 10),
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white.withOpacity(0.8)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TabBar(
                  controller: tabController,
                  indicatorColor: const Color.fromRGBO(234, 174, 52, 10),
                  labelColor: const Color.fromRGBO(234, 174, 52, 10),
                  unselectedLabelColor: Colors.grey.withOpacity(0.5),
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      child: Text(
                        "Trending",
                      ),
                    ),
                    Tab(
                      child: Text("Science"),
                    ),
                    Tab(
                      child: Text("Technology"),
                    ),
                    Tab(
                      child: Text("Nature"),
                    ),
                    Tab(
                      child: Text("Dark"),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.239),
            // color: Colors.black,
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: tabController,
              children: [
                wallpapers.isEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const loading_widget(),
                      )
                    : WallpapersList(wallpapers: wallpapers, context: context),
                science.isEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const loading_widget(),
                      )
                    : WallpapersList(wallpapers: science, context: context),
                technology.isEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const loading_widget(),
                      )
                    : WallpapersList(wallpapers: technology, context: context),
                nature.isEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const loading_widget(),
                      )
                    : WallpapersList(wallpapers: nature, context: context),
                dark.isEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const loading_widget(),
                      )
                    : WallpapersList(wallpapers: dark, context: context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget appbarwidget({required double width}) {
    return Container(
      height: 4,
      width: width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: Colors.black.withOpacity(0.9)),
    );
  }

  Widget frostedglass(double width, height, Widget child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.transparent,
      ),
      width: width,
      height: height,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(),
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.333)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.05)
                      ]))),
          child
        ],
      ),
    );
  }
}
