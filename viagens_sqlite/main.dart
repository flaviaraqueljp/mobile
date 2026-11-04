import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

// ================= APP =================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viagens SQLite',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ViagensPage(),
    );
  }
}

// ================= BANCO SQLITE =================

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'viagens.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE viagens(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            destino TEXT,
            status TEXT
          )
        ''');
      },
    );
  }

  Future<int> inserirViagem(String destino, String status) async {
    final db = await database;

    return await db.insert(
      'viagens',
      {
        'destino': destino,
        'status': status,
      },
    );
  }

  Future<List<Map<String, dynamic>>> listarViagens() async {
    final db = await database;

    return await db.query('viagens');
  }

  Future<int> excluirViagem(int id) async {
    final db = await database;

    return await db.delete(
      'viagens',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// ================= TELA PRINCIPAL =================

class ViagensPage extends StatelessWidget {
  const ViagensPage({super.key});

  Future<void> salvarDestino(
    BuildContext context,
    String status,
  ) async {
    await DatabaseHelper.instance
        .inserirViagem("Roma - Coliseu", status);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Destino salvo como: $status"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Viagens"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ListaViagensPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/d/de/Colosseo_2020.jpg',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  left: 15,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
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
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                MenuIcone(
                  icone: Icons.flight_takeoff,
                  texto: "Quero Ir",
                  onTap: () async {
                    await salvarDestino(
                      context,
                      "Quero Ir",
                    );
                  },
                ),
                MenuIcone(
                  icone: Icons.location_on,
                  texto: "Já Fui",
                  onTap: () async {
                    await salvarDestino(
                      context,
                      "Visitado",
                    );
                  },
                ),
                MenuIcone(
                  icone: Icons.share,
                  texto: "Compartilhar",
                  onTap: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content:
                            Text("Compartilhar viagem"),
                      ),
                    );
                  },
                ),
                MenuIcone(
                  icone: Icons.star,
                  texto: "Avaliações",
                  onTap: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content:
                            Text("Abrir avaliações"),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "O Coliseu de Roma é um dos monumentos mais famosos do mundo. Construído durante o Império Romano, era utilizado para combates de gladiadores e outros eventos públicos.",
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
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                avatarPessoa(
                  context,
                  "Maria",
                  "https://picsum.photos/200?random=1",
                  "Maria conheceu o Coliseu durante suas férias na Itália.",
                ),
                avatarPessoa(
                  context,
                  "João",
                  "https://picsum.photos/200?random=2",
                  "João visitou Roma pela primeira vez em 2024.",
                ),
                avatarPessoa(
                  context,
                  "Ana",
                  "https://picsum.photos/200?random=3",
                  "Ana é apaixonada por história romana.",
                ),
                avatarPessoa(
                  context,
                  "Carlos",
                  "https://picsum.photos/200?random=4",
                  "Carlos encontrou diversos viajantes em Roma.",
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

// ================= AVATAR =================

Widget avatarPessoa(
  BuildContext context,
  String nome,
  String imagem,
  String descricao,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PessoaPage(
            nome: nome,
            imagem: imagem,
            descricao: descricao,
          ),
        ),
      );
    },
    child: CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage(imagem),
    ),
  );
}

// ================= MENU =================

class MenuIcone extends StatelessWidget {
  final IconData icone;
  final String texto;
  final VoidCallback onTap;

  const MenuIcone({
    super.key,
    required this.icone,
    required this.texto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icone,
            color: Colors.blue,
            size: 32,
          ),
          const SizedBox(height: 5),
          Text(texto),
        ],
      ),
    );
  }
}

// ================= LISTAGEM SQLITE =================

class ListaViagensPage extends StatefulWidget {
  const ListaViagensPage({super.key});

  @override
  State<ListaViagensPage> createState() =>
      _ListaViagensPageState();
}

class _ListaViagensPageState
    extends State<ListaViagensPage> {
  List<Map<String, dynamic>> viagens = [];

  @override
  void initState() {
    super.initState();
    carregarViagens();
  }

  Future<void> carregarViagens() async {
    viagens =
        await DatabaseHelper.instance.listarViagens();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Viagens Salvas"),
      ),
      body: ListView.builder(
        itemCount: viagens.length,
        itemBuilder: (context, index) {
          final viagem = viagens[index];

          return ListTile(
            title: Text(viagem['destino']),
            subtitle: Text(viagem['status']),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
                await DatabaseHelper.instance
                    .excluirViagem(
                  viagem['id'],
                );

                carregarViagens();
              },
            ),
          );
        },
      ),
    );
  }
}

// ================= TELA PESSOA =================

class PessoaPage extends StatelessWidget {
  final String nome;
  final String imagem;
  final String descricao;

  const PessoaPage({
    super.key,
    required this.nome,
    required this.imagem,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nome),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage:
                    NetworkImage(imagem),
              ),
              const SizedBox(height: 20),
              Text(
                nome,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                descricao,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}