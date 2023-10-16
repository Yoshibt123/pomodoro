import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


// ignore: must_be_immutable
class Graph extends StatelessWidget {
  final List points;
  double max;

   Graph({required this.points,required this.max,super.key});
   
    double  x = 0;

    add(){
     
      for(int i = 0; points.length>i;i++){
        x = x+points[i].x;
      }
      x=x/points.length;
    }

    
    void initState() {
      add();
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body:Container(
      decoration:  const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors:   <Color>[
              
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            
            ]// Gradient from https://learnui.design/tools/gradient-generator.html
            
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
        Container(
          margin: const EdgeInsets.all(24),
         child:AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        
        LineChartData(
          
            lineBarsData: [
              LineChartBarData(
                spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
                isCurved: true,
                color: const Color.fromRGBO(255, 255, 255, 0.655),
                
                dotData:
                 const FlDotData(
                  show: true,
                  
                ),
                // dotData: FlDotData(
                //   show: false,
                // ),
              ),
            ],
              
            borderData: FlBorderData(
                border:  const Border(bottom: BorderSide(width: 6.0, color: Colors.white), left: BorderSide(width: 6.0, color: Colors.white))),
                
            gridData: const FlGridData(show: true),
            titlesData: const FlTitlesData(
              bottomTitles: AxisTitles(sideTitles:SideTitles(showTitles: true)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
             
              
              
            ),
        
      
          ),
      ),

      
    ),
        ),

        Text(
              '$x',
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
                  Navigator.pop(context);
              },
              child: const Text(
               'SEE STATS',
                ),
            ),
          ]
          ), 
        ),
      ),
      ),
    );
  }
}
