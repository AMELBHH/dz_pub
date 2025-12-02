// dynamic_form_widget.dart
import 'dart:io';
import 'package:dz_pub/view/common_widgets/dynamic_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnFormChanged = void Function(Map<String, dynamic> values, Map<String, File> files);

class DynamicForm extends StatefulWidget {
  final List<DynamicField> fields;
  final OnFormChanged? onChanged;

  const DynamicForm({Key? key, required this.fields, this.onChanged}) : super(key: key);

  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, String?> _dropdownValues = {};
  final Map<String, Set<String>> _multiselectValues = {};
  final Map<String, List<Map<String, dynamic>>> _arrayValues = {}; // for array type
  final Map<String, File> _files = {};

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    for (final f in widget.fields) {
      if (f.type == 'text' || f.type == 'number' || f.type == 'email') {
        _textControllers[f.id] = TextEditingController();
      } else if (f.type == 'dropdown') {
        _dropdownValues[f.id] = null;
      } else if (f.type == 'multiselect') {
        _multiselectValues[f.id] = {};
      } else if (f.type == 'array') {
        _arrayValues[f.id] = []; // starts empty
      }
    }
  }

  @override
  void dispose() {
    for (final c in _textControllers.values) c.dispose();
    super.dispose();
  }

  void _notify() {
    final Map<String, dynamic> values = {};
    final Map<String, File> files = Map.from(_files);

    // collect text
    _textControllers.forEach((k, controller) {
      if (controller.text.isNotEmpty) values[k] = controller.text;
    });

    // dropdowns
    _dropdownValues.forEach((k, v) {
      if (v != null) values[k] = v;
    });

    // multiselect - turn set into list of ids
    _multiselectValues.forEach((k, set) {
      if (set.isNotEmpty) values[k] = set.toList();
    });

    // arrays
    _arrayValues.forEach((k, list) {
      if (list.isNotEmpty) {
        // If array item is object or simple value - we stored object maps or simple map with 'value'
        final transformed = list.map((m) {
          if (m.containsKey('value')) return m['value'];
          return m; // object map
        }).toList();
        values[k] = transformed;
      }
    });

    widget.onChanged?.call(values, files);
  }

  Future<void> _pickFile(String fieldId) async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    setState(() {
      _files[fieldId] = File(picked.path);
    });
    _notify();
  }

  Widget _buildField(DynamicField f) {
    switch (f.type) {
      case 'text':
      case 'number':
      case 'email':
        return TextFormField(
          controller: _textControllers[f.id],
          keyboardType: f.type == 'number' ? TextInputType.number : (f.type == 'email' ? TextInputType.emailAddress : TextInputType.text),
          decoration: InputDecoration(labelText: f.label),
          onChanged: (_) => _notify(),
        );
      case 'dropdown':
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(labelText: f.label),
          value: _dropdownValues[f.id],
          items: (f.options ?? []).map((o) => DropdownMenuItem(value: o.id, child: Text(o.label))).toList(),
          onChanged: (v) {
            setState(() => _dropdownValues[f.id] = v);
            _notify();
          },
        );
      case 'multiselect':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(f.label, style: TextStyle(fontWeight: FontWeight.w600)),
            ...(f.options ?? []).map((opt) {
              final selected = _multiselectValues[f.id]?.contains(opt.id) ?? false;
              return CheckboxListTile(
                title: Text(opt.label),
                value: selected,
                onChanged: (b) {
                  setState(() {
                    if (b == true) _multiselectValues[f.id]?.add(opt.id);
                    else _multiselectValues[f.id]?.remove(opt.id);
                  });
                  _notify();
                },
              );
            })
          ],
        );
      case 'file':
        final has = _files.containsKey(f.id);
        return Row(
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.upload_file),
              label: Text(has ? 'Change ${f.label}' : 'Upload ${f.label}'),
              onPressed: () => _pickFile(f.id),
            ),
            if (has) SizedBox(width: 8),
            if (has) Text('selected'),
          ],
        );
      case 'array':
      // simple array of values: we build repeatable text fields
        final items = _arrayValues[f.id]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(f.label, style: TextStyle(fontWeight: FontWeight.w600)),
            ...List.generate(items.length, (i) {
              final valueController = items[i]['controller'] as TextEditingController;
              return Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: valueController,
                    decoration: InputDecoration(labelText: '${f.label} ${i + 1}'),
                    onChanged: (_) => _notify(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      items.removeAt(i);
                    });
                    _notify();
                  },
                )
              ]);
            }),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: Icon(Icons.add),
                label: Text('Add ${f.label}'),
                onPressed: () {
                  setState(() {
                    final c = TextEditingController();
                    _arrayValues[f.id]!.add({'value': null, 'controller': c});
                    c.addListener(() {
                      // sync value
                      final idx = _arrayValues[f.id]!.indexWhere((m) => m['controller'] == c);
                      if (idx >= 0) _arrayValues[f.id]![idx]['value'] = c.text;
                      _notify();
                    });
                  });
                },
              ),
            )
          ],
        );
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.fields.map((f) => Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: _buildField(f))).toList(),
    );
  }
}
