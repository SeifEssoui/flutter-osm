import 'package:osmflutter/constant/colorsFile.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osmflutter/GoogleMaps/googlemaps.dart';

import 'package:osmflutter/mapOsm/home_example.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late double _height;
  late double _width;
  Color baseColor = const Color(0xFFf2f2f2);
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color.fromRGBO(94, 149, 180, 1),
                Color.fromRGBO(77, 140, 175, 1),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
        ),
        toolbarHeight: 80.0,
        title: Column(
          children: [
            const SizedBox(height: 16.0),


          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Photo
          MapsGoogleExample(),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: colorsFile.cardColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child:Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -40,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          height: 90,
                          padding: EdgeInsets.all(5), // Border width
                          decoration: BoxDecoration(
                              color: colorsFile.borderCircle, shape: BoxShape.circle),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(40), // Image radius
                              child: Image(
                                image: AssetImage("assets/images/homme1.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                    onTap: () {
                                      // Call your void method or add logic for the entire structure
                                      // _showModalBottomSheet1(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child:  Stack(
                                        children: [
                                          ClayContainer(
                                            color: Colors.white,
                                            height: 50,
                                            width: 50,
                                            borderRadius: 50,
                                            curveType: CurveType.concave,
                                            depth: 30,
                                            spread: 1,
                                          ),
                                          Center(
                                            child: ClayContainer(
                                              color: Colors.white,
                                              height: 40,
                                              width: 40,
                                              borderRadius: 40,
                                              curveType: CurveType.convex,
                                              depth: 30,
                                              spread: 1,
                                              child: Center(
                                                child: Icon(Icons.history_outlined,
                                                  color: colorsFile.ProfileIcon,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                    onTap: () {
                                      // Call your void method or add logic for the entire structure
                                      // _showModalBottomSheet1(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child:  Stack(
                                        children: [
                                          ClayContainer(
                                            color: Colors.white,
                                            height: 50,
                                            width: 50,
                                            borderRadius: 50,
                                            curveType: CurveType.concave,
                                            depth: 30,
                                            spread: 1,
                                          ),
                                          Center(
                                            child: ClayContainer(
                                              color: Colors.white,
                                              height: 40,
                                              width: 40,
                                              borderRadius: 40,
                                              curveType: CurveType.convex,
                                              depth: 30,
                                              spread: 1,
                                              child: Center(
                                                child: Icon(Icons.airline_seat_recline_normal_sharp,
                                                  color: colorsFile.ProfileIcon,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          //SizedBox(height: 8,),
                          Text(
                            "Foulen Ben Foulen",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: colorsFile.titleCard),
                          ),
                        ]),
                        GlassmorphicContainer(
                          height: 250,
                          width: _width * 0.9,
                          borderRadius: 15,
                          blur: 100,
                          alignment: Alignment.center,
                          border: 2,
                          linearGradient: const LinearGradient(
                              colors: [Color(0xFFD8E6EE), Color(0xFFD8E6EE)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderGradient: LinearGradient(colors: [
                            Colors.white24.withOpacity(0.2),
                            Colors.white70.withOpacity(0.2)
                          ]),
                          child: Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: colorsFile.detailColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "55 555 555",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: colorsFile.titleCard),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.home,
                                              color: colorsFile.detailColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "V5VP+RH La Marsa",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: colorsFile.titleCard),
                                            ),

                                            IconButton(
                                                onPressed: () => {},
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: colorsFile.skyBlue,
                                                )),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.favorite,
                                                  color: colorsFile.detailColor,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                    children: [
                                                      Row(
                                                          children: [
                                                            Text(
                                                              "V5VP+RH La Marsa",
                                                              style: GoogleFonts.montserrat(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 13,
                                                                  color: colorsFile.titleCard),
                                                            ),

                                                            IconButton(
                                                                onPressed: () => {},
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color: colorsFile.skyBlue,
                                                                )),
                                                          ]
                                                      ),
                                                      Row(
                                                          children: [
                                                            Text(
                                                              "V5VP+RH La Marsa",
                                                              style: GoogleFonts.montserrat(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 13,
                                                                  color: colorsFile.titleCard),
                                                            ),

                                                            IconButton(
                                                                onPressed: () => {},
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color: colorsFile.skyBlue,
                                                                )),
                                                          ]
                                                      ),
                                                      IconButton(
                                                          onPressed: () => {},
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: colorsFile.skyBlue,
                                                          )),

                                                    ]
                                                ),
                                              ],

                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    // Call your void method or add logic for the entire structure
                                                    // _showModalBottomSheet1(context);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    child:  Stack(
                                                      children: [
                                                        ClayContainer(
                                                          color: Colors.white,
                                                          height: 50,
                                                          width: 50,
                                                          borderRadius: 50,
                                                          curveType: CurveType.concave,
                                                          depth: 30,
                                                          spread: 1,
                                                        ),
                                                        Center(
                                                          child: ClayContainer(
                                                            color: Colors.white,
                                                            height: 40,
                                                            width: 40,
                                                            borderRadius: 40,
                                                            curveType: CurveType.convex,
                                                            depth: 30,
                                                            spread: 1,
                                                            child: Center(
                                                              child: Icon(Icons.directions,
                                                                color: colorsFile.ProfileIcon,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],

                                    ),


                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]

                      ),
                    )
                  ],
                )
              )
          ),
        ],
      ),
    );
  }
}