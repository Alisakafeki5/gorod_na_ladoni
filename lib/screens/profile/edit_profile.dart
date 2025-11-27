import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
    final labelTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    );
    final buttonTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );

    return Scaffold(
      backgroundColor: Colors.lightBlue, // Fallback color
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan.shade300, Colors.blue.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // White content card
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black54,
                            ),
                            onPressed: () => context.go('/profile'),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Редактировать профиль',
                                style: titleTextStyle,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 48,
                          ), // To balance the IconButton
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Form
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Никнейм', style: labelTextStyle),
                            const SizedBox(height: 8),
                            _buildTextFormField(initialValue: 'annette_black'),

                            const SizedBox(height: 20),
                            Text('Контакты', style: labelTextStyle),
                            const SizedBox(height: 8),
                            _buildTextFormField(
                              initialValue:
                                  'annette@gmail.com, +1 (316) 555-0116',
                              hintText: 'Email, телефон, социальные сети...',
                              maxLines: 2,
                            ),

                            const SizedBox(height: 20),
                            Text('Интересы', style: labelTextStyle),
                            const SizedBox(height: 8),
                            _buildTextFormField(
                              initialValue: 'Путешествия, фотография, чтение',
                              hintText: 'Ваши увлечения и интересы...',
                              maxLines: 2,
                            ),

                            const SizedBox(height: 20),
                            Text('О себе', style: labelTextStyle),
                            const SizedBox(height: 8),
                            _buildTextFormField(
                              initialValue:
                                  'Люблю путешествовать и фотографировать природу. Увлекаюсь чтением книг и изучением новых культур.',
                              hintText: 'Расскажите о себе...',
                              maxLines: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Save Button
                      ElevatedButton(
                        onPressed: () => _showSuccessMessage(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFD5555),
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shadowColor: const Color(0xFF5C5A5A),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Сохранить изменения',
                          style: buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Profile Picture
          const Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: EditProfilePic(
              image: "https://i.postimg.cc/0jqKB6mS/Profile-Image.png",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required String initialValue,
    String? hintText,
    int maxLines = 1,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFD5555), width: 2),
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Профиль успешно обновлен!"),
        backgroundColor: const Color(0xFFFD5555),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (context.mounted) {
        context.go('/profile');
      }
    });
  }
}

class EditProfilePic extends StatelessWidget {
  const EditProfilePic({
    super.key,
    required this.image,
    this.imageUploadBtnPress,
  });

  final String image;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 120,
        width: 120,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: Image(fit: BoxFit.cover, image: NetworkImage(image)),
              ),
            ),
            Positioned(
              bottom: -5,
              right: -5,
              child: InkWell(
                onTap: imageUploadBtnPress,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFFD5555),
                  child: const Icon(Icons.edit, color: Colors.white, size: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
