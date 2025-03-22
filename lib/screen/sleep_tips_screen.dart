import 'package:flutter/material.dart';

class SleepTipsScreen extends StatelessWidget {
  const SleepTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sleep Tips"),
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
            const Text(
              "You're sleeping better than 80% of people your age",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Lista de tips
            Expanded(
              child: ListView(
                children: const [
                  SleepTipItem(title: "Just get in bed"),
                  SleepTipItem(title: "Limit screen time"),
                  SleepTipItem(title: "Avoid caffeine"),
                  SleepTipItem(title: "Go to bed at the same time every day"),
                  SleepTipItem(title: "Create a bedtime routine"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Botón para ver más tips
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Acción para ver más tips
                },
                child:
                    const Text("Show All Tips", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para cada item de la lista de tips
class SleepTipItem extends StatelessWidget {
  final String title;
  const SleepTipItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(fontSize: 16, color: Colors.white)),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 18),
      onTap: () {
        // Acción cuando se toca un tip (puede abrir detalles)
      },
    );
  }
}
