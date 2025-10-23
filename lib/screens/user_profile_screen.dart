import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../services/repositories.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _repo = UserProfileRepository();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _conditionController = TextEditingController(text: 'diabetes');

  UserProfile? _existing;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final profile = await _repo.getProfile();
    if (!mounted) return;
    setState(() {
      _existing = profile;
      if (profile != null) {
        _nameController.text = profile.fullName;
        _ageController.text = profile.age.toString();
        _conditionController.text = profile.condition;
      }
      _loading = false;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final age = int.tryParse(_ageController.text);
    if (age == null) return;
    final profile = UserProfile(
      id: _existing?.id,
      fullName: _nameController.text.trim(),
      age: age,
      condition: _conditionController.text.trim(),
    );
    await _repo.upsert(profile);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                      validator: (v) => (v == null || int.tryParse(v) == null) ? 'Enter a valid age' : null,
                    ),
                    TextFormField(
                      controller: _conditionController,
                      decoration: const InputDecoration(labelText: 'Primary Condition'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(onPressed: _save, child: const Text('Save')),
                  ],
                ),
              ),
            ),
    );
  }
}


