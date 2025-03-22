import 'package:flutter/material.dart';
import 'dart:math';

class SleepDetailScreen extends StatefulWidget {
  const SleepDetailScreen({super.key});

  @override
  _SleepDetailScreenState createState() => _SleepDetailScreenState();
}

class _SleepDetailScreenState extends State<SleepDetailScreen> {
  String selectedRange = "W"; // Valor inicial seleccionado (Semana)
  final Random random = Random();

  // Datos simulados de horas de sueño (se actualizan dinámicamente)
  Map<String, double> sleepData = {
    "M": 6.0,
    "T": 4.5,
    "W": 3.2,
    "T": 3.8,
    "F": 7.5,
  };

  // Función para actualizar dinámicamente las horas de sueño en cada tap
  void updateSleepData(String day) {
    setState(() {
      sleepData[day] =
          3 + random.nextDouble() * 6; // Rango aleatorio entre 3 y 9 horas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sleep"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selector de tiempo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["D", "W", "M", "6M"].map((range) {
                return ChoiceChip(
                  label: Text(range),
                  selected: selectedRange == range,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedRange = range;
                    });
                  },
                  selectedColor: Colors.blueAccent,
                  backgroundColor: Colors.grey[800],
                  labelStyle: TextStyle(
                    color: selectedRange == range
                        ? Colors.white
                        : Colors.grey[400],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Título y tiempo en cama
            const Text("Time in bed",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text("7hr31min",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text("Past week",
                style: TextStyle(fontSize: 16, color: Colors.grey)),

            const SizedBox(height: 20),

            // Gráfico de barras interactivo
            Expanded(
              child: Column(
                children: sleepData.keys.map((day) {
                  return GestureDetector(
                    onTap: () =>
                        updateSleepData(day), // Cambia el ancho en cada tap
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 20,
                              child: Text(day,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white))),
                          Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              height: 12,
                              width: sleepData[day]! * 30, // Ancho dinámico
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),

      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Summary"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Sharing"),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_walk), label: "Browse"),
        ],
      ),
    );
  }
}
