import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/Provider/getStatusProvider.dart';
import 'package:myapp/Ui/NavPages/ImagePage/image_view.dart';
import 'package:myapp/Ui/NavPages/VideoPage/video_view.dart';
import 'package:myapp/Utils/getThumbnails.dart';

class VideoHomePage extends StatefulWidget {
  const VideoHomePage({Key? key}) : super(key: key);

  @override
  State<VideoHomePage> createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<GetStatusProvider>(builder: (context, file, child) {
      if (_isFetched == false) {
        file.getStatus(".mp4");
        Future.delayed(const Duration(microseconds: 1), () {
          _isFetched = true;
        });
      }
      return file.isWhatsappAvailable == false
          ? const Center(
              child: Text("Whatsapp not available"),
            )
          : file.getVideos.isEmpty
              ? const Center(
                  child: Text("No Video available"),
                )
              : Container(
                  padding: const EdgeInsets.all(20),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    children: List.generate(file.getVideos.length, (index) {
                      final data = file.getVideos[index];
                      return FutureBuilder<String>(
                          future: getThumbnail(data.path),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (_) => VideoView(
                                                  videoPath: data.path,
                                                )),
                                      );
                                    },
                                    child: Container(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image(
                                                fit: BoxFit.fill,
                                                image: FileImage(File(snapshot.data!))),
                            
                          ),
                                    ),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          });
                    }),
                  ),
                );
    }));
  }
}