import 'package:shared_preferences/shared_preferences.dart';


class sharedpreferences
{

  static  dynamic lat,lng ;


  static Future<void> setlat(double cu_lat) async {
    final prefs = await SharedPreferences.getInstance();
    if(cu_lat!=null){
    await prefs.setDouble("lat", cu_lat);}

  }

  static Future<dynamic?> getlat() async {
    print("Getting lat ${lat}");
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble("lat");

    }




  static Future<void> setlng(double cu_lng) async {
    final prefs = await SharedPreferences.getInstance();
    print("lat is ${cu_lng}");
    if(cu_lng!=null){
      await prefs.setDouble("lng", cu_lng);
    }

  }

  static Future<dynamic?> getlng() async {
    print("Getting lng ${lng}");
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("lng");
  }

}