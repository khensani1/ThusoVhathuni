import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/clinic_visit.dart';
import '../models/medication.dart';
import '../services/repositories.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final _visitsRepo = ClinicVisitRepository();
  final _medsRepo = MedicationRepository();

  List<ClinicVisit> _visits = [];
  List<Medication> _meds = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final visits = await _visitsRepo.all();
    final meds = await _medsRepo.all();
    if (!mounted) return;
    setState(() {
      _visits = visits;
      _meds = meds;
    });
  }

  Future<void> _addVisitDialog() async {
    final formKey = GlobalKey<FormState>();
    final dateController = TextEditingController(text: DateTime.now().toIso8601String().substring(0, 10));
    final locationController = TextEditingController();
    final reasonController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Clinic Visit'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: reasonController,
                    decoration: const InputDecoration(labelText: 'Reason'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final visit = ClinicVisit(
                  date: DateTime.parse(dateController.text),
                  location: locationController.text,
                  reason: reasonController.text,
                );
                await _visitsRepo.add(visit);
                if (!mounted) return;
                Navigator.pop(context, true);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await _refresh();
    }
  }

  Future<void> _addMedicationDialog() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final dosageController = TextEditingController();
    final frequencyController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Medication'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: dosageController,
                    decoration: const InputDecoration(labelText: 'Dosage (e.g., 500mg)'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: frequencyController,
                    decoration: const InputDecoration(labelText: 'Frequency (e.g., 2x daily)'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final med = Medication(name: nameController.text, dosage: dosageController.text, frequency: frequencyController.text);
                await _medsRepo.add(med);
                if (!mounted) return;
                Navigator.pop(context, true);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (result == true) {
      await _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tracking'),
        backgroundColor: Colors.orange.shade50,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade50,
              Colors.white,
            ],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Health Progress Charts
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timeline, color: Colors.blue.shade600),
                          const SizedBox(width: 12),
                          Text(
                            'Health Progress This Year',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: true),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text('${value.toInt()}');
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                                    return Text(months[value.toInt() % 6]);
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: true),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  const FlSpot(0, 3),
                                  const FlSpot(1, 1),
                                  const FlSpot(2, 4),
                                  const FlSpot(3, 2),
                                  const FlSpot(4, 5),
                                  const FlSpot(5, 3),
                                ],
                                isCurved: true,
                                color: Colors.blue,
                                barWidth: 3,
                                belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.1)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _ChartLegend(color: Colors.blue, label: 'Blood Sugar'),
                          _ChartLegend(color: Colors.red, label: 'Blood Pressure'),
                          _ChartLegend(color: Colors.green, label: 'Weight'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: ExpansionTile(
                  leading: const Icon(Icons.local_hospital),
                  title: const Text('Clinic Visits'),
                  subtitle: Text(_visits.isEmpty ? 'No visits yet' : '${_visits.length} visit(s)'),
                  children: [
                    for (final v in _visits)
                      Dismissible(
                        key: ValueKey('visit-${v.id}-${v.date.toIso8601String()}'),
                        background: Container(color: Colors.redAccent),
                        onDismissed: (_) async {
                          if (v.id != null) {
                            await _visitsRepo.remove(v.id!);
                            await _refresh();
                          }
                        },
                        child: ListTile(
                          title: Text('${v.location} — ${v.date.toIso8601String().substring(0, 10)}'),
                          subtitle: Text(v.reason),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: _addVisitDialog,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Visit'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: ExpansionTile(
                  leading: const Icon(Icons.medication),
                  title: const Text('Medications'),
                  subtitle: Text(_meds.isEmpty ? 'No medications yet' : '${_meds.length} medication(s)'),
                  children: [
                    for (final m in _meds)
                      Dismissible(
                        key: ValueKey('med-${m.id}-${m.name}'),
                        background: Container(color: Colors.redAccent),
                        onDismissed: (_) async {
                          if (m.id != null) {
                            await _medsRepo.remove(m.id!);
                            await _refresh();
                          }
                        },
                        child: ListTile(
                          title: Text(m.name),
                          subtitle: Text('${m.dosage} • ${m.frequency}'),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: _addMedicationDialog,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Medication'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}


