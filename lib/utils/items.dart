import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Items extends StatelessWidget {
  var item;

  Items({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;

    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mywidth * 0.05, vertical: myheight * 0.02),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: myheight * 0.06,
                child: Image.network(item.image),
              ),
            ),
            SizedBox(
              width: mywidth * 0.02,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.id,
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    '0.4 ' + item.symbol,
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              width: mywidth * 0.01,
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: myheight * 0.05,
                // width: mywidth * 0.2,
                child: Sparkline(
                    data: item.sparklineIn7D.price,
                    lineWidth: 2.0,
                    lineColor: item.marketCapChangePercentage24H >= 0
                        ? Colors.green
                        : Colors.red,
                    fillMode: FillMode.below,
                    fillGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.7],
                        colors: item.marketCapChangePercentage24H >= 0
                            ? [
                                Colors.green,
                                //Colors.green.shade100
                                Color(0xff454651),
                              ]
                            : [
                                Colors.red,
                                Color(0xff454651)
                                //  Colors.red.shade100
                              ])),
              ),
            ),
            SizedBox(
              width: mywidth * 0.03,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$ ' + item.currentPrice.toStringAsFixed(2),
                    style: GoogleFonts.lato(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Row(
                    children: [
                      Text(
                        item.priceChange24H.toString().contains('-')
                            ? '-\$' +
                                item.priceChange24H
                                    .toStringAsFixed(2)
                                    .toString()
                                    .replaceAll('-', '')
                            : '\$' + item.priceChange24H.toStringAsFixed(2),
                        style: GoogleFonts.lato(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: mywidth * 0.01,
                      ),
                      Text(
                        item.marketCapChangePercentage24H.toStringAsFixed(2) +
                            '%',
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: item.marketCapChangePercentage24H >= 0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
