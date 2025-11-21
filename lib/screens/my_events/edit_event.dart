import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../home_screen/attending_events_screen.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;
  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _addressController;
  late TextEditingController _dateTimeController;
  late TextEditingController _descriptionController;
  late TextEditingController _costController;
  late TextEditingController _participantsController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.event.address);
    _dateTimeController = TextEditingController(text: widget.event.dateTime);
    _descriptionController = TextEditingController(
      text: widget.event.description,
    );
    _costController = TextEditingController(text: widget.event.cost);
    _participantsController = TextEditingController(
      text: widget.event.participants,
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    _dateTimeController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    _participantsController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Подтверждение"),
          content: const Text("Вы хотите обновить это событие?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Нет"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                context.pop(); // Go back to the previous screen
              },
              child: const Text("Да"),
            ),
          ],
        );
      },
    );
  }

  void _showCancelDialog() {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Отменить событие'),
          content: TextField(
            controller: reasonController,
            decoration: const InputDecoration(
              hintText: 'Укажите причину отмены',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Назад'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showFinalConfirmation(reasonController.text);
              },
              child: const Text('Продолжить'),
            ),
          ],
        );
      },
    );
  }

  void _showFinalConfirmation(String reason) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Вы уверены?'),
          content: const Text('Это действие нельзя будет отменить.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Нет'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Событие удалено по причине: $reason'),
                  ),
                );
                context.go('/my-events');
              },
              child: const Text('Да'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Редактировать событие'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextField(controller: _addressController, label: 'Адрес'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _dateTimeController,
                label: 'Дата и время',
                isDatePicker: true,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Описание',
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _costController,
                label: 'Стоимость',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _participantsController,
                label: 'Количество мест',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showConfirmationDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7FC9FE),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Обновить',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _showCancelDialog,
                child: const Text(
                  'Отменить событие',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    bool isDatePicker = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      readOnly: isDatePicker,
      onTap: isDatePicker
          ? () async {
              FocusScope.of(context).requestFocus(FocusNode());
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
            }
          : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Пожалуйста, заполните поле: $label';
        }
        return null;
      },
    );
  }
}
