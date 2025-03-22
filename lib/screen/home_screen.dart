import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Random random = Random();

  // Datos iniciales para la gráfica
  List<FlSpot> sleepData = [];

  // Horas de sueño en las tarjetas
  String bedtime = "11:15 PM";
  String wakeUp = "8:15 AM";

  // Lista de actividades posibles
  final List<String> activities = [
    "Deep Sleep",
    "Light Sleep",
    "REM Sleep",
    "Awake",
    "Short Nap",
  ];
  List<String> activityLog = [];

  @override
  void initState() {
    super.initState();
    _generateRandomData();
  }

  // Genera nuevos valores aleatorios para la gráfica y las tarjetas
  void _generateRandomData() {
    setState(() {
      // Actualizar la gráfica
      sleepData = List.generate(
          7, (index) => FlSpot(index.toDouble(), random.nextDouble() * 10));

      // Generar nuevas horas de sueño
      int bedtimeHour = random.nextInt(3) + 9; // Entre 9 PM y 11 PM
      int wakeUpHour = random.nextInt(3) + 6; // Entre 6 AM y 8 AM
      bedtime =
          "${bedtimeHour}:${random.nextInt(60).toString().padLeft(2, '0')} PM";
      wakeUp =
          "${wakeUpHour}:${random.nextInt(60).toString().padLeft(2, '0')} AM";

      // Generar actividades aleatorias
      activityLog = List.generate(
          5, (_) => activities[random.nextInt(activities.length)]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SleepDev'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tips_and_updates),
            onPressed: () {
              Navigator.pushNamed(context, '/sleep-tips');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen superior
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://plus.unsplash.com/premium_photo-1676166011970-bdea4f34674e?fm=jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Título y subtítulo
            const Text(
              "Sleep better, live better",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Track your sleep and get personalized insights.",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),

            // Gráfica de línea
            Container(
              height: 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: sleepData,
                      isCurved: true,
                      color: Colors.blueAccent,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Horario de sueño
            const Text(
              "Your Schedule",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _scheduleCard(Icons.bedtime, bedtime, "Bedtime"),
                _scheduleCard(Icons.alarm, wakeUp, "Wake up"),
              ],
            ),

            const SizedBox(height: 20),

            // Botón para mostrar detalles de actividad
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _showActivityLog,
              child: const Center(
                child: Text("Show All Health Data",
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button para refrescar los datos
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandomData,
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _scheduleCard(IconData icon, String time, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(height: 10),
            Text(time,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 5),
            Text(label,
                style: const TextStyle(fontSize: 14, color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  // Muestra un modal con las actividades detalladas
  void _showActivityLog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Activity Log",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 10),
              ...activityLog.map((activity) {
                return ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.redAccent),
                  title: Text(activity,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text(
                      "${random.nextInt(12) + 1}:${random.nextInt(60).toString().padLeft(2, '0')} AM",
                      style: const TextStyle(color: Colors.grey)),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
