import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FlSpot> generateRandomData() {
    final random = Random();
    return List.generate(
        7, (index) => FlSpot(index.toDouble(), random.nextDouble() * 10));
  }

  void _showActivityDetails() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 300,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text("Sleep Activity Details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text("Deep Sleep",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("00:00 - 02:30",
                    style: TextStyle(color: Colors.white70)),
              ),
              ListTile(
                leading:
                    const Icon(Icons.favorite_border, color: Colors.redAccent),
                title: const Text("Light Sleep",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("02:30 - 05:00",
                    style: TextStyle(color: Colors.white70)),
              ),
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.pink),
                title: const Text("REM Sleep",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("05:00 - 07:00",
                    style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        );
      },
    );
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
                      "https://plus.unsplash.com/premium_photo-1676166011970-bdea4f34674e?fm=jpg"), // Asegúrate de agregar esta imagen
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
                      spots: generateRandomData(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            //more information
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/sleep-detail');
              },
              child: const Text(
                "Ver datelle",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),

            // Horario de sueño
            const Text(
              "Your Schedule",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _scheduleCard(Icons.bedtime, "11:15 PM", "Bedtime"),
                _scheduleCard(Icons.alarm, "8:15 AM", "Wake up"),
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
              onPressed: _showActivityDetails,
              child: const Center(
                child: Text("Show All Health Data",
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
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
}
