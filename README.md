# Final-Project-MBD Kelompok Oscar

## Kodingan Imam
---
### Query
- [x] Menampilkan list pesanan dan estimasi lama pengirimannya
- [x] Menampilkan list Performa Produksi - selisih antara waktu pesanan masuk dan dikirim
### Procedure
- [ ] Prosedur mengupdate nilai estimasi produksi barang dari rata-rata frekuensi update barang di tabel update
### Function
- [x] Menghitung estimasi lama pengiriman sebuah pesanan berdasarkan estimasi produksi barang yang paling lama dari detail pemesanan
### Sequence
- [x] Sequence ID Pesanan
### Trigger
- [x] After insert,update,delete tabel detail_pesanan, update total_harga di pesanan
---

## Kodingan Rafid
---
### Query
- [x] Menampilkan pesanan selesai dengan range tanggal
- [ ] Menampilkan pendapatan per kategori barang dengan range tanggal
### Procedure
- [x] Prosedur mengatur prioritas pelanggan
### Function
- [ ] menghitung list pendapatan per kategori barang dengan range tanggal
### Sequence
- [x] Sequence ID Jenis pesanan
### Trigger
- [x] Before insert jenis pelanggan, mengatur prioritas pelanggan & ID Jenis Pelanggan otomatis
---
