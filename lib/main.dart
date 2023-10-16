// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pomodoro/graph.dart';
import 'package:pomodoro/list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';



void main() {
  runApp(const MaterialApp(
    home: MyHomepage(),
  ));
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<MyHomepage> {

  double _max = 0;

  bool bg = true;
  var minu = 0;
  var tens = 0;
  var sece = 9;
  bool start = false;
  var g = 1;
  var lap = 0;
  bool r = true;
  double z = 0;
  final audiop = AudioPlayer();
  
  

  late List<MyList> a = List.empty(growable: true);
  late SharedPreferences prefs;

  void plus() async{
    if(r== true){
      setState(() {
        lap = 1;
      });
    }

    Timer.periodic(const Duration(seconds: 1), (timer) { 
        if(start == false){
          timer.cancel();
        }else if(start){
          if(sece>0){
            setState(() {
              sece = sece-g;
            });
          }else{
            if(tens > 0){
              setState(() {
                tens = tens-g;
                sece=9;
              });
            }else{
              if (minu>0) {
                minu = minu-g;
                tens = 6;
              }else if(minu == 0&& tens==0&& sece==0){
                timer.cancel();
                playAudio();
                setState(() {
                  bg = !bg;
                  if (bg==true) {
                    minu = 0;
                    tens = 0;
                    sece = 9;
                    lap++;
                  }else if(bg == false){
                    minu = 0;
                    tens = 0;
                    sece = 9;
                  }
                });
                plus();
              }
            }
          }

        }
    });


  }

  playAudio() async{
    await AudioCache().play('beep.mp3');
  }

  @override
  void initState() {
    super.initState();
    getSharedprefrences();
  }



  getSharedprefrences() async{
   
    prefs = await SharedPreferences.getInstance();
      List<String>? aStringT = prefs.getStringList('list');
     
      if(aStringT != null){
        a = aStringT.map((at) => MyList.fromJson(json.decode(at))).toList();
      }

  }

  void load() async {
    
    setState(() {
      _max = ((prefs.getDouble('max') ?? 0)+1).roundToDouble();
      prefs.setDouble('max', _max);

     

      a.add(MyList(x: _max, y: lap.toDouble()));
    
      List<String> aString = a.map((at) => jsonEncode(at.toJson())).toList();
      prefs.setStringList('list', aString);
      
    });
  }
  


  @override
  Widget build(BuildContext context){
   return MaterialApp(
      home: Scaffold(
      body:Container(
      decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(0.8, 1),
            colors:   <Color>[
              if(bg)...[
              const Color(0xff1f005c),
              const Color(0xff5b0060),
              const Color(0xff870160),
              const Color(0xffac255e),
              const Color(0xffca485c),
              const Color(0xffe16b5c),
              const Color(0xfff39060),
              const Color(0xffffb56b),
            ]else...[
              const Color.fromARGB(255, 245, 183, 0),
              const Color.fromARGB(255, 210, 183, 0),
              const Color.fromARGB(255, 175, 183, 0),
              const Color.fromARGB(255, 140, 183, 0),
              const Color.fromARGB(255, 105, 183, 0),
              const Color.fromARGB(255, 70, 183, 0),
              const Color.fromARGB(255, 35, 183, 0),
              const Color.fromARGB(255, 0, 183, 0),
            ]
           ] ,// Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child:  Center(
         child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
           Text(
              '$minu:$tens$sece',
             style: const TextStyle(color: Colors.white, fontSize: 100),
              ),

            
            TextButton(         
              style: ButtonStyle(
                backgroundColor: null,
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(width: 3, color: Colors.white),
                  ),
                ),
              ),
              onPressed: () { 
                  plus();
                  if(r == true){
                    r = !r;
                   }
                  setState(() {
                    start = !start;
                  });

              },
              child: Text(
                start ? "STOP" : "START",
                ),
            ),
            
              lap > 0? Text(
              bg ? "SESSION $lap" : "PAUSE",
             style: const TextStyle(color: Colors.white, fontSize: 20),
              ): const Text('')
              ,

              TextButton(         
              style: ButtonStyle(
                backgroundColor: null,
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(width: 3, color: Colors.white),
                  ),
                ),
              ),
              onPressed: () { 
                if(lap != 0){
                  load();
                }
                
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return  Graph(
                      points: a,
                      max: _max
                      );
                  }));
                  start = false;
                  r = !r;

                  setState(() {
                    lap = 0;
                    minu = 0;
                    tens = 0;
                    sece = 9;
                    bg = true;
                  });
                  
              },
              child: const Text(
               'SEE STATS',
                ),
            ),
          ],
         )
        ),
      )
      )
    );
  }
 }


    // TODO: implement build
    



