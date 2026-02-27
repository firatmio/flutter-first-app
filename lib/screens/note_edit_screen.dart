import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/note.dart';
import '../theme/cartoon_theme.dart';

/// Cartoon Network tarzı not ekleme / düzenleme ekranı
class NoteEditScreen extends StatefulWidget {
  final Note? note;

  const NoteEditScreen({super.key, this.note});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late int _selectedColorIndex;
  late AnimationController _animController;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
    _selectedColorIndex = widget.note?.colorIndex ?? 0;

    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final now = DateTime.now();
    final note = Note(
      id: widget.note?.id ?? now.millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      colorIndex: _selectedColorIndex,
      createdAt: widget.note?.createdAt ?? now,
      updatedAt: now,
    );
    Navigator.pop(context, note);
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = CartoonTheme.noteColors[_selectedColorIndex];

    return Scaffold(
      backgroundColor: CartoonTheme.bgColor,
      body: FadeTransition(
        opacity: _fadeIn,
        child: SafeArea(
          child: Column(
            children: [
              // Üst bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // Geri butonu
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: CartoonTheme.cartoonBoxSmall(
                          color: CartoonTheme.white,
                          borderWidth: 3,
                          radius: 14,
                        ),
                        child: const Center(
                          child: Text(
                            '←',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: CartoonTheme.darkOutline,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.note == null ? 'Yeni Not ✏️' : 'Notu Düzenle 🖊️',
                        style: GoogleFonts.balooBhai2(
                          textStyle: CartoonTheme.cartoonTitle.copyWith(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    // Kaydet butonu
                    GestureDetector(
                      onTap: _saveNote,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: CartoonTheme.cartoonBoxSmall(
                          color: CartoonTheme.accentBlue,
                          borderWidth: 3,
                          radius: 14,
                        ),
                        child: Text(
                          'Kaydet ✓',
                          style: GoogleFonts.balooBhai2(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: CartoonTheme.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Renk seçici
              SizedBox(
                height: 56,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: CartoonTheme.noteColors.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedColorIndex;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedColorIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 42,
                        height: 42,
                        margin: const EdgeInsets.only(right: 10, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                          color: CartoonTheme.noteColors[index],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? CartoonTheme.darkOutline
                                : CartoonTheme.darkOutline.withValues(alpha: 0.3),
                            width: isSelected ? 3.5 : 2,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: CartoonTheme.darkOutline
                                        .withValues(alpha: 0.3),
                                    offset: const Offset(2, 2),
                                    blurRadius: 0,
                                  ),
                                ]
                              : [],
                        ),
                        child: isSelected
                            ? const Center(
                                child: Text(
                                  '★',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: CartoonTheme.darkOutline,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // İçerik alanı
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: CartoonTheme.cartoonBox(
                      color: selectedColor.withValues(alpha: 0.35),
                      borderWidth: 3,
                      radius: 24,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Başlık
                        TextField(
                          controller: _titleController,
                          style: GoogleFonts.balooBhai2(
                            textStyle:
                                CartoonTheme.cartoonSubtitle.copyWith(fontSize: 22),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Başlık yaz... 📝',
                            hintStyle: GoogleFonts.balooBhai2(
                              textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: CartoonTheme.darkOutline.withValues(alpha: 0.35),
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        // Çizgi
                        Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: CartoonTheme.darkOutline.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // İçerik
                        Expanded(
                          child: TextField(
                            controller: _contentController,
                            maxLines: null,
                            expands: true,
                            style: GoogleFonts.balooBhai2(
                              textStyle: CartoonTheme.cartoonBody.copyWith(
                                fontSize: 16,
                                height: 1.6,
                              ),
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  'Notunu buraya yaz! Aklına ne gelirse... 💭',
                              hintStyle: GoogleFonts.balooBhai2(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: CartoonTheme.darkOutline
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            textAlignVertical: TextAlignVertical.top,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
