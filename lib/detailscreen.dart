import 'package:flutter/material.dart';
import 'package:trackerapp/worlstates.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalcase, totalill, todayrecoverd, active, critical, totalrecoverd, test;
  DetailScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.totalcase,
      required this.totalill,
      required this.totalrecoverd,
      required this.active,
      required this.critical,
      required this.todayrecoverd,
      required this.test
      });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.06,
                        ),
                     ReuseableRow(
                        title: 'cases', value: widget.totalcase.toString()),
                     ReuseableRow(
                        title: 'active', value: widget.active.toString()),
                     ReuseableRow(
                        title: 'recovered', value: widget.totalrecoverd.toString()),
                     ReuseableRow(
                        title: 'todayRecovered', value: widget.todayrecoverd.toString()),
                     ReuseableRow(
                        title: 'critical', value: widget.critical.toString()),
                     ReuseableRow(
                        title: 'totalRecovered', value: widget.totalrecoverd.toString()),
                     ReuseableRow(
                        title: 'tests', value: widget.test.toString()),
                     ReuseableRow(
                        title: 'deaths', value: widget.totalill.toString()),

                                      ],
                                    )),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
