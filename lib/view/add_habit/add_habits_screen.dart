import 'package:git_tracker/model/habit.dart';
import 'package:git_tracker/util/available_icons.dart';
import 'package:flutter/material.dart';
import 'package:git_tracker/view/widgets/chevron_button.dart';
import 'package:git_tracker/view/widgets/my_button.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:git_tracker/controller/habits_controller.dart';

class AddHabitsScreen extends StatefulWidget {
  const AddHabitsScreen({super.key});

  @override
  State<AddHabitsScreen> createState() => _AddHabitsScreenState();
}

class _AddHabitsScreenState extends State<AddHabitsScreen> {
  final habitController = Get.find<HabitController>();
  IconData selectedIcon = Icons.fitness_center;
  Color selectedColor = Colors.blue;
  String iconSearchQuery = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _frequencyController =
      TextEditingController(text: '1');

  String _habitType = 'build';
  String _interval = 'daily';
  bool _remindersEnabled = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _frequencyController.dispose();
    super.dispose();
  }

  void _showIconPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            List<Map<String, dynamic>> filteredIcons = availableIcons
                .where((icon) => icon['name']
                    .toString()
                    .toLowerCase()
                    .contains(iconSearchQuery.toLowerCase()))
                .toList();

            return AlertDialog(
              title: const Text('Select Icon'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search icons...',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          iconSearchQuery = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: filteredIcons.length,
                        itemBuilder: (context, index) {
                          return Tooltip(
                            message: filteredIcons[index]['name'],
                            child: IconButton(
                              icon: Icon(filteredIcons[index]['icon']),
                              onPressed: () {
                                this.setState(() {
                                  selectedIcon = filteredIcons[index]['icon'];
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  selectedColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _createHabit() async {
    if (_nameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a habit name',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final habit = Habit(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        durationMinutes: int.tryParse(_durationController.text) ?? 0,
        icon: IconData(selectedIcon.codePoint),
        color: Color(selectedColor.value),
        type: _habitType,
        frequency: int.tryParse(_frequencyController.text) ?? 0,
        interval: _interval,
        hasReminder: _remindersEnabled,
        createdAt: DateTime.now(),
        lastCompleted: null);

    try {
      await habitController.addHabit(habit);

      Get.snackbar(
        'Success',
        'Habit created successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.back(); // Navigate back
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error creating habit: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: ChevronButton(
            onPressed: () => Navigator.of(context).pop(),
            direction: 'left',
          ),
        ),
        title: const Text('Add Habit'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add New Habit',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Habit Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _durationController,
                    decoration: const InputDecoration(
                      labelText: 'Duration (minutes)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timer),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  // Icon Selector
                  InkWell(
                    onTap: _showIconPicker,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(selectedIcon),
                          const SizedBox(width: 8),
                          const Text('Select Icon'),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Color Selector
                  InkWell(
                    onTap: _showColorPicker,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: selectedColor,
                          ),
                          const SizedBox(width: 8),
                          const Text('Select Color'),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Habit Type
                  DropdownButtonFormField<String>(
                    value: _habitType,
                    decoration: const InputDecoration(
                      labelText: 'Habit Type',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'build', child: Text('Build')),
                      DropdownMenuItem(value: 'quit', child: Text('Quit')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _habitType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  // Goal Frequency
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _frequencyController,
                          decoration: const InputDecoration(
                            labelText: 'Frequency',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (int.tryParse(value) == null ||
                                int.parse(value) < 1) {
                              _frequencyController.text = '1';
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<String>(
                          value: _interval,
                          decoration: const InputDecoration(
                            labelText: 'Interval',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'daily', child: Text('Per Day')),
                            DropdownMenuItem(
                                value: 'weekly', child: Text('Per Week')),
                            DropdownMenuItem(
                                value: 'monthly', child: Text('Per Month')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _interval = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Reminder Setting
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.notifications),
                        const SizedBox(width: 8),
                        const Text('Reminders'),
                        const Spacer(),
                        Switch(
                          value: _remindersEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _remindersEnabled = value;
                            });
                            if (value) {
                              // TODO: Implement reminder setup dialog
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height: 80), // Add padding at bottom for floating button
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: MyButton(
              name: "Create Habit",
              onPressed: _createHabit,
            ),
          ),
        ],
      ),
    );
  }
}
