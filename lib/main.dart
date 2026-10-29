import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const KoshaApp());

/// ألوان مأخوذة من لوحة المحل
class C {
  static const tan = Color(0xFFB9A283);
  static const tanLight = Color(0xFFE6D9C4);
  static const ink = Color(0xFF2B2126);
  static const green = Color(0xFF6CC7A0);
  static const pink = Color(0xFFF06CA0);
  static const magenta = Color(0xFFD9468E);
  static const purple = Color(0xFF8B3FA0);
  static const dish = Color(0xFFE8B4B8);
}

/// عدّل الروابط من هنا
class LinkItem {
  final String title;
  final IconData icon;
  final Color color;
  final Uri uri;
  const LinkItem(this.title, this.icon, this.color, this.uri);
}

final links = <LinkItem>[
  LinkItem('انستقرام', Icons.camera_alt_outlined, C.pink,
      Uri.parse('https://www.instagram.com/best_kosha')),
  LinkItem('تيك توك', Icons.music_note, C.purple,
      Uri.parse('https://www.tiktok.com/@.bs5153')),
  LinkItem('سناب شات', Icons.chat_bubble_outline, C.green,
      Uri.parse('https://snapchat.com/t/xMYRu2c0')),
  LinkItem('اتصل بنا: 0505562356', Icons.phone_outlined, C.ink,
      Uri(scheme: 'tel', path: '+966505562356')),
  LinkItem('موقع الفرع', Icons.location_on_outlined, C.magenta,
      Uri.parse('https://maps.app.goo.gl/f9iF4d3v4mqoA6Jt9')),
];

const tags = <(String, Color)>[
  ('كوش أفراح', C.green),
  ('دبش عروسة', C.dish),
  ('مسكة عروسة', C.magenta),
  ('ورود طبيعية', C.purple),
];

class KoshaApp extends StatelessWidget {
  const KoshaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أحلى كوشة | Best Kosha',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.tajawalTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [C.tan, C.tanLight],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(18, 26, 18, 22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x47463219),
                          blurRadius: 32,
                          offset: Offset(0, 12)),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/logo.png', width: 150),
                      const SizedBox(height: 14),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (var i = 0; i < tags.length; i++) ...[
                              if (i > 0) const SizedBox(width: 6),
                              TagChip(tags[i].$1, tags[i].$2),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      for (final l in links) ...[
                        LinkButton(l),
                        const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final String text;
  final Color color;

  const TagChip(this.text, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
      child: Text(text,
          style: const TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
    );
  }
}

class LinkButton extends StatefulWidget {
  final LinkItem item;
  const LinkButton(this.item, {super.key});

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  bool hover = false;

  Future<void> _open() async {
    await launchUrl(widget.item.uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.item.color;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: _open,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: hover ? c : Colors.white,
            border: Border.all(color: c, width: 2),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            children: [
              Icon(widget.item.icon, size: 26, color: hover ? Colors.white : c),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 24),
                  child: Text(
                    widget.item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: hover ? Colors.white : C.ink),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
