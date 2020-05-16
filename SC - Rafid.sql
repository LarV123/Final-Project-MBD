/* Select 1 (Pesanan selesai) */
select ps.ID_PESANAN, pl.NAMA_PELANGGAN, pl.ALAMAT_PELANGGAN, kk.NAMA_KABUPATEN, ps.TANGGAL_PESAN, pb.TANGGAL_PEMBAYARAN, pg.TANGGAL_MENGIRIM, pg.KODE_RESI, ps.JUMLAH_TERBAYARKAN
from pelanggan pl, KOTA_KABUPATEN kk, pesanan ps, pengiriman pg, pembayaran pb
where ps.ID_PESANAN = pg.ID_PESANAN
    and ps.ID_PESANAN = pb.ID_PESANAN
    and ps.ID_PELANGGAN = pl.ID_PELANGGAN
    and pl.ID_KABUPATEN = kk.ID_KABUPATEN
    and pg.TANGGAL_MENGIRIM >= TO_DATE('08/08/2019', 'DD/MM/YYYY')
    and pg.TANGGAL_MENGIRIM <= TO_DATE('08/09/2019', 'DD/MM/YYYY')
order by TANGGAL_PESAN asc;


/* Select 2 (pendapatan per kategori barang) */
select NAMA_KATEGORI_BARANG, hitung_pendapatan_per_kategori_barang(ID_KATEGORI_BARANG, TO_DATE('08/08/2019', 'DD/MM/YYYY'), TO_DATE('09/08/2019', 'DD/MM/YYYY')) as Pendapatan
from kategori_barang;


/* Procedure */
create or replace procedure Atur_prioritas_jenis_pelanggan (prio in integer)
as
    cursor cur
    is
        select ID_JENIS_PELANGGAN, PRIORITAS_PELANGGAN
        from JENIS_PELANGGAN
        where PRIORITAS_PELANGGAN >= prio;
begin
    for baris in cur
    loop
        update JENIS_PELANGGAN
            set JENIS_PELANGGAN.PRIORITAS_PELANGGAN = (baris.PRIORITAS_PELANGGAN + 1)
        where baris.ID_JENIS_PELANGGAN = JENIS_PELANGGAN.ID_JENIS_PELANGGAN;
    end loop;
end;
/


/* Function */
CREATE OR REPLACE FUNCTION hitung_pendapatan_per_kategori_barang(idkb varchar2, awal date, akhir date)
return number
as
    retval number;
begin
    select SUM(dp.kuantitas*(b.HARGA_JUAL-b.HARGA_PRODUKSI))
        into retval
    from pembayaran pb, DETAIL_PEMESANAN dp, barang b
    where pb.TANGGAL_PEMBAYARAN >= awal
        and pb.TANGGAL_PEMBAYARAN <= akhir
        and pb.ID_PESANAN = dp.ID_PESANAN
        and dp.ID_BARANG = b.ID_BARANG
        and b.ID_KATEGORI_BARANG = idkb;
        
    return retval;
end;
/


/* Sequence */
create sequence SEQ_ID_Jenis_Pelanggan
    minvalue 1
    maxvalue 999999
    start with 5
    increment by 1
    cache 20;


/* Trigger */
create or replace trigger TRG_BI_INS_JENIS_PELANGGAN
before insert on JENIS_PELANGGAN
for each row
begin
    select 'JP' || SEQ_ID_Jenis_Pelanggan.nextval into :new.ID_JENIS_PELANGGAN from dual;
    Atur_prioritas_jenis_pelanggan(:new.PRIORITAS_PELANGGAN);
end;
/
