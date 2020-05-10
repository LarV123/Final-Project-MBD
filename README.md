# Final-Project-MBD Kelompok Oscar

## Kodingan Imam
---
### Query
- Menampilkan list pesanan dan estimasi lama pengirimannya
- Menampilkan list Performa Produksi - selisih antara waktu pesanan masuk dan dikirim
### Procedure
- Prosedur mengupdate nilai estimasi produksi barang dari rata-rata frekuensi update barang di tabel update
### Function
- Menghitung estimasi lama pengiriman sebuah pesanan berdasarkan estimasi produksi barang yang paling lama dari detail pemesanan
### Sequence
- Sequence ID Pesanan
### Trigger
- After insert,update,delete tabel detail_pesanan, update total_harga di pesanan

---
