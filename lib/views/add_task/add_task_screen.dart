import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list/theme/app_theme.dart';
import 'package:todo_list/utils/widgets/app_background_widget.dart';
import 'package:todo_list/utils/widgets/appbar_widget.dart';
import 'package:todo_list/utils/widgets/task_input_widget.dart';


class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
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
      // backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(
        title: 'Add Project',
        showBackButton: true,
      ),
      body: AppBackground(
        blobs: [
          GradientBlob(color: const Color(0xFFEDF046), topFraction: 0.20, rightFraction: -0.30),
          GradientBlob(color: const Color(0xFF46F080), topFraction: -0.15,  leftFraction:  -0.30),
          GradientBlob(color: const Color(0xFF2555FF), bottomFraction: -0.15,  rightFraction: -0.30),
          GradientBlob(color: const Color(0xFF46BDF0), bottomFraction: 0.15,  leftFraction:  -0.35),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 100, left: 24, right: 24, bottom: 16),
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
      ),
    );
  }

  Widget _buildGroupInput() {
    return TaskInputWidget(
      label: 'Task Group',
      value: _group,
      hint: 'Select a group',
      backgroundColor: AppTheme.themeWhite,
      leading: SvgPicture.asset(
        'assets/icons/briefcase_icon.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(AppTheme.themeSoftPink, BlendMode.srcIn),
      ),
      type: InputType.dropdown,
      options: _groupOptions,
      isRequired: true,
      validationMessage: 'Please select a task group',
      dropdownIcon: SvgPicture.asset(
        'assets/icons/arrow_down_icon.svg',
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
    return const TaskInputWidget(
      label: 'Project Name',
      type: InputType.text,
      isRequired: true,
      validationMessage: 'Project name is required',
      backgroundColor: AppTheme.themeWhite,
    );
  }

  Widget _buildDescriptionInput() {
    return const TaskInputWidget(
      label: 'Description',
      type: InputType.multiline,
      isRequired: true,
      validationMessage: 'Please add a short description',
      backgroundColor: AppTheme.themeWhite,
    );
  }

  Widget _buildStartDateInput() {
    return TaskInputWidget(
      label: 'Start Date',
      leading: SvgPicture.asset(
        'assets/icons/calendar_icon.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(AppTheme.themeLightLavender, BlendMode.srcIn),
      ),
      value: _formatDate(_startDate),
      backgroundColor: AppTheme.themeWhite,
      hint: 'Select start date',
      type: InputType.date,
      isRequired: true,
      validationMessage: 'Please select a start date',
      validator: (_) =>
          _validateNotPast(_startDate, 'Start date cannot be in the past'),
      trailing: SvgPicture.asset(
        'assets/icons/arrow_down_icon.svg',
        width: 14,
        height: 14
    ),
    //   dropdownIcon: SvgPicture.asset(
    //     'assets/icons/arrow_down_icon.svg',
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
    return TaskInputWidget(
      label: 'End Date',
      leading: SvgPicture.asset(
        'assets/icons/calendar_icon.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(AppTheme.themeLightLavender, BlendMode.srcIn),
      ),
      value: _formatDate(_endDate),
      hint: 'Select end date',
      type: InputType.date,
      isRequired: true,
      validationMessage: 'Please select an end date',
      backgroundColor: AppTheme.themeWhite,
      validator: (_) =>
          _validateNotPast(_endDate, 'End date cannot be in the past'),
      trailing: SvgPicture.asset(
          'assets/icons/arrow_down_icon.svg',
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
    return TaskInputWidget(
      label: 'Project Logo',
      type: InputType.image,
      value: _taskLogoName,
      hint: 'No logo selected',
      isRequired: true,
      validationMessage: 'Please pick a logo or file',
      backgroundColor: AppTheme.themeWhite,
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
          backgroundColor: AppTheme.themeLavender,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(_submitLabel, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
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
