import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFFFD5555),
        foregroundColor: Colors.white,
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const EditProfilePic(
              image: 'https://i.postimg.cc/cCsYDjvj/user-2.png',
              imageUploadBtnPress: null,
            ),
            const Divider(),
            Form(
              child: Column(
                children: [
                  // Никнейм
                  UserInfoEditField(
                    text: "Никнейм",
                    child: TextFormField(
                      initialValue: "annette_black",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFFD5555).withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5,
                          vertical: 16.0,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  // Контакты
                  UserInfoEditField(
                    text: "Контакты",
                    child: TextFormField(
                      initialValue: "annette@gmail.com, +1 (316) 555-0116",
                      maxLines: 2,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFFD5555).withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5,
                          vertical: 16.0,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        hintText: "Email, телефон, социальные сети...",
                      ),
                    ),
                  ),
                  // Интересы
                  UserInfoEditField(
                    text: "Интересы",
                    child: TextFormField(
                      initialValue: "Путешествия, фотография, чтение",
                      maxLines: 2,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFFD5555).withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5,
                          vertical: 16.0,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        hintText: "Ваши увлечения и интересы...",
                      ),
                    ),
                  ),
                  // О себе
                  UserInfoEditField(
                    text: "О себе",
                    child: TextFormField(
                      initialValue:
                          "Люблю путешествовать и фотографировать природу. Увлекаюсь чтением книг и изучением новых культур.",
                      maxLines: 4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFFD5555).withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5,
                          vertical: 16.0,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        hintText: "Расскажите о себе...",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/profile');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.color!.withOpacity(0.08),
                      foregroundColor: Colors.grey[800],
                      minimumSize: const Size(double.infinity, 48),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFD5555),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      // Логика сохранения профиля
                      _showSuccessMessage(context);
                    },
                    child: const Text("Save Update"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Profile updated successfully!"),
        backgroundColor: const Color(0xFFFD5555),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    // Возврат к профилю после сохранения
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
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(
            context,
          ).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(radius: 50, backgroundImage: NetworkImage(image)),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({super.key, required this.text, required this.child});

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0 / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(text),
            ),
          ),
          Expanded(flex: 3, child: child),
        ],
      ),
    );
  }
}
