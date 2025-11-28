import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile App',
      theme: ThemeData(
        // Основная тема с шрифтом Alegreya Sans SC
        textTheme: GoogleFonts.alegreyaSansScTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFD5555),
          primary: const Color(0xFFFD5555),
          secondary: Colors.blue.shade500,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFD5555),
            foregroundColor: Colors.white,
            elevation: 5,
            shadowColor: const Color(0xFF5C5A5A),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.alegreyaSansSc(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xFFFD5555),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentTextStyle: GoogleFonts.alegreyaSansSc(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      home: const EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем стили из темы
    final titleTextStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );

    final labelTextStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    );

    return Scaffold(
      backgroundColor: Colors.lightBlue,
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
                            _buildTextFormField(
                              context,
                              initialValue: 'annette_black',
                            ),

                            const SizedBox(height: 20),
                            Text('Контакты', style: labelTextStyle),
                            const SizedBox(height: 8),
                            _buildTextFormField(
                              context,
                              initialValue:
                                  'annette@gmail.com, +1 (316) 555-0116',
                              hintText: 'Email, телефон, социальные сети...',
                              maxLines: 2,
                            ),

                            const SizedBox(height: 20),
                            Text('Интересы', style: labelTextStyle),
                            const SizedBox(height: 8),
                            _buildTextFormField(
                              context,
                              initialValue: 'Путешествия, фотография, чтение',
                              hintText: 'Ваши увлечения и интересы...',
                              maxLines: 2,
                            ),

                            const SizedBox(height: 20),
                            Text('О себе', style: labelTextStyle),
                            const SizedBox(height: 8),
                            _buildTextFormField(
                              context,
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
                        child: const Text('Сохранить изменения'),
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

  Widget _buildTextFormField(
    BuildContext context, {
    required String initialValue,
    String? hintText,
    int maxLines = 1,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      style: GoogleFonts.alegreyaSansSc(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.alegreyaSansSc(
          fontSize: 16,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Профиль успешно обновлен!")));

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
