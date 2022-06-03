import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/models/wallpapermodel.dart';
import 'package:wallpaper/screens/customwidgets.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Wallpapermodel> wallpapers = [];
  bool searching = false;

  Search() async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=${searchcontrol.text.toString().toLowerCase().trim()}&per_page=1000"),
        headers: {"Authorization": myapikey});
    print(response.body.toString());
    Map<String, dynamic> jsondata = jsonDecode(response.body);
    jsondata["photos"].forEach((element) {
      // print(element);
      Wallpapermodel wallpapermodel;
      wallpapermodel = Wallpapermodel.fromMap(element);
      wallpapers.add(wallpapermodel);
      setState(() {
        wallpapers.add(wallpapermodel);
      });

      print(wallpapers.toString());
    });

    setState(() {});
  }

  TextEditingController searchcontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(46, 52, 59, 90),
        body: Stack(
          children: [
            ListView(children: [
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
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
                    Container(),
                    SizedBox()
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(39, 42, 48, 70),
                    borderRadius: BorderRadius.circular(22)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchcontrol,
                        autofocus: true,
                        style: const TextStyle(
                            color: Color.fromRGBO(234, 174, 52, 0.6)),
                        decoration: InputDecoration(
                            // errorText: 'Search Query Cannot be Empty',
                            hintText: "search wallpapers",
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.2)),
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        wallpapers.clear();
                        if (searchcontrol.text.isEmpty) {
                          const snackBar = SnackBar(
                            content: Text(
                              'Please Enter at least a word',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: (Colors.red),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Search();
                        }
                      },
                      child: Icon(
                        Icons.search_rounded,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              )
            ]),

            //
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: wallpapers.isEmpty
                  ? error_widget()
                  : WallpapersList(wallpapers: wallpapers, context: context),
            )
          ],
        ));
  }
}
