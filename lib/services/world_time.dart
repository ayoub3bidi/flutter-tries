import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  String location = ''; // ? location name for the UI
  String time = ''; // ? the time in that location
  String flag = ''; // ? url to an asset icon
  String uri = ''; // ? location url for api endopoint 

  WorldTime({  required this.location,  required this.flag,  required this.uri });

  Future<void> getTime () async {
    // ? making the request
    Response response = await get (Uri.parse('http://worldtimeapi.org/api/timezone/$uri'));
    Map data = jsonDecode(response.body);
    // print (data);

    // ? getting properties from data 
    String datetime = data['datetime'];
    String offset = data ['utc_offset'].substring(1, 3);
    // print(datetime);
    // print(offset);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    time = now.toString();
  }

}