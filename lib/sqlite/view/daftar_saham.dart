import 'package:flutter/material.dart';
import '../dao/saham.dart';
import '../query/saham_handler.dart';

class DaftarSaham extends StatefulWidget {
  const DaftarSaham({super.key});

  @override
  State<DaftarSaham> createState() => _DaftarSahamState();
}

class _DaftarSahamState extends State<DaftarSaham> {
  final SahamQueryHandler _handler = SahamQueryHandler();
  List<Saham> _daftarSaham = [];
  bool _isLoading = true;
  bool _sudahDiisi = false;

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  Future<void> _muatData() async {
    setState(() => _isLoading = true);

    // Isi data jika belum ada
    if (!_sudahDiisi) {
      final existing = await _handler.ambilSemuaSaham();
      if (existing.isEmpty) {
        await _handler.isiDataSaham();
        _sudahDiisi = true;
      }
    }

    final data = await _handler.ambilSemuaSaham();
    setState(() {
      _daftarSaham = data;
      _isLoading = false;
    });
  }

  Color _warnaChange(double change) {
    if (change > 0) return Colors.green;
    if (change < 0) return Colors.red;
    return Colors.grey;
  }

  IconData _ikonChange(double change) {
    if (change > 0) return Icons.arrow_drop_up;
    if (change < 0) return Icons.arrow_drop_down;
    return Icons.remove;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Saham'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _muatData,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _daftarSaham.isEmpty
              ? const Center(child: Text('Tidak ada data saham.'))
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: _daftarSaham.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final saham = _daftarSaham[index];
                    final wanra = _warnaChange(saham.change);
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            // Ticker badge
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Colors.blue[800],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  saham.ticker,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Info harga
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Last: ${saham.last}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(_ikonChange(saham.change),
                                              color: wanra, size: 22),
                                          Text(
                                            '${saham.change > 0 ? '+' : ''}${saham.change}%',
                                            style: TextStyle(
                                              color: wanra,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      _infoChip('Open', saham.open),
                                      const SizedBox(width: 12),
                                      _infoChip('High', saham.high),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _infoChip(String label, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: Colors.grey)),
        Text(value.toString(),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
