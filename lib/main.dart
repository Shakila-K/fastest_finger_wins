import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int red = 0;
  int blue = 0;
  bool start = false;
  int difference = 0;
  double heightUnit = 0;
  bool winnerSelected = false;
  int winner = 0; // 0 = no winner, 1 = red, 2 = blue

  void updateDifference(){
    setState(() {
      difference = red-blue;
    });
  }
  void getHeightUnit(){
    setState(() {
      heightUnit = MediaQuery.of(context).size.height / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(    // ),
      body: Stack(
        children:[ 
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/(2) + heightUnit * difference,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        if(start){
                          red++;
                        }
                        updateDifference();
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.red,
                      child: Center(child: Transform.rotate(
                        angle: -math.pi,
                        child: Center(child:  winnerSelected ? 
                                            winner == 1 ? const Text('Winner!') : winner == 2 ? null : const Text("TIE!") :
                                          !start ?
                                            const Text('TAP!') :
                                            Text(red.toString())
                                      )
                        )
                      )
                    ),
                  )
                  ),
                
                Expanded(child: GestureDetector(
                  onTap: (){
                    setState(() {
                      if(start){
                        blue++; 
                        updateDifference();
                      }
                     
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: Center(child:  winnerSelected ? 
                                            winner == 1 ? null : winner == 2 ? const Text('Winner!') : const Text("TIE!") :
                                          !start ?
                                            const Text('TAP!') :
                                            Text(blue.toString())
                                )
                                            
                    )
                  ),
                ),
              ],       
            ),
          ),
          //Start Icon
          Positioned(           
            child: Center(
              child: FloatingActionButton(
                onPressed: (){
                  if(!start){
                    setState(() {
                      red = 0;
                      blue = 0;
                      getHeightUnit();
                      start = !start;
                      Timer(const Duration(seconds: 5), (){
                        setState(() {
                          start = !start;
                          
                            if(red>blue){
                              winner = 1;}
                            else if(blue>red){
                              winner = 2;
                            }
                            else{
                              winner = 0;
                            }
                          
                          red=0;
                          blue=0;
                        });
                      });
                  });
                  }
                  
                },
                child: !start ? const Icon(Icons.play_arrow): null,
              ),
            )
          )
        ]
      ),
      ),
    );
  }
}