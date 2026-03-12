import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/theme/app_theme.dart';

enum InputType { text, multiline, dropdown, date, image }

class TaskInputWidget extends StatelessWidget {
  final String label;
  final String? value;
  final String? hint;
  final InputType type;
  final IconData? icon;
  final Widget? leading;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<PlatformFile>? onFilePicked;
  final List<String>? options;
  final Widget? trailing;
  final Widget? dropdownIcon;
  final bool isRequired;
  final String? validationMessage;
  final FormFieldValidator<String>? validator;
  final Color? backgroundColor;

  const TaskInputWidget({
    super.key,
    required this.label,
    required this.type,
    this.value,
    this.icon,
    this.leading,
    this.onTap,
    this.onChanged,
    this.onFilePicked,
    this.options,
    this.trailing,
    this.dropdownIcon,
    this.hint,
    this.isRequired = false,
    this.validationMessage,
    this.validator,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == InputType.date) {
          onTap?.call();
        } else if (type == InputType.image && onTap == null) {
          _pickFileAndNotify(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xffF4F4F6),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: AppTheme.themeBlack.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null || icon != null)
              LeadingIconWidget(leading: leading, icon: icon),
            if (leading != null || icon != null) const SizedBox(width: 14),
            Expanded(child: _buildField()),
            if (_buildTrailing(context) != null) _buildTrailing(context)!,
          ],
        ),
      ),
    );
  }

  Widget _buildField() {
    final fieldValidator = _buildValidator();

    return switch (type) {
      InputType.text => TextInputWidget(
        label: label,
        initialValue: value,
        onChanged: onChanged,
        validator: fieldValidator,
      ),
      InputType.multiline => MultilineInputWidget(
        label: label,
        initialValue: value,
        onChanged: onChanged,
        validator: fieldValidator,
      ),
      InputType.dropdown => SelectableFormField(
        key: ValueKey('dropdown-$label-$value'),
        label: label,
        value: value,
        hint: hint,
        validator: fieldValidator,
      ),
      InputType.date => SelectableFormField(
        key: ValueKey('date-$label-$value'),
        label: label,
        value: value,
        hint: hint,
        validator: fieldValidator,
      ),
      InputType.image => SelectableFormField(
        key: ValueKey('image-$label-$value'),
        label: label,
        value: value,
        hint: hint,
        validator: fieldValidator,
      ),
    };
  }

  FormFieldValidator<String>? _buildValidator() {
    if (!isRequired && validator == null) {
      return null;
    }

    return (input) {
      final currentValue = (input ?? value ?? '').trim();
      final placeholder = (hint ?? '').trim();

      if (isRequired) {
        final isPlaceholderSelected =
            placeholder.isNotEmpty && currentValue == placeholder;
        if (currentValue.isEmpty || isPlaceholderSelected) {
          return validationMessage ?? '$label is required';
        }
      }

      return validator?.call(input);
    };
  }

  Widget? _buildTrailing(BuildContext context) {
    if (type == InputType.dropdown) {
      final itemOptions = options ?? const <String>[];
      final hasOptions = itemOptions.isNotEmpty;

      return PopupMenuButton<String>(
        tooltip: "Select $label",
        enabled: hasOptions,
        icon: dropdownIcon ?? const Icon(Icons.keyboard_arrow_down),
        onSelected: onChanged,
        itemBuilder: (context) => itemOptions
            .map(
              (option) => PopupMenuItem<String>(
                value: option,
                child: Row(
                  children: [
                    Expanded(child: Text(option)),
                    if (option == value)
                      const Icon(Icons.check, color: AppTheme.themeLightLavender, size: 18),
                  ],
                ),
              ),
            )
            .toList(),
      );
    }

    if (type == InputType.image && trailing == null) {
      return TextButton(
        onPressed: () => _pickFileAndNotify(context),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              AppTheme.themeLightLavender.withValues(alpha: 0.1),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            ),
          ),
        child: const Text("Change Logo"),
      );
    }

    return trailing;
  }

  Future<void> _pickFileAndNotify(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['png', 'jpg', 'jpeg', 'svg', 'pdf'],
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final file = result.files.first;
      onChanged?.call(file.name);
      onFilePicked?.call(file);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not pick file. Please try again.'),
          ),
        );
      }
    }
  }
}

class TextInputWidget extends StatelessWidget {
  final String label;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const TextInputWidget({
    super.key,
    required this.label,
    this.initialValue,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        TextFormField(
          initialValue: initialValue,
          decoration: const InputDecoration(border: InputBorder.none),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class MultilineInputWidget extends StatelessWidget {
  final String label;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const MultilineInputWidget({
    super.key,
    required this.label,
    this.initialValue,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        TextFormField(
          initialValue: initialValue,
          maxLines: 4,
          decoration: const InputDecoration(border: InputBorder.none),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class SelectableFormField extends StatelessWidget {
  final String label;
  final String? value;
  final String? hint;
  final FormFieldValidator<String>? validator;

  const SelectableFormField({
    super.key,
    required this.label,
    this.value,
    this.hint,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: value,
      validator: validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableInputWidget(label: label, value: value, hint: hint),
            if (field.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class SelectableInputWidget extends StatelessWidget {
  final String label;
  final String? value;
  final String? hint;

  const SelectableInputWidget({
    super.key,
    required this.label,
    this.value,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = (value ?? '').trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        Text(
          hasValue ? value! : (hint ?? ''),
          style: TextStyle(
            fontSize: 18,
            fontWeight: hasValue ? FontWeight.w600 : FontWeight.w400,
            color: hasValue ? Colors.black : Colors.black45,
          ),
        ),
      ],
    );
  }
}

// Widget for displaying icon/leading content in TaskInput
class LeadingIconWidget extends StatelessWidget {
  final Widget? leading;
  final IconData? icon;

  const LeadingIconWidget({super.key, this.leading, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: leading ?? Icon(icon, color: Colors.purple)),
    );
  }
}
