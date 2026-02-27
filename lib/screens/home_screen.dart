import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/note.dart';
import '../services/note_storage.dart';
import '../theme/cartoon_theme.dart';
import '../widgets/cartoon_bg_painter.dart';
import '../widgets/note_card.dart';
import 'note_edit_screen.dart';

/// Ana ekran - Cartoon Network tarzı not listesi
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Note> _notes = [];
  bool _loading = true;
  late AnimationController _fabController;
  late Animation<double> _fabBounce;

  @override
  void initState() {
    super.initState();
    _loadNotes();

    _fabController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fabBounce = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _fabController,
        curve: Curves.elasticInOut,
      ),
    );
    // FAB'ın sürekli hafifçe zıplaması
    _fabController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    final notes = await NoteStorage.loadNotes();
    notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    setState(() {
      _notes = notes;
      _loading = false;
    });
  }

  Future<void> _addOrEditNote({Note? note}) async {
    final result = await Navigator.push<Note>(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            NoteEditScreen(note: note),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.elasticOut,
              reverseCurve: Curves.easeIn,
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      ),
    );

    if (result != null) {
      setState(() {
        final index = _notes.indexWhere((n) => n.id == result.id);
        if (index >= 0) {
          _notes[index] = result;
        } else {
          _notes.insert(0, result);
        }
      });
      await NoteStorage.saveNotes(_notes);
    }
  }

  Future<void> _deleteNote(Note note) async {
    // Cartoon tarzı silme onay dialogu
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _CartoonDialog(
        title: 'Emin misin? 🤔',
        message: '"${note.title.isEmpty ? "İsimsiz Not" : note.title}" silinecek!',
        confirmText: 'Sil! 💥',
        cancelText: 'Vazgeç',
      ),
    );

    if (confirmed == true) {
      setState(() => _notes.removeWhere((n) => n.id == note.id));
      await NoteStorage.saveNotes(_notes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CartoonTheme.bgColor,
      body: Stack(
        children: [
          // Arka plan dekorasyonu
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: CartoonBgPainter(),
          ),
          SafeArea(
            child: Column(
              children: [
                // Üst başlık
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    children: [
                      // Logo / ikon
                      Container(
                        width: 50,
                        height: 50,
                        decoration: CartoonTheme.cartoonBoxSmall(
                          color: CartoonTheme.accentYellow,
                          borderWidth: 3,
                          radius: 16,
                        ),
                        child: const Center(
                          child: Text(
                            '📒',
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notlarım',
                            style: GoogleFonts.balooBhai2(
                              textStyle: CartoonTheme.cartoonTitle,
                            ),
                          ),
                          Text(
                            '${_notes.length} not',
                            style: GoogleFonts.balooBhai2(
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: CartoonTheme.darkOutline
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Dekoratif yıldızlar
                      const Text(
                        '⭐',
                        style: TextStyle(fontSize: 28),
                      ),
                    ],
                  ),
                ),

                // Dekoratif çizgi
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          CartoonTheme.accentPink,
                          CartoonTheme.accentBlue,
                          CartoonTheme.accentYellow,
                          CartoonTheme.accentPurple,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Not listesi
                Expanded(
                  child: _loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: CartoonTheme.accentPink,
                            strokeWidth: 4,
                          ),
                        )
                      : _notes.isEmpty
                          ? _buildEmptyState()
                          : _buildNoteGrid(),
                ),
              ],
            ),
          ),
        ],
      ),
      // FAB - Yeni not ekle
      floatingActionButton: ScaleTransition(
        scale: _fabBounce,
        child: GestureDetector(
          onTap: () => _addOrEditNote(),
          child: Container(
            width: 64,
            height: 64,
            decoration: CartoonTheme.cartoonBox(
              color: CartoonTheme.accentPink,
              borderWidth: 3.5,
              radius: 20,
            ),
            child: Center(
              child: Text(
                '+',
                style: GoogleFonts.balooBhai2(
                  textStyle: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: CartoonTheme.white,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Büyük cartoon not ikonu
          Container(
            width: 120,
            height: 120,
            decoration: CartoonTheme.cartoonBox(
              color: CartoonTheme.accentYellow.withValues(alpha: 0.5),
              borderWidth: 3,
              radius: 30,
            ),
            child: const Center(
              child: Text(
                '📝',
                style: TextStyle(fontSize: 56),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Henüz not yok!',
            style: GoogleFonts.balooBhai2(
              textStyle: CartoonTheme.cartoonTitle.copyWith(fontSize: 24),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pembe butona bas ve\nyazmaya başla! 🚀',
            textAlign: TextAlign.center,
            style: GoogleFonts.balooBhai2(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CartoonTheme.darkOutline.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 90),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.85,
        ),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 300 + (index * 80)),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value.clamp(0.0, 1.0),
                child: child,
              );
            },
            child: NoteCard(
              title: note.title,
              content: note.content,
              color: CartoonTheme.noteColors[
                  note.colorIndex % CartoonTheme.noteColors.length],
              onTap: () => _addOrEditNote(note: note),
              onDelete: () => _deleteNote(note),
            ),
          );
        },
      ),
    );
  }
}

/// Cartoon tarzı dialog kutusu
class _CartoonDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  const _CartoonDialog({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: CartoonTheme.cartoonBox(
          color: CartoonTheme.white,
          borderWidth: 3.5,
          radius: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.balooBhai2(
                textStyle: CartoonTheme.cartoonTitle.copyWith(fontSize: 22),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.balooBhai2(
                textStyle: CartoonTheme.cartoonBody.copyWith(fontSize: 15),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: CartoonTheme.cartoonBoxSmall(
                        color: CartoonTheme.accentBlue.withValues(alpha: 0.3),
                        borderWidth: 2.5,
                        radius: 14,
                      ),
                      child: Center(
                        child: Text(
                          cancelText,
                          style: GoogleFonts.balooBhai2(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: CartoonTheme.darkOutline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: CartoonTheme.cartoonBoxSmall(
                        color: CartoonTheme.accentPink,
                        borderWidth: 2.5,
                        radius: 14,
                      ),
                      child: Center(
                        child: Text(
                          confirmText,
                          style: GoogleFonts.balooBhai2(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: CartoonTheme.white,
                            ),
                          ),
                        ),
                      ),
                    ),
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
