import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/views/widgets/task_input.dart';

import '../theme/app_theme.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  static const _screenTitle = 'Add Project';
  static const _submitLabel = 'Add Project';
  static const _futureYearLimit = 2035;

  final _formKey = GlobalKey<FormState>();

  String? _group;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _taskLogoName;

  final List<String> _groupOptions = const [
    'Work',
    'Personal',
    'Study',
    'Health',
  ];

  DateTime get _today => DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_screenTitle), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildGroupInput(),
              _buildProjectNameInput(),
              _buildDescriptionInput(),
              _buildStartDateInput(),
              _buildEndDateInput(),
              _buildLogoInput(),
              const SizedBox(height: 40),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupInput() {
    return TaskInput(
      label: 'Task Group',
      value: _group,
      hint: 'Select a group',
      leading: SvgPicture.asset(
        'lib/assets/briefcase.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(AppTheme.softPink, BlendMode.srcIn),
      ),
      type: InputType.dropdown,
      options: _groupOptions,
      isRequired: true,
      validationMessage: 'Please select a task group',
      dropdownIcon: SvgPicture.asset(
        'lib/assets/arrow_down.svg',
        width: 14,
        height: 14
      ),
      onChanged: (selected) {
        setState(() {
          _group = selected;
        });
      },
    );
  }

  Widget _buildProjectNameInput() {
    return const TaskInput(
      label: 'Project Name',
      type: InputType.text,
      isRequired: true,
      validationMessage: 'Project name is required',
    );
  }

  Widget _buildDescriptionInput() {
    return const TaskInput(
      label: 'Description',
      type: InputType.multiline,
      isRequired: true,
      validationMessage: 'Please add a short description',
    );
  }

  Widget _buildStartDateInput() {
    return TaskInput(
      label: 'Start Date',
      leading: SvgPicture.asset(
        'lib/assets/calendar.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(AppTheme.lavenderLight, BlendMode.srcIn),
      ),
      value: _formatDate(_startDate),
      hint: 'Select start date',
      type: InputType.date,
      isRequired: true,
      validationMessage: 'Please select a start date',
      validator: (_) =>
          _validateNotPast(_startDate, 'Start date cannot be in the past'),
      trailing: SvgPicture.asset(
        'lib/assets/arrow_down.svg',
        width: 14,
        height: 14
    ),
    //   dropdownIcon: SvgPicture.asset(
    //     'lib/assets/arrow_down.svg',
    //     width: 14,
    //     height: 14
    // ),
      onTap: () => _pickDate(
        currentValue: _startDate,
        onPicked: (picked) {
          setState(() {
            _startDate = picked;
          });
        },
      ),
    );
  }

  Widget _buildEndDateInput() {
    return TaskInput(
      label: 'End Date',
      leading: SvgPicture.asset(
        'lib/assets/calendar.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(AppTheme.lavenderLight, BlendMode.srcIn),
      ),
      value: _formatDate(_endDate),
      hint: 'Select end date',
      type: InputType.date,
      isRequired: true,
      validationMessage: 'Please select an end date',
      validator: (_) =>
          _validateNotPast(_endDate, 'End date cannot be in the past'),
      trailing: SvgPicture.asset(
          'lib/assets/arrow_down.svg',
          width: 14,
          height: 14
      ),
      onTap: () => _pickDate(
        currentValue: _endDate,
        onPicked: (picked) {
          setState(() {
            _endDate = picked;
          });
        },
      ),
    );
  }

  Widget _buildLogoInput() {
    return TaskInput(
      label: 'Project Logo',
      type: InputType.image,
      value: _taskLogoName,
      hint: 'No logo selected',
      isRequired: true,
      validationMessage: 'Please pick a logo or file',
      onChanged: (selectedFileName) {
        setState(() {
          _taskLogoName = selectedFileName;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handleSubmit,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(_submitLabel, style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Future<void> _pickDate({
    required DateTime? currentValue,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final DateTime initial = currentValue != null && !_isPastDate(currentValue)
        ? currentValue
        : _today;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: _today,
      lastDate: DateTime(_futureYearLimit),
    );

    if (picked == null) {
      return;
    }

    onPicked(DateUtils.dateOnly(picked));
  }

  void _handleSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    // TODO: Submit form
  }

  String? _validateNotPast(DateTime? date, String message) {
    if (date == null) {
      return null;
    }
    return _isPastDate(date) ? message : null;
  }

  bool _isPastDate(DateTime date) {
    return DateUtils.dateOnly(date).isBefore(_today);
  }

  String? _formatDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    return '${date.day} ${_getMonthName(date.month)}, ${date.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
