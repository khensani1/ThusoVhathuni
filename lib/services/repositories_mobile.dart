import 'package:sqflite/sqflite.dart';

import '../models/user_profile.dart';
import '../models/clinic_visit.dart';
import '../models/medication.dart';
import 'local_db.dart';

class UserProfileRepository {
  Future<UserProfile?> getProfile() async {
    final db = await LocalDatabaseService().database;
    final rows = await db.query('user_profile', limit: 1);
    if (rows.isEmpty) return null;
    return UserProfile.fromMap(rows.first);
  }

  Future<UserProfile> upsert(UserProfile profile) async {
    final db = await LocalDatabaseService().database;
    if (profile.id == null) {
      final id = await db.insert('user_profile', profile.toMap()..remove('id'));
      return profile.copyWith(id: id);
    }
    await db.update('user_profile', profile.toMap(), where: 'id = ?', whereArgs: [profile.id]);
    return profile;
  }
}

class ClinicVisitRepository {
  Future<List<ClinicVisit>> all() async {
    final db = await LocalDatabaseService().database;
    final rows = await db.query('clinic_visit', orderBy: 'date DESC');
    return rows.map((e) => ClinicVisit.fromMap(e)).toList();
  }

  Future<ClinicVisit> add(ClinicVisit visit) async {
    final db = await LocalDatabaseService().database;
    final id = await db.insert('clinic_visit', visit.toMap()..remove('id'));
    return ClinicVisit(
      id: id,
      date: visit.date,
      location: visit.location,
      reason: visit.reason,
    );
  }

  Future<void> remove(int id) async {
    final db = await LocalDatabaseService().database;
    await db.delete('clinic_visit', where: 'id = ?', whereArgs: [id]);
  }
}

class MedicationRepository {
  Future<List<Medication>> all() async {
    final db = await LocalDatabaseService().database;
    final rows = await db.query('medication', orderBy: 'name');
    return rows.map((e) => Medication.fromMap(e)).toList();
  }

  Future<Medication> add(Medication med) async {
    final db = await LocalDatabaseService().database;
    final id = await db.insert('medication', med.toMap()..remove('id'));
    return Medication(id: id, name: med.name, dosage: med.dosage, frequency: med.frequency);
  }

  Future<void> remove(int id) async {
    final db = await LocalDatabaseService().database;
    await db.delete('medication', where: 'id = ?', whereArgs: [id]);
  }
}


