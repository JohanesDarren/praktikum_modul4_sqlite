import 'package:flutter/material.dart';
import 'koneksi.dart';
import 'read_data.dart';
import 'saham.dart';

class InputSaham extends StatefulWidget {
  const InputSaham({super.key});

  @override
  State<InputSaham> createState() => _InputSahamState();
}

class _InputSahamState extends State<InputSaham> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tickerController = TextEditingController();
  final TextEditingController _openController = TextEditingController();
  final TextEditingController _highController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _changeController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _tickerController.dispose();
    _openController.dispose();
    _highController.dispose();
    _lastController.dispose();
    _changeController.dispose();
    super.dispose();
  }

  String? _requiredText(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label wajib diisi';
    }
    return null;
  }

  String? _requiredInt(String? value, String label) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return '$label wajib diisi';
    }
    if (int.tryParse(text) == null) {
      return '$label harus berupa angka bulat';
    }
    return null;
  }

  String? _requiredDouble(String? value, String label) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return '$label wajib diisi';
    }
    if (double.tryParse(text) == null) {
      return '$label harus berupa angka desimal';
    }
    return null;
  }

  Future<void> _simpanSaham() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final saham = Saham(
        ticker: _tickerController.text.trim().toUpperCase(),
        open: int.parse(_openController.text.trim()),
        high: int.parse(_highController.text.trim()),
        last: int.parse(_lastController.text.trim()),
        change: double.parse(_changeController.text.trim()),
      );

      await SahamQueryHandler().tambahSaham(saham);

      _tickerController.clear();
      _openController.clear();
      _highController.clear();
      _lastController.clear();
      _changeController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data saham berhasil disimpan')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menyimpan data saham')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Saham'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tickerController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Ticker',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _requiredText(value, 'Ticker'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _openController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Open',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _requiredInt(value, 'Open'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _highController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'High',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _requiredInt(value, 'High'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _lastController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Last',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _requiredInt(value, 'Last'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _changeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Change',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _requiredDouble(value, 'Change'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isSaving ? null : _simpanSaham,
                child: _isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Simpan Saham'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListSaham()),
                  );
                },
                child: const Text('Lihat Saham'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
