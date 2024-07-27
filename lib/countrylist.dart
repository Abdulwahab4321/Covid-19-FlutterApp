import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trackerapp/services/state_service.dart';
import 'package:trackerapp/detailscreen.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateWorld stateWorld = StateWorld();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchcontroller,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: const  EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search countries names',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: stateWorld.countriesListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData){
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  subtitle:  Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if(searchcontroller.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    totalcase: snapshot.data![index]['cases'],
                                    todayrecoverd: snapshot.data![index]['todayRecovered'],
                                    totalill: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    totalrecoverd: snapshot.data![index]['recovered'],
                                    critical: snapshot.data![index]['critical'],

                                  )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()) ,
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                          }else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                           return InkWell(
                           onTap: () {
                             Navigator.push(context,
                                 MaterialPageRoute(builder: (context) =>
                                     DetailScreen(
                                       name: snapshot.data![index]['country'],
                                       image: snapshot.data![index]['countryInfo']['flag'],
                                       totalcase: snapshot.data![index]['cases'],
                                       todayrecoverd: snapshot.data![index]['todayRecovered'],
                                       totalill: snapshot.data![index]['deaths'],
                                       active: snapshot.data![index]['active'],
                                       test: snapshot.data![index]['tests'],
                                       totalrecoverd: snapshot.data![index]['recovered'],
                                       critical: snapshot.data![index]['critical'],

                                     )));
                           },
                             child: Column(
                               children: [
                                 ListTile(
                                   title: Text(snapshot.data![index]['country']),
                                   subtitle: Text(snapshot.data![index]['cases'].toString()) ,
                                   leading: Image(
                                     height: 50,
                                     width: 50,
                                     image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                   ),
                                 )
                               ],
                             ),
                           );
                          }else{
                            return Container();
                          }
                        },
                      );
                    }
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}
