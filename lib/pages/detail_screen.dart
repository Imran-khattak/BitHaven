import 'dart:convert';

import 'package:cryptoapp/models/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailsPage extends StatefulWidget {
  var selectItem;
  DetailsPage({super.key, this.selectItem});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late TrackballBehavior trackballBehavior;
  @override
  void initState() {
    getChart();
    print("chart");
    print(itemChart);
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Container(
          height: myheight,
          width: mywidth,
          color: Color(0xff33343c),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mywidth * 0.05, vertical: myheight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: myheight * 0.08,
                            child: Image.network(widget.selectItem.image)),
                        SizedBox(
                          width: mywidth * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectItem.id,
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              widget.selectItem.symbol,
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$ ' +
                              widget.selectItem.currentPrice.toStringAsFixed(2),
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          widget.selectItem.marketCapChangePercentage24H
                                  .toStringAsFixed(2) +
                              '%',
                          style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: widget.selectItem
                                          .marketCapChangePercentage24H >=
                                      0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
              Expanded(
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mywidth * 0.03, vertical: myheight * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Low ',
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            Text(
                              '\$ ' +
                                  widget.selectItem.low24H.toStringAsFixed(2),
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'High ',
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            Text(
                              '\$ ' +
                                  widget.selectItem.high24H.toStringAsFixed(2),
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Vol ',
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            Text(
                              '\$ ' +
                                  widget.selectItem.totalVolume
                                      .toStringAsFixed(2) +
                                  'M',
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myheight * 0.015,
                  ),
                  Container(
                      height: myheight * 0.4,
                      width: mywidth,
                      //color: Colors.amber,
                      child: isRefresh == true
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            )
                          : itemChart == null
                              ? Padding(
                                  padding: EdgeInsets.all(myheight * 0.06),
                                  child: Center(
                                    child: Text(
                                      'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                      style: GoogleFonts.lato(
                                          fontSize: 18,
                                          color: Colors.white.withOpacity(0.3)),
                                    ),
                                  ),
                                )
                              : SfCartesianChart(
                                  trackballBehavior: trackballBehavior,
                                  zoomPanBehavior: ZoomPanBehavior(
                                      enablePinching: true,
                                      zoomMode: ZoomMode.x),
                                  series: <CandleSeries>[
                                      CandleSeries<ChartModel, int>(
                                          enableSolidCandles: true,
                                          enableTooltip: true,
                                          bullColor: Colors.green,
                                          bearColor: Colors.red,
                                          dataSource: itemChart!,
                                          xValueMapper: (ChartModel sales, _) =>
                                              sales.time,
                                          lowValueMapper:
                                              (ChartModel sales, _) =>
                                                  sales.low,
                                          highValueMapper:
                                              (ChartModel sales, _) =>
                                                  sales.high,
                                          openValueMapper:
                                              (ChartModel sales, _) =>
                                                  sales.open,
                                          closeValueMapper:
                                              (ChartModel sales, _) =>
                                                  sales.close,
                                          animationDuration: 55)
                                    ])),
                  SizedBox(
                    height: myheight * 0.01,
                  ),
                  Center(
                    child: Container(
                      height: myheight * 0.04,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: text.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: mywidth * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  textBool = [
                                    false,
                                    false,
                                    false,
                                    false,
                                    false
                                  ];
                                  textBool[index] = true;
                                });
                                setDays(text[index]);
                                getChart();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mywidth * 0.03,
                                    vertical: myheight * 0.005),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: textBool[index] == true
                                      ? Colors.white.withOpacity(0.3)
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  text[index],
                                  style: GoogleFonts.lato(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: myheight * 0.04,
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: mywidth * 0.06),
                        child: Text(
                          'News',
                          style: GoogleFonts.lato(
                              fontSize: 25, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mywidth * 0.06,
                            vertical: myheight * 0.01),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.lato(
                                    color: Colors.grey, fontSize: 17),
                              ),
                            ),
                            Container(
                              width: mywidth * 0.25,
                              child: CircleAvatar(
                                radius: myheight * 0.043,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: myheight * 0.04,
                                  backgroundImage: NetworkImage(
                                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              )),
              Container(
                height: myheight * 0.1,
                width: mywidth,
                child: Column(
                  children: [
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: myheight * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: mywidth * 0.05,
                        ),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: myheight * 0.015),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white.withOpacity(0.4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: Colors.white),
                                  Text(
                                    'add to portfolio',
                                    style: GoogleFonts.lato(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: mywidth * 0.05,
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: myheight * 0.013),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white.withOpacity(0.4),
                              ),
                              child: Image.asset(
                                'assets/icons/3.1.png',
                                height: myheight * 0.03,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    ));
  }

  List<String> text = ["D", "M", "3M", "6M", "Y"];
  List<bool> textBool = [false, false, false, false, false];

  bool isRefresh = true;
  List<ChartModel>? itemChart;

  int days = 0;

  setDays(String txt) {
    if (txt == "D") {
      days = 1;
    } else if (txt == "W") {
      days = 7;
    } else if (txt == "M") {
      days = 30;
    } else if (txt == "3M") {
      days = 90;
    } else if (txt == "6M") {
      days = 180;
    } else if (txt == "Y") {
      days = 365;
    }
  }

  Future<void> getChart() async {
    String url = "https://api.coingecko.com/api/v3/coins/" +
        widget.selectItem.id +
        "/ohlc?vs_currency=usd&days=" +
        days.toString();

    setState(() {
      isRefresh = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      isRefresh = false;
    });
    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
