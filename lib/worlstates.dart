

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:trackerapp/countrylist.dart';
import 'package:trackerapp/models/WorldStateModel.dart';
import 'package:trackerapp/services/state_service.dart';
class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync:this
  )..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final color = <Color>[
    Colors.blue,
    Colors.green,
    Colors.red

  ];


  @override
  Widget build(BuildContext context) {
    StateWorld stateWorld = StateWorld();
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01,),
              FutureBuilder(
                  future: stateWorld.fetchDataFromApi(),
                  builder: (context, AsyncSnapshot<WorldStateModel> snapshot)  {
                   if (!snapshot.hasData){
                     print('error');
                     return Expanded(
                       flex: 1,
                         child: SpinKitFadingCircle(
                           color: Colors.white,
                           size: 50.0,
                           controller: _controller,
                         )
                     );
                   }else{
                     return Column(
                       children: [
                         PieChart(
                           dataMap:   {
                            'total':double.parse(snapshot.data!.cases.toString()),
                             'recovery':double.parse(snapshot.data!.recovered.toString()),
                             'ill':double.parse(snapshot.data!.deaths.toString())
                           },
                           chartValuesOptions: const ChartValuesOptions(
                             showChartValuesInPercentage: true
                           ),
                           chartRadius: MediaQuery.of(context).size.width/3.2,
                           animationDuration: const Duration(milliseconds: 1200),
                           legendOptions: const LegendOptions(
                               legendPosition: LegendPosition.left
                           ),
                           colorList:color,
                           chartType: ChartType.ring,
                         ),
                         Padding(
                           padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                           child: Card(
                             child: Column(
                               children: [
                                 ReuseableRow(title:'Cases' ,value: snapshot.data!.cases.toString(),),
                                 ReuseableRow(title:'Ill' ,value: snapshot.data!.deaths.toString(),),
                                 ReuseableRow(title:'Recovered' ,value: snapshot.data!.recovered.toString(),),
                                 ReuseableRow(title:'Active' ,value: snapshot.data!.active.toString(),),
                                 ReuseableRow(title:'Critical' ,value: snapshot.data!.critical.toString(),),
                                 ReuseableRow(title:'Today ill' ,value: snapshot.data!.todayDeaths.toString(),),
                                 ReuseableRow(title:'Today recovery' ,value: snapshot.data!.todayRecovered.toString(),),


                               ],
                             ),
                           ),
                         ),
                         GestureDetector(
                           onTap : (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => CountryListScreen(),));
                           },
                           child: Container(
                             height: 50,
                             decoration: BoxDecoration(
                                 color: Colors.green,
                                 borderRadius: BorderRadius.circular(10)
                             ),
                             child: const Center(child: Text('Track countries')),
                           ),
                         )
                       ],
                     );
                   }
                  },
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class ReuseableRow extends StatelessWidget {
  String title,value;
   ReuseableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),

            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
