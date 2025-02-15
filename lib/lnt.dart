import 'package:flutter/material.dart';

void main() {
  runApp(FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, int> stepsData = {};
  final Map<String, double> waterData = {};

  void addSteps(String date, int steps) {
    setState(() {
      stepsData[date] = steps;
    });
  }

  void addWater(String date, double water) {
    setState(() {
      waterData[date] = water;
    });
  }

  String getStepsCategory(int steps) {
    if (steps < 4000) return 'Bad';
    if (steps <= 8000) return 'Average';
    return 'Good';
  }

  String getWaterCategory(double water) {
    if (water < 1.5) return 'Bad';
    if (water <= 2.0) return 'Average';
    return 'Good';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fitness Tracker')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StepsTrackerScreen(
                    stepsData: stepsData,
                    addSteps: addSteps,
                  ),
                ),
              );
            },
            child: Text('Steps Tracker'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WaterIntakeScreen(
                    waterData: waterData,
                    addWater: addWater,
                  ),
                ),
              );
            },
            child: Text('Water Intake Tracker'),
          ),
        ],
      ),
    );
  }
}

class StepsTrackerScreen extends StatefulWidget {
  final Map<String, int> stepsData;
  final Function(String, int) addSteps;

  StepsTrackerScreen({required this.stepsData, required this.addSteps});

  @override
  _StepsTrackerScreenState createState() => _StepsTrackerScreenState();
}

class _StepsTrackerScreenState extends State<StepsTrackerScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Steps Tracker')),
      body: Column(
        children: [
          TextField(
              controller: _dateController,
              decoration:
                  InputDecoration(labelText: 'Enter Date (YYYY-MM-DD)')),
          TextField(
              controller: _stepsController,
              decoration: InputDecoration(labelText: 'Enter Steps'),
              keyboardType: TextInputType.number),
          ElevatedButton(
            onPressed: () {
              String date = _dateController.text;
              int steps = int.tryParse(_stepsController.text) ?? 0;
              if (!widget.stepsData.containsKey(date)) {
                widget.addSteps(date, steps);
              }
            },
            child: Text('Add Steps'),
          ),
          Expanded(
            child: ListView(
              children: widget.stepsData.entries.map((entry) {
                return ListTile(
                  title: Text(
                      '${entry.key}: ${entry.value} steps - ${getStepsCategory(entry.value)}'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class WaterIntakeScreen extends StatefulWidget {
  final Map<String, double> waterData;
  final Function(String, double) addWater;

  WaterIntakeScreen({required this.waterData, required this.addWater});

  @override
  _WaterIntakeScreenState createState() => _WaterIntakeScreenState();
}

class _WaterIntakeScreenState extends State<WaterIntakeScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Water Intake Tracker')),
      body: Column(
        children: [
          TextField(
              controller: _dateController,
              decoration:
                  InputDecoration(labelText: 'Enter Date (YYYY-MM-DD)')),
          TextField(
              controller: _waterController,
              decoration: InputDecoration(labelText: 'Enter Water Intake (L)'),
              keyboardType: TextInputType.number),
          ElevatedButton(
            onPressed: () {
              String date = _dateController.text;
              double water = double.tryParse(_waterController.text) ?? 0.0;
              if (!widget.waterData.containsKey(date)) {
                widget.addWater(date, water);
              }
            },
            child: Text('Add Water Intake'),
          ),
          Expanded(
            child: ListView(
              children: widget.waterData.entries.map((entry) {
                return ListTile(
                  title: Text(
                      '${entry.key}: ${entry.value} L - ${getWaterCategory(entry.value)}'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
