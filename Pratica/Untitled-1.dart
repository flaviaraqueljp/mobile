import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viagens',
      home: const ViagensPage(),
    );
  }
}

class ViagensPage extends StatelessWidget {
  const ViagensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Viagens"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // FOTO PRINCIPAL
            Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  left: 15,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Roma",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Coliseu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 15),

            // MENU DE AÇÕES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [

                MenuIcone(
                  icone: Icons.flight_takeoff,
                  texto: "Quero Ir",
                ),

                MenuIcone(
                  icone: Icons.location_on,
                  texto: "Já Fui",
                ),

                MenuIcone(
                  icone: Icons.share,
                  texto: "Compartilhar",
                ),

                MenuIcone(
                  icone: Icons.star,
                  texto: "Avaliações",
                ),
              ],
            ),

            const SizedBox(height: 20),

            // TEXTO
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "O Coliseu de Roma é um dos monumentos mais famosos do mundo. "
                "Construído durante o Império Romano, era utilizado para "
                "combates de gladiadores e outros eventos públicos. Hoje é um "
                "dos principais pontos turísticos da Itália.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pessoas Encontradas",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // AVATARES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person,
                      color: Colors.white, size: 35),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person,
                      color: Colors.white, size: 35),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.person,
                      color: Colors.white, size: 35),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.person,
                      color: Colors.white, size: 35),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class MenuIcone extends StatelessWidget {
  final IconData icone;
  final String texto;

  const MenuIcone({
    super.key,
    required this.icone,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icone,
          color: Colors.blue,
          size: 32,
        ),
        const SizedBox(height: 5),
        Text(
          texto,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}