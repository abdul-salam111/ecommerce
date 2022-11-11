import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasework/utilities/constants.dart';

import 'package:flutter/material.dart';

class HotOffers extends StatefulWidget {
  const HotOffers({Key? key}) : super(key: key);

  @override
  State<HotOffers> createState() => _HotOffersState();
}

class _HotOffersState extends State<HotOffers> {
  final CollectionReference hotOffers =
      FirebaseFirestore.instance.collection("Carousel");

  @override
  Widget build(BuildContext context) {
   
    return SizedBox(
      height: 200,
      child: StreamBuilder(
        stream: hotOffers.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (snapshot.hasData) {
            return CarouselSlider(
                items: snapshot.data!.docs.map((e) {
                  return Image.network(
                    e.get("Image"),
                    frameBuilder:
                        ((context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: maincolor,
                          ),
                        );
                      }
                    }),
                    loadingBuilder: ((context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: maincolor,
                        ));
                      }
                    }),
                    errorBuilder: (context, error, stackTrace) => SnackBar(
                      content: Text(error.toString() + stackTrace.toString()),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  viewportFraction: 1,
                ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
