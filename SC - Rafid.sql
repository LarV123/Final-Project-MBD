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
CREATE OR REPLACE PROCEDURE Atur_prioritas_jenis_pelanggan (prio in integer)
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
CREATE SEQUENCE SEQ_ID_Jenis_Pelanggan
    minvalue 1
    maxvalue 999999
    start with 5
    increment by 1
    cache 20;


/* Trigger */
create or replace trigger TRG_BI_INS_JENIS_PELANGGAN
before insert on JENIS_PELANGGAN
for each row
declare
    idbaru number;
begin
    idbaru := SEQ_ID_Jenis_Pelanggan.nextval;
    select 'JL' || idbaru into :new.ID_JENIS_PELANGGAN from dual;
    
    if idbaru != :new.PRIORITAS_PELANGGAN
    then
        Atur_prioritas_jenis_pelanggan(:new.PRIORITAS_PELANGGAN);
    end if;
end;
/
                             
/* Demo 1 */
select * from jenis_pelanggan;
insert into jenis_pelanggan values(null,'jenis ke-5',3);
select * from jenis_pelanggan;
            
/* Demo 2 */
INSERT INTO PESANAN (ID_PESANAN, ID_PELANGGAN, TANGGAL_PESAN, STATUS_PESANAN, DISCOUNT_PESANAN,TOTAL_HARGA, JUMLAH_TERBAYARKAN)  
  select 'P1400', 'PL1', TO_DATE('01/01/2021', 'DD/MM/YYYY'), 1, 0, 0, 0  FROM dual UNION ALL
  select 'P1401', 'PL1', TO_DATE('02/01/2021', 'DD/MM/YYYY'), 1, 0, 0, 0  FROM dual;
  
INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B5', 'P1400', 2, 0, 0  FROM dual UNION ALL 
  select 'B6', 'P1400', 2, 0, 0  FROM dual UNION ALL
  select 'B6', 'P1401', 1, 0, 0  FROM dual;

INSERT INTO PEMBAYARAN (ID_PEMBAYARAN, ID_JENIS_PEMBAYARAN, ID_PESANAN, TANGGAL_PEMBAYARAN, JUMLAH_PEMBAYARAN, KEPERLUAN_PEMBAYARAN)  
  select 'PB1400', 'JP3', 'P1400', TO_DATE('03/01/2021', 'DD/MM/YYYY'), 0, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1401', 'JP6', 'P1401', TO_DATE('04/01/2021', 'DD/MM/YYYY'), 0, 'LUNAS'  FROM dual;

INSERT INTO PENGIRIMAN (ID_PENGIRIMAN, ID_PESANAN, ID_EKSPEDISI, TANGGAL_MENGIRIM, KODE_RESI) 
  select 'PG1400','P1400','JE3',TO_DATE('05/01/2021', 'DD/MM/YYYY'),'3202101031'  FROM dual UNION ALL 
  select 'PG1401','P1401','JE2',TO_DATE('06/01/2021', 'DD/MM/YYYY'),'2202101041'  FROM dual;

select *,HARGA_JUAL-HARGA_PRODUKSI from barang
where ID_BARANG = 'B5' or ID_BARANG = 'B6';

select NAMA_KATEGORI_BARANG, hitung_pendapatan_per_kategori_barang(ID_KATEGORI_BARANG, TO_DATE('03/01/2021', 'DD/MM/YYYY'), TO_DATE('03/01/2021', 'DD/MM/YYYY')) as Pendapatan
from kategori_barang;

select NAMA_KATEGORI_BARANG, hitung_pendapatan_per_kategori_barang(ID_KATEGORI_BARANG, TO_DATE('03/01/2021', 'DD/MM/YYYY'), TO_DATE('04/01/2021', 'DD/MM/YYYY')) as Pendapatan
from kategori_barang;

select NAMA_KATEGORI_BARANG, hitung_pendapatan_per_kategori_barang(ID_KATEGORI_BARANG, TO_DATE('05/01/2021', 'DD/MM/YYYY'), TO_DATE('06/01/2021', 'DD/MM/YYYY')) as Pendapatan
from kategori_barang;

select NAMA_KATEGORI_BARANG, hitung_pendapatan_per_kategori_barang(ID_KATEGORI_BARANG, TO_DATE('01/01/2021', 'DD/MM/YYYY'), TO_DATE('02/01/2021', 'DD/MM/YYYY')) as Pendapatan
from kategori_barang;
