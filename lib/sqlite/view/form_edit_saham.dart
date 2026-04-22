import 'package:flutter/material.dart';
import '../dao/saham.dart';
import '../query/saham_handler.dart';

class FormEditSaham extends StatefulWidget {
  final Saham saham;

  const FormEditSaham({super.key, required this.saham});

  @override
  State<FormEditSaham> createState() => _FormEditSahamState();
}

class _FormEditSahamState extends State<FormEditSaham> {
  late TextEditingController _tickerController;
  late TextEditingController _openController;
  late TextEditingController _highController;
  late TextEditingController _lastController;
  late TextEditingController _changeController;

  final SahamQueryHandler _handler = SahamQueryHandler();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tickerController = TextEditingController(text: widget.saham.ticker);
    _openController = TextEditingController(text: widget.saham.open.toString());
    _highController = TextEditingController(text: widget.saham.high.toString());
    _lastController = TextEditingController(text: widget.saham.last.toString());
    _changeController = TextEditingController(
      text: widget.saham.change.toString(),
    );
  }

  @override
  void dispose() {
    _tickerController.dispose();
    _openController.dispose();
    _highController.dispose();
    _lastController.dispose();
    _changeController.dispose();
    super.dispose();
  }

  Future<void> _updateSaham() async {
    if (!_validateForm()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedSaham = Saham(
        tickerid: widget.saham.tickerid,
        ticker: _tickerController.text.trim(),
        open: int.parse(_openController.text),
        high: int.parse(_highController.text),
        last: int.parse(_lastController.text),
        change: double.parse(_changeController.text),
      );

      await _handler.updateSaham(updatedSaham);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data saham berhasil diupdate!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _validateForm() {
    if (_tickerController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticker tidak boleh kosong')),
      );
      return false;
    }

    try {
      int.parse(_openController.text);
      int.parse(_highController.text);
      int.parse(_lastController.text);
      double.parse(_changeController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pastikan semua field numeric valid')),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Saham'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Ticker field
              TextField(
                controller: _tickerController,
                decoration: InputDecoration(
                  labelText: 'Ticker',
                  hintText: 'Masukkan kode ticker saham',
                  prefixIcon: const Icon(Icons.info),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabled: !_isLoading,
                ),
              ),
              const SizedBox(height: 16),

              // Open field
              TextField(
                controller: _openController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Open',
                  hintText: 'Harga pembukaan',
                  prefixIcon: const Icon(Icons.trending_up),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabled: !_isLoading,
                ),
              ),
              const SizedBox(height: 16),

              // High field
              TextField(
                controller: _highController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'High',
                  hintText: 'Harga tertinggi',
                  prefixIcon: const Icon(Icons.arrow_upward),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabled: !_isLoading,
                ),
              ),
              const SizedBox(height: 16),

              // Last field
              TextField(
                controller: _lastController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Last',
                  hintText: 'Harga terakhir',
                  prefixIcon: const Icon(Icons.monetization_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabled: !_isLoading,
                ),
              ),
              const SizedBox(height: 16),

              // Change field
              TextField(
                controller: _changeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Change (%)',
                  hintText: 'Persentase perubahan',
                  prefixIcon: const Icon(Icons.percent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabled: !_isLoading,
                ),
              ),
              const SizedBox(height: 24),

              // Button row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed:
                          _isLoading ? null : () => Navigator.pop(context),
                      icon: const Icon(Icons.cancel),
                      label: const Text('Batal'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.grey[400],
                        foregroundColor: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _updateSaham,
                      icon:
                          _isLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : const Icon(Icons.save),
                      label: Text(_isLoading ? 'Menyimpan...' : 'Simpan'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.green[600],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
