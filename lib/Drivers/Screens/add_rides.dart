import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osmflutter/Drivers/widgets/proposed_rides.dart';
import 'package:flutter/material.dart';
import 'package:osmflutter/Users/BottomSheet/want_to_book.dart';
import 'package:osmflutter/constant/colorsFile.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:osmflutter/GoogleMaps/googlemaps.dart';
import 'package:osmflutter/mapOsm/home_example.dart';
import 'package:osmflutter/shared_preferences/shared_preferences.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddRides extends StatefulWidget {
  const AddRides({Key? key}) : super(key: key);

  @override
  _AddRidesState createState() => _AddRidesState();
}

class _AddRidesState extends State<AddRides> {
  //Google Maps For Home

  //For home

  var origin_address_name = 'Home';

  void origin_address_method(dynamic newlat, dynamic newlng) async {
    List<Placemark> placemark = await placemarkFromCoordinates(newlat, newlng);
    setState(() {});
    origin_address_name =
        "${placemark.reversed.last.country} , ${placemark.reversed.last.locality}, ${placemark.reversed.last.street} ";

    print("Origin Name == ${origin_address_name}");

    setState(() {});
  }

  List<Marker> myMarker = [];

  List<Marker> markers = [];

  Completer<GoogleMapController> _controller = Completer();

  dynamic current_lat1, current_lng1, current_lat2, current_lng2;

  bool check = false;

  google_map_for_origin(GoogleMapController? map_controller) async {
    current_lat1 = await sharedpreferences.getlat();
    current_lng1 = await sharedpreferences.getlng();

    current_lat2 = await sharedpreferences.getlat();
    current_lng2 = await sharedpreferences.getlng();

    print("Shared data is ");
    print("${current_lng1} : ${current_lat1}");

    setState(() {
      check = true;
    });

    showDialog(
        context: context,
        builder: (context) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;

          print("Fetched lat & lnng is ${current_lat1} & ${current_lng1}");
          return Dialog(
            child: Stack(
              children: [
                Container(
                  height: height * 0.7,
                  width: width * 0.8,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: check == true
                      ? GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(current_lat1,
                                current_lng1), // Should be LatLng(current_lat,current_lng)
                            zoom: 14,
                          ),
                          markers: Set<Marker>.of(myMarker),
                          onMapCreated: (GoogleMapController controller) {
                            // _controller.complete(controller);
                            setState(() {
                              map_controller = controller;
                            });
                          },
                          onTap: (position) {
                            mapGoogle(position);
                            setState(() {});
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SearchMapPlaceWidget(
                      hasClearButton: true,
                      iconColor: Colors.black,
                      placeType: PlaceType.address,
                      bgColor: Colors.white,
                      textColor: Colors.black,
                      placeholder: "Search Any Location",
                      apiKey: "AIzaSyBglflWQihT8c4yf4q2MVa2XBtOrdAylmI",
                      onSelected: (Place place) async {
                        Geolocation? geo_location = await place.geolocation;
                        print("running-----");
                        map_controller!.animateCamera(
                            CameraUpdate.newLatLng(geo_location?.coordinates));
                        map_controller!.animateCamera(
                            CameraUpdate.newLatLngBounds(
                                geo_location?.bounds, 0));
                      }),
                ),
              ],
            ),
          );
          ;
        });
  }

  mapGoogle(position) async {
    myMarker.clear();
    current_lat1 = position.latitude;
    current_lng1 = position.longitude;

    Navigator.pop(context);
    origin_address_method(current_lat1, current_lng1);
    myMarker.add(Marker(
      markerId: const MarkerId("First"),
      position: LatLng(current_lat1, current_lng1),
      infoWindow: const InfoWindow(title: "Home Location"),
    ));

    print("After Selecting Origin: Lat & Lng is ");
    print(current_lat1);
    print(current_lng1);

    setState(() {});
    //Setting camera position in setstate
    CameraPosition camera_position =
        CameraPosition(target: LatLng(current_lat1, current_lng1), zoom: 14);

    GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(camera_position));

    // print("-----------Updated-----------");
    // print(lat);
    // print(lng);
  }

  //For EV Tower

  var destination_address_name = 'EV Tower';

  void destination_address_method(double newlat, double newlng) async {
    List<Placemark> placemark = await placemarkFromCoordinates(newlat, newlng);
    setState(() {});
    destination_address_name =
        "${placemark.reversed.last.country} , ${placemark.reversed.last.locality}, ${placemark.reversed.last.street} ";

    print("Destination Name == ${destination_address_name}");
  }

  Completer<GoogleMapController> _controller1 = Completer();

  // Markers

  List<Marker> myMarker1 = [];

  List<Marker> markers1 = [];

  google_map_for_origin1(GoogleMapController? map_controller1) {
    showDialog(
        context: context,
        builder: (context) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          return Dialog(
            child: Stack(
              children: [
                Container(
                  height: height * 0.7,
                  width: width * 0.8,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(current_lat2, current_lng2),
                      zoom: 14,
                    ),
                    markers: Set<Marker>.of(myMarker1),
                    onMapCreated: (GoogleMapController controller1) {
                      setState(() {
                        map_controller1 = controller1;
                      });
                      _controller1.complete(controller1);
                    },
                    onTap: (position) {
                      mapGoogle1(position);
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SearchMapPlaceWidget(
                      hasClearButton: true,
                      iconColor: Colors.black,
                      placeType: PlaceType.address,
                      bgColor: Colors.white,
                      textColor: Colors.black,
                      placeholder: "Search Any Location",
                      apiKey: "AIzaSyBglflWQihT8c4yf4q2MVa2XBtOrdAylmI",
                      onSelected: (Place place) async {
                        Geolocation? geo_location1 = await place.geolocation;
                        print("running ----- ddestination");
                        map_controller1!.animateCamera(
                            CameraUpdate.newLatLng(geo_location1?.coordinates));
                        map_controller1!.animateCamera(
                            CameraUpdate.newLatLngBounds(
                                geo_location1?.bounds, 0));
                      }),
                ),
              ],
            ),
          );
        });
  }

  mapGoogle1(position) async {
    myMarker1.clear();
    current_lat2 = position.latitude;
    current_lng2 = position.longitude;

    print("After Selecting Destination: Lat & Lng is ");
    print(current_lat2);
    print(current_lng2);

    Navigator.pop(context);
    destination_address_method(current_lat2, current_lng2);
    myMarker1.add(Marker(
      markerId: const MarkerId("First"),
      position: LatLng(current_lat2, current_lng2),
      infoWindow: const InfoWindow(title: "EV Tower Location"),
    ));

    setState(() {});
    //Setting camera position in setstate
    CameraPosition camera_position1 =
        CameraPosition(target: LatLng(current_lat2, current_lng2), zoom: 14);

    GoogleMapController controller = await _controller1.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(camera_position1));

    print("-----------Updated-----------");
    print(current_lat2);
    print(current_lng2);
  }

  int selectedIndex = 0;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  bool isSearchPoPupVisible = false;
  bool listSearchBottomSheet = false;
  bool bottomSheetVisible = true;
  bool myRidesbottomSheetVisible = false;
  bool ridesIsVisible = false;
  late double _height;
  late double _width;

  List<DateTime> _selectedDates = [];
  TimeOfDay _selectedTime = TimeOfDay.now();
  double _rating = 0;

  void _selectDateRange(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Change background color here
          content: Container(
            width: 300,
            height: 500,
            child: Column(
              children: [
                Expanded(
                    child: SfDateRangePicker(
                  view: DateRangePickerView.month,
                  headerStyle: const DateRangePickerHeaderStyle(
                    textStyle: TextStyle(color: colorsFile.icons),
                  ),
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                      weekendDays: [7, 6],
                      dayFormat: 'EEE',
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle: TextStyle(color: colorsFile.icons)),
                      showTrailingAndLeadingDates: true),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(color: colorsFile.icons),
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Dismiss the dialog
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            colorsFile.buttonRole), // Change the color here
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: colorsFile.icons),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add your submit logic here
                        Navigator.of(context).pop(); // Dismiss the dialog
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            colorsFile.buttonRole), // Change the color here
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: colorsFile.icons),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primaryColor:
                Colors.blue, // Change the primary color of the TimePicker
            hintColor:
                Colors.green, // Change the accent color of the TimePicker
            backgroundColor:
                Colors.white, // Change the background color of the TimePicker
            dialogBackgroundColor:
                Colors.grey[200], // Change the dialog background color
            textTheme: const TextTheme(
              headline1:
                  TextStyle(color: Colors.black), // Change the text color
              button:
                  TextStyle(color: Colors.red), // Change the button text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  @override
  void initState() {
    super.initState();

    //getting current location

    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  }

  _showSearchRides() {
    setState(() {
      isSearchPoPupVisible = true;
      bottomSheetVisible = false;
    });
  }

  _showMyRides() {
    setState(() {
      isSearchPoPupVisible = true;
      listSearchBottomSheet = false;
    });
  }

  showRide() {
    setState(() {
      ridesIsVisible = !ridesIsVisible;
    });
  }

  //slide moving

  bool _bottomSheetVisible = true; // Initial state of bottom sheet
  double _expandedHeight = 300;
  double _collapsedHeight = 150;

  void _toggleBottomSheetVisibility() {
    setState(() {
      _bottomSheetVisible = !_bottomSheetVisible;
    });
  }

  Widget _buildBottomSheet() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _bottomSheetVisible ? _collapsedHeight : _expandedHeight,
      child: GestureDetector(
        onTap: _toggleBottomSheetVisibility,
        child: Container(
          decoration: BoxDecoration(
            color: colorsFile.cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          child: SingleChildScrollView(
            child: WantToBook(
              "Your proposed rides",
              "Want to add a ride? Press + button!",
              _showSearchRides,
            ),
          ),
        ),
      ),
    );
  }

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
        toolbarHeight: 120.0,
        title: Container(
          color: colorsFile.background,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            isSearchPoPupVisible = false;
            listSearchBottomSheet = false;
            bottomSheetVisible = true;
            myRidesbottomSheetVisible = false;
          });
        },
        child: Stack(
          children: [
            // Background Photo
            Positioned(
              child: Container(
                child: MapsGoogleExample(),
              ),
            ),

//             Content on top of the background
//             Visibility(
//               visible: bottomSheetVisible,
//               child: Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: Container(
//                     height: 150,
//                     decoration: const BoxDecoration(
//                       color: colorsFile.cardColor,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(50.0),
//                         topRight: Radius.circular(50.0),
//                       ),
//                     ),
//                     child: SingleChildScrollView(
//                       // controller: scrollController,
//                       child: WantToBook(
//                           "Your proposed rides",
//                           "Want to add a ride? Press + button!",
//                           _showSearchRides),
//                     ),
//                   )),
//             ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomSheet(),
            ),


            Visibility(
              visible: isSearchPoPupVisible,
              child: Positioned(
                top: 20,
                right: _width / 2 * 0.15,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearchPoPupVisible = false;
                      bottomSheetVisible = true;
                    });
                  },
                  child: GlassmorphicContainer(
                    height: 220,
                    width: _width * 0.85,
                    borderRadius: 15,
                    blur: 2,
                    alignment: Alignment.center,
                    border: 2,
                    linearGradient: LinearGradient(
                      colors: [
                        const Color(0xFF003A5A).withOpacity(0.37),
                        const Color(0xFF003A5A).withOpacity(1),
                        const Color(0xFF003A5A).withOpacity(0.36),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderGradient: LinearGradient(
                      colors: [
                        const Color(0xFF003A5A).withOpacity(0.37),
                        const Color(0xFF003A5A).withOpacity(1),
                        const Color(0xFF003A5A).withOpacity(0.36),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 10, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _selectDateRange(
                                      context); // Call function to show date range picker
                                },
                                icon: const Icon(
                                    Icons.calendar_month), // Use calendar icon
                              ),
                              const SizedBox(width: 3.0),
                              TextButton(
                                onPressed: () => _selectTime(context),
                                child: Text(
                                  ' ${_selectedTime.hour}:${_selectedTime.minute}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              //Spacer(),
                              Container(
                                  child: RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, _) => Image.asset(
                                  'assets/images/seat.png', // Replace 'assets/star_image.png' with your image path
                                  width:
                                      10, // Adjust width and height as per your image size
                                  height: 10,
                                  color: colorsFile
                                      .done, // You can also apply color to the image if needed
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )),
                              //SizedBox(width: 15.0),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSearchPoPupVisible = false;
                                      bottomSheetVisible = true;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Color(0xFFFFFFFF), // White color
                                    size: 25.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: TextField(
                                          decoration: InputDecoration(
                                            hintText: "${origin_address_name}",
                                            prefixIcon: Container(
                                              width: 37.0,
                                              height: 37.0,
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 10),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  //Calling the map functions
                                                  print("Ontaped");
                                                  GoogleMapController?
                                                      map_controller;
                                                  google_map_for_origin(
                                                      map_controller);
                                                },
                                                child: const Icon(
                                                  Icons.place,
                                                  color: colorsFile.icons,
                                                ),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: const BorderSide(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                        )),
                                        const SizedBox(width: 5),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                              onTap: () {},
                                              child: const Center(
                                                child: Icon(
                                                  Icons.swap_vert,
                                                  color: Colors.white,
                                                  size: 35,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: TextField(
                                          decoration: InputDecoration(
                                            labelText:
                                                '${destination_address_name}',
                                            prefixIcon: Container(
                                              width: 37.0,
                                              height: 37.0,
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 10),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  GoogleMapController?
                                                      map_controller1;
                                                  google_map_for_origin1(
                                                      map_controller1);
                                                },
                                                child: const Icon(
                                                  Icons.place,
                                                  color: colorsFile.icons,
                                                ),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: const BorderSide(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                        )),
                                        const SizedBox(
                                            width:
                                                10), // Adjust the space between the two icons
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  listSearchBottomSheet = true;
                                                  isSearchPoPupVisible = false;
                                                });
                                              },
                                              child: Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white60,
                                                  ),
                                                  child: Center(
                                                    child: ClayContainer(
                                                      color: Colors.white,
                                                      height: 35,
                                                      width: 35,
                                                      borderRadius: 40,
                                                      curveType:
                                                          CurveType.concave,
                                                      depth: 30,
                                                      spread: 2,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.send,
                                                          color: colorsFile
                                                              .buttonIcons,
                                                        ),
                                                      ),
                                                    ),
                                                  ))),
                                        ), // Adjust the space between the two icons
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: listSearchBottomSheet,
              child: Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 350,
                    decoration: const BoxDecoration(
                      color: colorsFile.cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                        //controller: scrollController,
                        child: ProposedRides(_showMyRides, showRide)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
