import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importez la bibliothèque intl

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Format de la date
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Text('Nom du docteur'),
              Spacer(),
              //Icon(Icons.logo),
            ],
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(120),
                    topRight: Radius.circular(120),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Aujourd'hui",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4, // Raising for shadow effect
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text('Titre de la tuile $index'),
                          subtitle: Text('Sous-titre de la tuile $index'),
                          leading: const Icon(Icons.circle),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Action to be taken when the ListTile is clicked
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
