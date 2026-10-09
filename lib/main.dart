import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
      ),
      home: const HomeScreen(),
    );
  }
}

final reciters = [
  {"name": "المنشاوي", "id": "minshawi"},
  {"name": "عبد الباسط", "id": "abdulbasit"},
  {"name": "المعيقلي", "id": "maher"},
  {"name": "العفاسي", "id": "afasy"},
  {"name": "الدوسري", "id": "yasser"},
  {"name": "السديس", "id": "sudais"},
];

final surahNames = ["الفاتحة", "البقرة", "آل عمران", "النساء", "المائدة", "الأنعام", "الأعراف", "الأنفال", "التوبة", "يونس", "هود", "يوسف", "الرعد", "إبراهيم", "الحجر", "النحل", "الإسراء", "الكهف", "مريم", "طه", "الأنبياء", "الحج", "المؤمنون", "النور", "الفرقان", "الشعراء", "النمل", "القصص", "العنكبوت", "الروم", "لقمان", "السجدة", "الأحزاب", "سبأ", "فاطر", "يس", "الصافات", "ص", "الزمر", "غافر", "فصلت", "الشورى", "الزخرف", "الدخان", "الجاثية", "الأحقاف", "محمد", "الفتح", "الحجرات", "ق", "الذاريات", "الطور", "النجم", "القمر", "الرحمن", "الواقعة", "الحديد", "المجادلة", "الحشر", "الممتحنة", "الصف", "الجمعة", "المنافقون", "التغابن", "الطلاق", "التحريم", "الملك", "القلم", "الحاقة", "المعارج", "نوح", "الجن", "المزمل", "المدثر", "القيامة", "الإنسان", "المرسلات", "النبأ", "النازعات", "عبس", "التكوير", "الانفطار", "المطففين", "الانشقاق", "البروج", "الطارق", "الأعلى", "الغاشية", "الفجر", "البلد", "الشمس", "الليل", "الضحى", "الشرح", "التين", "العلق", "القدر", "البينة", "الزلزلة", "العاديات", "القارعة", "التكاثر", "العصر", "الهمزة", "الفيل", "قريش", "الماعون", "الكوثر", "الكافرون", "النصر", "المسد", "الإخلاص", "الفلق", "الناس"];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedReciter = "عبد الباسط";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("القرآن الكريم"),
        actions: [
          DropdownButton<String>(
            value: selectedReciter,
            dropdownColor: Colors.black,
            underline: const SizedBox(),
            style: const TextStyle(color: Colors.white),
            items: reciters.map((r) => DropdownMenuItem(value: r["name"], child: Text(r["name"]!))).toList(),
            onChanged: (v) => setState(() => selectedReciter = v!),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: surahNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text("${index + 1}"),
            title: Text(surahNames[index]),
            trailing: const Icon(Icons.play_arrow),
            onTap: () {
              // هسه من تدوس على اسم السورة يفتح الآيات
              Navigator.push(context, MaterialPageRoute(builder: (_) => QuranTextPage(surahNumber: index+1, surahName: surahNames[index])));
            },
          );
        },
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(10),
        child: Text("القراءة بدون نت، الصوت يحتاج نت أول مرة فقط", textAlign: TextAlign.center),
      ),
    );
  }
}

class QuranTextPage extends StatelessWidget {
  final int surahNumber;
  final String surahName;
  const QuranTextPage({super.key, required this.surahNumber, required this.surahName});
  @override
  Widget build(BuildContext context) {
    String ayat = surahNumber == 1 
    ? "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n\nالْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ\nالرَّحْمَٰنِ الرَّحِيمِ\nمَالِكِ يَوْمِ الدِّينِ\nإِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ\nاهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ\nصِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ"
    : "سورة $surahName\n\nالنص الكامل للقرآن سيظهر هنا بدون انترنت\n\n(النسخة الحالية فيها الفاتحة كمثال، اذا تريد كل القرآن بدون نت كلي ارسلك ملف json)";

    return Scaffold(
      appBar: AppBar(title: Text(surahName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Text(ayat, style: const TextStyle(fontSize: 26, height: 2), textAlign: TextAlign.center, textDirection: TextDirection.rtl),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.headset),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AudioPage(surahNumber: surahNumber, surahName: surahName))),
      ),
    );
  }
}

class AudioPage extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  const AudioPage({super.key, required this.surahNumber, required this.surahName});
  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final player = AudioPlayer();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    () async {
      try {
        String url = "https://server7.mp3quran.net/basit/Almusshaf-Al-Mojawwad/${widget.surahNumber.toString().padLeft(3, '0')}.mp3";
        await player.setUrl(url);
        setState(() => loading = false);
        player.play();
      } catch(e) {
        setState(() => loading = false);
      }
    }();
  }
  @override
  void dispose() { player.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("صوت ${widget.surahName}")),
      body: Center(child: loading ? const CircularProgressIndicator() : Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(widget.surahName, style: const TextStyle(fontSize: 28)), const SizedBox(height:20), IconButton(icon: Icon(player.playing ? Icons.pause_circle_filled : Icons.play_circle_fill, size: 80), onPressed: () { if(player.playing) player.pause(); else player.play(); setState((){}); }), const Text("يحتاج انترنت للصوت")])),
    );
  }
}