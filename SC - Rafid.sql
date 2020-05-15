/* Select 1 (Pesanan selesai) */
select ps.ID_PESANAN, pl.NAMA_PELANGGAN, pl.ALAMAT_PELANGGAN, kk.NAMA_KABUPATEN, ps.TANGGAL_PESAN, pg.TANGGAL_MENGIRIM, pg.KODE_RESI, ps.JUMLAH_TERBAYARKAN
from pelanggan pl, KOTA_KABUPATEN kk, pesanan ps, pengiriman pg, pembayaran pb
where ps.ID_PESANAN = pg.ID_PESANAN
    and ps.ID_PESANAN = pb.ID_PESANAN
    and ps.ID_PELANGGAN = pl.ID_PELANGGAN
    and pl.ID_KABUPATEN = kk.ID_KABUPATEN
    and pg.TANGGAL_MENGIRIM >= TO_DATE('08/08/2019', 'DD/MM/YYYY')
    and pg.TANGGAL_MENGIRIM <= TO_DATE('08/09/2019', 'DD/MM/YYYY');


/* Select 2 (pendapatan per kategori barang) */


/* Procedure */
create or replace procedure Atur_prioritas_jenis_pelanggan (prio in integer)
as
    cursor cur
    is
        select ID_JENIS_PELANGGAN as idjp, PRIORITAS_PELANGGAN as pr
        from JENIS_PELANGGAN
        where PRIORITAS_PELANGGAN >= prio;
begin
    for baris in cur
    loop
        update JENIS_PELANGGAN
            set JENIS_PELANGGAN.PRIORITAS_PELANGGAN = (baris.pr + 1)
        where baris.idjp = JENIS_PELANGGAN.ID_JENIS_PELANGGAN;
    end loop;
end;
/


/* Function */


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
