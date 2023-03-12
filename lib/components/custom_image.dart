import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatefulWidget {
  const CustomImage({Key? key, required this.searchTerm}) : super(key: key);
  final String searchTerm;
  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  late Future<String> _imageFuture;
  Dio dio = Dio();
  String unsplashApiEndpoint = "https://api.unsplash.com/";
  String unsplashAccessKey = "rqBHEMONDcoTztUh7ucFfAim6J1Uka4LBmjWgKXCgxI";
  Future<String> getImage(String searchTerm) async {
    String imageUrl = "";

    try {
      Response response = await dio.get(
        "${unsplashApiEndpoint}search/photos",
        queryParameters: {
          "query": "$searchTerm veg food",
          "orientation": "landscape",
          "per_page": 1,
        },
        options: Options(
          headers: {
            "Authorization": "Client-ID $unsplashAccessKey",
          },
        ),
      );

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.toString());
        imageUrl = data["results"][0]["urls"]["regular"];
      }
    } catch (e) {
      print(e);
    }

    return imageUrl;
  }

  @override
  void initState() {
    super.initState();
    _imageFuture = getImage(widget.searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<String>(
        future: _imageFuture,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return CachedNetworkImage(
              imageUrl: snapshot.data!,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
