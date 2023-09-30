import 'package:cryptoapp/models/coins_models.dart';
import 'package:cryptoapp/utils/item2.dart';
import 'package:cryptoapp/utils/items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: myheight,
      width: mywidth,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
            // Color.fromARGB(255, 253, 225, 112),
            // Color(0xfffcb700),
            Color(0xff33343c),
            Color(0xff33343c),
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: myheight * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: mywidth * 0.02, vertical: myheight * 0.005),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Main Portfolio',
                    style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                  ),
                ),
                Text(
                  'Top 10 coins',
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                ),
                Text(
                  'Exprimental',
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mywidth * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ 8,945.30',
                  style: GoogleFonts.lato(fontSize: 30, color: Colors.white),
                ),
                Container(
                  padding: EdgeInsets.all(mywidth * 0.02),
                  height: myheight * 0.05,
                  width: mywidth * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.6),
                  ),
                  child: Image.asset('assets/icons/5.1.png'),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mywidth * 0.07),
            child: Row(
              children: [
                Text(
                  '+162% all time',
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: myheight * 0.01,
          ),
          Container(
            height: myheight * 0.7,
            width: mywidth,
            decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //     blurRadius: 5,
                //     color: Colors.grey.shade300,
                //     spreadRadius: 3,
                //     offset: Offset(0, 3),
                //   )
                // ],
                color: Color(0xff454651),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              children: [
                SizedBox(height: myheight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mywidth * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Assets',
                        style:
                            GoogleFonts.lato(fontSize: 20, color: Colors.white),
                      ),
                      Icon(Icons.add, color: Colors.white),
                    ],
                  ),
                ),
                SizedBox(height: myheight * 0.01),
                Container(
                  height: myheight * 0.43,
                  child: isRefreshing == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        )
                      : coinsMarket == null || coinsMarket!.length == 0
                          ? Padding(
                              padding: EdgeInsets.all(myheight * 0.06),
                              child: Center(
                                child: Text(
                                  'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: 4,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Items(
                                  item: coinsMarket![index],
                                );
                              }),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mywidth * 0.05),
                  child: Row(
                    children: [
                      Text(
                        "Recommend to Buy",
                        style: GoogleFonts.lato(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: myheight * 0.01,
                // ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: mywidth * 0.03),
                    child: isRefreshing == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          )
                        : coinsMarket == null || coinsMarket!.length == 0
                            ? Padding(
                                padding: EdgeInsets.all(myheight * 0.06),
                                child: Center(
                                  child: Text(
                                    'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: coinsMarket!.length,
                                itemBuilder: (context, index) {
                                  return Item2(
                                    item: coinsMarket![index],
                                  );
                                }),
                  ),
                ),
                // SizedBox(
                //   height: myheight * 0.01,
                // ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  bool isRefreshing = true;

  List? coinsMarket = [];
  var coinsMarketlist;
  Future<List<CoinModel>?> getCoins() async {
    final endpoint =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';
    setState(() {
      isRefreshing = true;
    });
    var response = await http.get(Uri.parse(endpoint), headers: {
      "Content-Type": "application/json",
      "Accep": "application/json",
    });
    setState(() {
      isRefreshing = false;
    });
    if (response.statusCode == 200) {
      var data = response.body;
      coinsMarketlist = coinModelFromJson(data);
      setState(() {
        coinsMarket = coinsMarketlist;
      });
    } else {
      throw ('Something went wrong');
    }
  }
}
