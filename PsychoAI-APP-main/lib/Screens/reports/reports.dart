import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:pdf/pdf.dart'; // For generating PDF
import 'package:pdf/widgets.dart' as pw; // PDF widgets
import 'package:printing/printing.dart'; // For saving PDF and printing
import 'package:psychoai/Components/CustomAppBar.dart';
import 'package:psychoai/common/db_functions.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  DateTimeRange? _selectedDateRange; // For time filtering
  List<String> _selectedSentiments = ["Very Happy", "Happy", "Normal", "Sad", "Very Sad"]; // Default selection

  // Mapping for sentiments to emojis
  final Map<String, String> sentimentEmoji = {
    "Very Happy": "😄",
    "Happy": "🙂",
    "Normal": "😐",
    "Sad": "🙁",
    "Very Sad": "😢",
  };

  // Mapping for sentiment index in the chart
  final Map<String, int> sentimentIndex = {
    "Very Sad": 0,
    "Sad": 1,
    "Normal": 2,
    "Happy": 3,
    "Very Happy": 4,
  };

  // Method to filter sentiments by selected time and type
  List<Map<String, dynamic>> _filterSentiments(List<Map<String, dynamic>> sentiments) {
    DateTimeRange range = _selectedDateRange ??
        DateTimeRange(start: DateTime(2000), end: DateTime.now().add( Duration(days:1))); // Default to a wide range

    return sentiments.where((sentiment) {

  // Remove the timezone part (e.g., 'UTC+3')

  // Define the DateFormat that matches the cleaned string
    String dateString = sentiment["timestamp"].replaceAll(' ', ' ');
    DateTime dateTime = DateTime.now();
    try{
    DateFormat dateFormat = DateFormat("MMMM d, yyyy 'at' hh:mm:ss a");
    dateTime = dateFormat.parse(dateString);
    }
    catch (e){
  // Format the DateTime object to include the full month name (MMMM)
  
  // Parse the string into a DateTime object
    dateTime = DateTime.parse(dateString); 
    }



      
      return range.start.isBefore(dateTime) &&
          range.end.isAfter(dateTime) &&
          _selectedSentiments.contains(sentiment["description"]);
    }).toList();
  }

  // Method to generate PDF
  Future<void> _generatePdf(List<Map<String, dynamic>> filteredSentiments) async {
    final pdf = pw.Document();
    final dateFormatter = DateFormat('yyyy-MM-dd');

    pdf.addPage(pw.Page(
      build: (context) => pw.Column(
        children: [
          pw.Text('Sentiment Report', style: pw.TextStyle(fontSize: 24)),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: ['Date', 'Sentiment'],
            data: filteredSentiments.map((sentiment) {
              return [
                dateFormatter.format(sentiment['timestamp'].toDate()),
                sentiment['description']
              ];
            }).toList(),
          ),
        ],
      ),
    ));

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    var dbFunctions = Provider.of<DBFunctions>(context);
    dbFunctions.fetchUserSentiments();
    if (dbFunctions.sentiments.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Reports')),
        body: Center(child: Text("Loading...")),
      );
    }

    // Filter sentiments
    List<Map<String, dynamic>> filteredSentiments = _filterSentiments(dbFunctions.sentiments!);

    return Scaffold(
      
      body: Padding(
        padding:  EdgeInsets.fromLTRB(16.0,16,16, 10.h),
        
        child: Column(
          children: [
            // Date Range Filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.date_range),
                  label: Text('Select Date Range'),
                  onPressed: () async {
                    DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDateRange = picked;
                      });
                    }
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.picture_as_pdf),
                  label: Text('Save as PDF'),
                  onPressed: () => _generatePdf(filteredSentiments),
                ),
              ],
            ),
            // Sentiment Filter
            Wrap(
              spacing: 10,
              children: sentimentIndex.keys.map((sentiment) {
                return FilterChip(
                  label: Text(sentiment),
                  selected: _selectedSentiments.contains(sentiment),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedSentiments.add(sentiment);
                      } else {
                        _selectedSentiments.remove(sentiment);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Display filtered sentiments
            Expanded(
              child: ListView.builder(
                itemCount: filteredSentiments.length,
                itemBuilder: (context, index) {
                  final sentiment = filteredSentiments[index];
                  String dateString = sentiment["timestamp"].replaceAll(' ', ' ');
                  DateFormat dateFormat = DateFormat("MMMM d, yyyy 'at' hh:mm:ss a");
                  DateTime dateTime = dateFormat.parse(dateString);
                  final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

                  return ListTile(
                    leading: Text(
                      sentimentEmoji[sentiment["description"]]!,
                      style: TextStyle(fontSize: 32),
                    ),
                    title: Text("Date: $formattedDate"),
                    subtitle: Text(sentiment["description"]),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

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
                  maxY: 10, // Adjust based on data
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 0:
                            return "Very Sad";
                          case 1:
                            return "Sad";
                          case 2:
                            return "Normal";
                          case 3:
                            return "Happy";
                          case 4:
                            return "Very Happy";
                          default:
                            return "";
                        }
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitles: (value) => value.toInt().toString(),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: sentimentIndex.entries.map((entry) {
                    String sentiment = entry.key;
                    int index = entry.value;
                    int count = filteredSentiments
                        .where((x) => x["description"] == sentiment)
                        .length;

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          y: count.toDouble(),
                          colors: [Colors.blueAccent],
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
