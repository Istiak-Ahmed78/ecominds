import 'package:flutter/material.dart';

class HomwView extends StatelessWidget {
  HomwView({super.key});
  final List<Map<String, dynamic>> _listItem = [
    {
      "image":
          'https://u4d2z7k9.rocketcdn.me/wp-content/uploads/2021/08/rsz__nguyen_quoc_huy_2.jpg',
      "title": 'Water pollution'
    },
    {
      "image":
          'https://images.nationalgeographic.org/image/upload/t_edhub_resource_key_image/v1652341008/EducationHub/photos/deforestation.jpg',
      "title": 'De forestration'
    },
    {
      "image":
          'https://u4d2z7k9.rocketcdn.me/wp-content/uploads/2022/02/Untitled-design-2022-02-21T125712.140.jpg',
      "title": 'Water problem'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SDG Solution',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/free-vector/gradient-blur-colorful-phone-wallpaper-vector_53876-171597.jpg'),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text(
                        "Sabbir Ahmed",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(
                            child: Text(
                          "See your progress",
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _listItem
                    .map((item) => Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(item["image"]),
                                    fit: BoxFit.cover)),
                            child: Transform.translate(
                              offset: const Offset(55, -58),
                              child: Container(
                                width: 30,
                                // height: 30,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(),
                                child: const SizedBox(),
                              ),
                              // child: InkWell(
                              //   onLongPress: () {},
                              //   child: Container(
                              //     margin: EdgeInsets.symmetric(horizontal:70, vertical: 71),
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(8),
                              //       color: Colors.white
                              //     ),
                              //     child: Icon(Icons.bookmark_border, size: 22,),
                              //   ),
                              // ),
                            ),
                          ),
                        ))
                    .toList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
