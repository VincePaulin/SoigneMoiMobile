import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('Nom du docteur'),
              Spacer(),
              //Icon(Icons.logo),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Date d\'aujourd\'hui: ${DateTime.now().toString().split(' ')[0]}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4, // Raising for shadow effect
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
      ),
    );
  }
}
