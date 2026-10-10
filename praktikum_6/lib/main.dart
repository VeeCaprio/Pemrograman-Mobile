
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MyApp(
      modeGelapAwal: prefs.getBool('modeGelap') ?? false,
      warnaTemaAwal: prefs.getInt('warnaTema') ?? 0,
    ),
  );
}

// Empat pilihan warna tema.
const List<Color> warnaPilihan = [
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

class MyApp extends StatefulWidget {
  final bool modeGelapAwal;
  final int warnaTemaAwal;

  const MyApp({
    super.key,
    this.modeGelapAwal = false,
    this.warnaTemaAwal = 0,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool modeGelap;
  late int indeksWarna;

  int tabAktif = 0;
  final Set<int> favorit = {};

  final List<Map<String, dynamic>> galeri = [
    {
      'judul': 'Pegunungan',
      'ikon': Icons.landscape,
      'warna': Colors.teal,
      'deskripsi': 'Pemandangan pegunungan yang indah.',
    },
    {
      'judul': 'Laut',
      'ikon': Icons.waves,
      'warna': Colors.blue,
      'deskripsi': 'Pemandangan laut yang menyegarkan.',
    },
    {
      'judul': 'Matahari',
      'ikon': Icons.wb_sunny,
      'warna': Colors.orange,
      'deskripsi': 'Cahaya matahari yang hangat.',
    },
    {
      'judul': 'Hutan',
      'ikon': Icons.forest,
      'warna': Colors.green,
      'deskripsi': 'Pepohonan hijau yang menyejukkan.',
    },
    {
      'judul': 'Bintang',
      'ikon': Icons.star,
      'warna': Colors.deepPurple,
      'deskripsi': 'Langit malam penuh bintang.',
    },
    {
      'judul': 'Bunga',
      'ikon': Icons.local_florist,
      'warna': Colors.pink,
      'deskripsi': 'Bunga cantik berwarna-warni.',
    },
  ];

  @override
  void initState() {
    super.initState();

    modeGelap = widget.modeGelapAwal;
    indeksWarna = widget.warnaTemaAwal
        .clamp(0, warnaPilihan.length - 1);
  }

  Future<void> simpanTema() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('modeGelap', modeGelap);
    await prefs.setInt('warnaTema', indeksWarna);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: warnaPilihan[indeksWarna],
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: warnaPilihan[indeksWarna],
        brightness: Brightness.dark,
      ),
      themeMode: modeGelap ? ThemeMode.dark : ThemeMode.light,

      // Named route dan pengiriman arguments.
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final args = settings.arguments as Map<String, dynamic>;

          return MaterialPageRoute(
            settings: settings,
            builder: (context) => HalamanDetail(
              item: args['item'] as Map<String, dynamic>,
              id: args['id'] as int,
            ),
          );
        }

        return MaterialPageRoute(
          builder: (context) => const HalamanTidakDitemukan(),
        );
      },

      home: Builder(
        builder: (homeContext) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Galeri Interaktif'),
              centerTitle: true,
            ),
            body: IndexedStack(
              index: tabAktif,
              children: [
                halamanGaleri(homeContext),
                halamanFavorit(homeContext),
                halamanPengaturan(homeContext),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: tabAktif,
              onDestinationSelected: (index) {
                setState(() => tabAktif = index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.photo_library_outlined),
                  selectedIcon: Icon(Icons.photo_library),
                  label: 'Galeri',
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite_outline),
                  selectedIcon: Icon(Icons.favorite),
                  label: 'Favorit',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Pengaturan',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget halamanGaleri(BuildContext navContext) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: galeri.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        return kartuGaleri(index, navContext);
      },
    );
  }

  Widget halamanFavorit(BuildContext navContext) {
    final data = <int>[];

    for (int i = 0; i < galeri.length; i++) {
      if (favorit.contains(i)) {
        data.add(i);
      }
    }

    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: Theme.of(navContext).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              'Belum ada favorit',
              style: Theme.of(navContext).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Pilih ikon hati di Galeri.',
              style: Theme.of(navContext).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        return kartuGaleri(data[index], navContext);
      },
    );
  }

  Widget kartuGaleri(int index, BuildContext navContext) {
    final item = galeri[index];
    final isFavorit = favorit.contains(index);
    final warna = item['warna'] as Color;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(navContext).pushNamed(
            '/detail',
            arguments: {
              'item': item,
              'id': index,
            },
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: 'gambar-$index',
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: warna.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item['ikon'] as IconData,
                    size: 76,
                    color: warna,
                  ),
                ),
              ),
            ),
            ListTile(
              dense: true,
              title: Text(item['judul'] as String),
              trailing: IconButton(
                tooltip: isFavorit
                    ? 'Hapus dari favorit'
                    : 'Tambahkan ke favorit',
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: Icon(
                    isFavorit ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey<bool>(isFavorit),
                    color: isFavorit
                        ? Theme.of(navContext).colorScheme.error
                        : null,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (isFavorit) {
                      favorit.remove(index);
                    } else {
                      favorit.add(index);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget halamanPengaturan(BuildContext settingsContext) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: const Text('Mode gelap'),
          subtitle: const Text(
            'Simpan pilihan mode terang atau gelap',
          ),
          value: modeGelap,
          onChanged: (value) async {
            setState(() => modeGelap = value);
            await simpanTema();
          },
        ),
        const SizedBox(height: 20),
        Text(
          'Warna tema',
          style: Theme.of(settingsContext).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Text(
          'Pilih warna utama aplikasi:',
          style: Theme.of(settingsContext).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (int i = 0; i < warnaPilihan.length; i++)
              Semantics(
                label: 'Warna tema ${i + 1}',
                selected: indeksWarna == i,
                child: GestureDetector(
                  onTap: () async {
                    setState(() => indeksWarna = i);
                    await simpanTema();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: indeksWarna == i
                            ? Theme.of(settingsContext)
                            .colorScheme
                            .onSurface
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: warnaPilihan[i],
                      child: indeksWarna == i
                          ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: Icon(
              Icons.animation,
              color: Theme.of(settingsContext).colorScheme.primary,
            ),
            title: const Text('Praktikum Flutter 6'),
            subtitle: const Text(
              'Tema, navigasi, galeri, dan animasi.',
            ),
          ),
        ),
      ],
    );
  }
}

class HalamanDetail extends StatefulWidget {
  final Map<String, dynamic> item;
  final int id;

  const HalamanDetail({
    super.key,
    required this.item,
    required this.id,
  });

  @override
  State<HalamanDetail> createState() => _HalamanDetailState();
}

class _HalamanDetailState extends State<HalamanDetail>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animasi;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    animasi = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final warna = item['warna'] as Color;

    return Scaffold(
      appBar: AppBar(
        title: Text(item['judul'] as String),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Hero(
            tag: 'gambar-${widget.id}',
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                color: warna.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: ScaleTransition(
                  scale: animasi,
                  child: Icon(
                    item['ikon'] as IconData,
                    size: 150,
                    color: warna,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            item['judul'] as String,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Text(
            item['deskripsi'] as String,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.animation,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Animasi Hero dan Scale'),
              subtitle: const Text(
                'Gambar berpindah dengan Hero dan membesar '
                    'dengan ScaleTransition.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HalamanTidakDitemukan extends StatelessWidget {
  const HalamanTidakDitemukan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman tidak ditemukan')),
      body: const Center(
        child: Text('Halaman tidak ditemukan'),
      ),
    );
  }
}