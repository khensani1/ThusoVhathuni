import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile.dart';
import '../models/clinic_visit.dart';
import '../models/medication.dart';

class _Keys {
  static const profile = 'profile';
  static const visits = 'visits';
  static const meds = 'meds';
}

class UserProfileRepository {
  Future<UserProfile?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_Keys.profile);
    if (raw == null) return null;
    return UserProfile.fromMap(jsonDecode(raw) as Map<String, Object?>);
  }

  Future<UserProfile> upsert(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_Keys.profile, jsonEncode(profile.toMap()));
    return profile;
  }
}

class ClinicVisitRepository {
  Future<List<ClinicVisit>> all() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_Keys.visits) ?? <String>[];
    final list = raw.map((e) => ClinicVisit.fromMap(jsonDecode(e) as Map<String, Object?>)).toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  Future<ClinicVisit> add(ClinicVisit visit) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await all();
    final withId = ClinicVisit(
      id: (existing.isEmpty ? 1 : (existing.first.id ?? existing.length) + 1),
      date: visit.date,
      location: visit.location,
      reason: visit.reason,
    );
    final updated = [withId, ...existing];
    await prefs.setStringList(
      _Keys.visits,
      updated.map((e) => jsonEncode(e.toMap())).toList(),
    );
    return withId;
  }

  Future<void> remove(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await all();
    final updated = existing.where((e) => e.id != id).toList();
    await prefs.setStringList(
      _Keys.visits,
      updated.map((e) => jsonEncode(e.toMap())).toList(),
    );
  }
}

class MedicationRepository {
  Future<List<Medication>> all() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_Keys.meds) ?? <String>[];
    final list = raw.map((e) => Medication.fromMap(jsonDecode(e) as Map<String, Object?>)).toList();
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }

  Future<Medication> add(Medication med) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await all();
    final withId = Medication(
      id: (existing.isEmpty ? 1 : (existing.last.id ?? existing.length) + 1),
      name: med.name,
      dosage: med.dosage,
      frequency: med.frequency,
    );
    final updated = [...existing, withId];
    await prefs.setStringList(
      _Keys.meds,
      updated.map((e) => jsonEncode(e.toMap())).toList(),
    );
    return withId;
  }

  Future<void> remove(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await all();
    final updated = existing.where((e) => e.id != id).toList();
    await prefs.setStringList(
      _Keys.meds,
      updated.map((e) => jsonEncode(e.toMap())).toList(),
    );
  }
}