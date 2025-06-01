import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:psychoai/Components/CustomAppBar.dart';
import 'package:psychoai/common/db_functions.dart';
import 'package:sizer/sizer.dart';

class SyntimentsProgressPage extends StatefulWidget {
  @override
  _SyntimentsProgressPageState createState() => _SyntimentsProgressPageState();
}

class _SyntimentsProgressPageState extends State<SyntimentsProgressPage> {

  List<Map<String, dynamic>>? dailySentiments = null;
  int firstrun = 0;
      final GlobalKey<CustomAppBarState> _appBarKey = GlobalKey<CustomAppBarState>();
  // Example data

  // Sentiment to emoji and color mapping
  final Map<String, String> sentimentEmoji = {
    "Very Happy": "😄",
    "Happy": "🙂",
    "Normal": "😐",
    "Sad": "🙁",
    "Very Sad": "😢"
  };

  // Sentiment to chart data index
  final Map<String, int> sentimentIndex = {
    "Very Sad": 0,
    "Sad": 1,
    "Normal": 2,
    "Happy": 3,
    "Very Happy": 4,
  };



  @override
  Widget build(BuildContext context) {

    var dbFunctions = Provider.of<DBFunctions>(context);
    if (firstrun==0){
    dbFunctions.fetchUserSentiments();
    setState(() {
      firstrun =1;
    });
    }

      // Example data for how many times the user felt each sentiment
  final Map<String, int> sentimentCount = {
    "Very Happy":  dbFunctions.sentiments.where((x)=> x["description"]== "Very Happy").length,
    "Happy": dbFunctions.sentiments.where((x)=> x["description"]== "Happy").length,
    "Normal": dbFunctions.sentiments.where((x)=> x["description"]== "Normal").length,
    "Sad": dbFunctions.sentiments.where((x)=> x["description"]== "Sad").length,
    "Very Sad": dbFunctions.sentiments.where((x)=> x["description"]== "Very Sad").length,
  };

    return dbFunctions.sentiments.isEmpty ? Center(child: Text("Loading"),): Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Adjust size if needed
        child: CustomAppBar(key: _appBarKey), // Assign GlobalKey to the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Daily Sentiments with Emojis and Scores
            Expanded(
              child: ListView.builder(
                itemCount: dbFunctions.sentiments!.length,
                itemBuilder: (context, index) {
                  final dailyData = dbFunctions.sentiments![index];
                  final date = dailyData["timestamp"];
                  final sentiment = dailyData["description"];

                  return ListTile(
                    leading: Text(
                      sentimentEmoji[sentiment]!,
                      style: TextStyle(fontSize: 32),
                    ),
                    title: Text(
                      "Date: $date",
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      dailyData["description"],
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // Chart for Sentiment Frequency
            Text(
              "Sentiment Frequency",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40.h,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10, // You can adjust based on your data
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                        showTitles: true,
                        getTitles: (value) {
                          switch (value.toInt()) {
                            case 0:
                              return ("Very Sad");
                            case 1:
                              return ("Sad");
                            case 2:
                              return ("Normal");
                            case 3:
                              return ("Happy");
                            case 4:
                              return ("Very Happy");
                            default:
                              return ("");
                          }
                        },
                      
                    ),
                    leftTitles:  SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitles:  (value) {
                          return value.toInt().toString();
                        },
                      
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: sentimentIndex.entries.map((entry) {
                    String sentiment = entry.key;
                    int index = entry.value;

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          y: sentimentCount[sentiment]!.toDouble(),
                          colors:[ Colors.blueAccent],
                          width: 22, 
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
