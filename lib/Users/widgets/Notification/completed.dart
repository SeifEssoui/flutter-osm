import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osmflutter/constant/colorsFile.dart';

class AlertCompleted extends StatefulWidget {
  @override
  _AlertCompletedState createState() => _AlertCompletedState();
}

class _AlertCompletedState extends State<AlertCompleted> {
  late double _height;
  late double _width;
  List<Color> cardColors = List.filled(4, colorsFile.cardColor);


  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colorsFile.cardColor,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: List.generate(
                  4,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        cardColors[index] =
                            (cardColors[index] == colorsFile.cardColor)
                                ? colorsFile.icons
                                : colorsFile.cardColor;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 16.0,
                        top: 16.0,
                      ),
                      child: GlassmorphicContainer(
                        height: _height * 0.1,
                        width: _width * 0.8,
                        borderRadius: 15,
                        blur: 100,
                        alignment: Alignment.center,
                        border: 2,
                        linearGradient: LinearGradient(
                          colors: [
                            (cardColors[index] == colorsFile.cardColor)
                                ? Color(0xFFD8E6EE)
                                : cardColors[index],
                            (cardColors[index] == colorsFile.cardColor)
                                ? Color(0xFFD8E6EE)
                                : cardColors[index],
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderGradient: LinearGradient(
                          colors: [
                            Colors.white24.withOpacity(0.2),
                            Colors.white70.withOpacity(0.2),
                          ],
                        ),




                        child: Container(
                           child: Row(
                            
                            children: [
                              SizedBox(width:8,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                         
                          
                                  child: Column(
                                    
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height:8,),
                                       
                                          Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    
                                      SizedBox(height: 18),
                                     
                                      Text(
                                        "Foulen Ben Foulen",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: (cardColors[index] ==
                                                  colorsFile.cardColor)
                                              ? colorsFile.titleCard
                                              : Colors.white,
                                        ),
                                      ),
                                      Spacer(),
                               Padding(
                                 padding: const EdgeInsets.only(right:8.0),
                                 child: Text(
                                        "2023-01-25 at 07:20",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: (cardColors[index] ==
                                                  colorsFile.cardColor)
                                              ? colorsFile.titleCard
                                              : Colors.white,
                                        ),
                                      ),
                               ),
                                ],
                              ),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                      SizedBox(height: 5),
                                      SizedBox(height: 13),
                                      Row(
                                    children: [
                                      Text(
                                        "--->",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: colorsFile.detailColor),
                                      ),
                                      Text(
                                        "EY Tower",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: colorsFile.detailColor),
                                      ),
                                     
                                    ],
                                  ),
                                      Spacer(),
                               Padding(
                                 padding: const EdgeInsets.only(right:8.0),
                                 child: Text(
                                        "Done",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: colorsFile.done,
                                        ),
                                      ),
                               ),
                                ],
                              ),
                                   
                                  
                             
                                    ],
                                  ),
                                  
                                
                           
                          
                        ),
                      ),
                           
                            ],
                           ),
                    ),
                  ),
                ),
              ),
            ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}
