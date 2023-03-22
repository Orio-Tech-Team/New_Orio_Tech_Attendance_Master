import 'dart:async';
import 'dart:convert';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

import '../../Controller/Attendance Controller/attendance_controller.dart';
import '../../Models/station_model.dart';
import '../../Screens/Home Screen/home_screen.dart';
import '../../Widgets/Button/button.dart';
import '../../Widgets/Button/outline_button.dart';
import '../Colors/color_resource.dart';
class LocationDialoug extends StatefulWidget {
  const LocationDialoug({Key? key}) : super(key: key);

  @override
  State<LocationDialoug> createState() => _LocationDialougState();
}

class _LocationDialougState extends State<LocationDialoug> {
  int select = 0;
  StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  final box = GetStorage();
  StationModel? stationModel;
  List<Datum>? finalData;
  List<dynamic>? stationData;

@override
  void initState() {
  var result = box.read('data');
  dynamic jsonData = jsonDecode(result);
  stationData = jsonData.map((payment) => Datum.fromJson(payment)).toList();
  finalData = stationData!.cast<Datum>();
    // TODO: implement initState
    super.initState();
  }
  void Start()async{
    String? stationLatitude;
    String? stationLongitude;
    var locationStatus;
    var stationRadius;

    if(isInRange.value == false){
      //EasyGeofencing.stopGeofenceService();
      stationLatitude = finalData![0].employeeStation[select].station.latitude;
      stationLongitude = finalData![0].employeeStation[select].station.longtitude;
      stationRadius =
          finalData![0].employeeStation[select].station.radius;
      try{
        EasyGeofencing.startGeofenceService(
          pointedLatitude: stationLatitude,
          pointedLongitude: stationLongitude,
          radiusMeter: stationRadius.toString(),
          eventPeriodInSeconds: 0,
        );
        geofenceStatusStream ??= EasyGeofencing.getGeofenceStream()!
            .listen((GeofenceStatus status) async{
          var location = Location();
          bool enabled = await location.serviceEnabled();
          if(enabled == true){
            try{
              locationStatus = status.toString();
              if(locationStatus == "GeofenceStatus.enter"){
                isInRange.value = true;
              }else if(locationStatus == "GeofenceStatus.init"){
                isInRange.value = false;
              }else{
                isInRange.value = false;
              }
            }catch(e){
              isInRange.value = false;
            }
          }else{
            isInRange.value = false;
          }
        });
      }catch(e){
        isInRange.value = false;
      }
    }else{
      isInRange.value = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
        content: SizedBox(
          height: 370,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 99, 9)
                      .withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  size: 60,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Select Location',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              const Text(
                'Select your location where you want to check-in Or check-out.',
                style: TextStyle(
                  color: Color(0xFF6E6E6E),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: (){
                            setState(() {
                              select = index;
                            });
                          },
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${index + 1}- "),
                               Text(finalData![0].employeeStation[index].station.stationName),
                              const Spacer(),
                              Container(
                                height: 20,
                                width: 20,
                                //margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    color: select == index ? kPrimaryColor:Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: select == index ? kPrimaryColor:Colors.grey,width: 1)
                                ),
                                child: Container(
                                  height: 10,
                                  width: 10,

                                  decoration: BoxDecoration(
                                    color: select == index ? Colors.white:kPrimaryColor,
                                    borderRadius: BorderRadius.circular(30),
                                    //border: Border.all(color: Colors.grey)
                                  ),
                                  /*margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)
                                ),*/
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  /*Expanded(
                    flex: 1,
                    child: OutlineButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),*/
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: Button(
                        onPressed: ()async{
                          Start();
                          Get.offAllNamed(HomeScreen.routeName);
                        },
                        child: const Text("Select")),
                  )
                ],
              )
            ],
          ),
        ),
    ),
      );
  }
}
/*

AlertDialog locationDialoug(){
  int select = 0;
  return AlertDialog(
    content: SizedBox(
      height: 370,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 99, 9)
                  .withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_on_outlined,
              size: 60,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Select Location',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25.0,
            ),
          ),
          const SizedBox(
            height: 5,
          ),

          const Text(
            'Select your location where you want to check-in Or check-out',
            style: TextStyle(
              color: Color(0xFF6E6E6E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: (){
                        print(index);
                        select = index;
                        print(index);
                      },
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${index + 1}- "),
                         const Text("Hamza"),
                         const Spacer(),
                          Container(
                            height: 20,
                            width: 20,
                            //margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: select == index ? kPrimaryColor:Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: select == index ? kPrimaryColor:Colors.grey,width: 1)
                            ),
                            child: Container(
                              height: 10,
                              width: 10,

                              decoration: BoxDecoration(
                                color: select == index ? Colors.white:kPrimaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                  //border: Border.all(color: Colors.grey)
                              ),
                              */
/*margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),*//*

                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: OutlineButton(
                    child: const Text("cancel"),
                    onPressed: () {
                     // Navigator.of(context).pop();
                    }),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 1,
                child: Button(
                    onPressed: ()async{

                    },
                    child: const Text("Logout")),
              )
            ],
          )
        ],
      ),
    ),
  );
}*/
