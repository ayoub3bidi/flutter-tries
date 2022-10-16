import 'package:flutter/material.dart';
import 'package:flutter_tries/services/world_time.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';

  void setupWorldTime() async {  
    WorldTime instance = WorldTime(location: 'Tunis', flag: 'tunisia.png', uri: 'Africa/Tunis');
    await instance.getTime();
    setState(() {
      time = instance.time;
    });

  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text(time),
      ),
    );
  }
}