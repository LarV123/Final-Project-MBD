select p.ID_PESANAN, pl.NAMA_PELANGGAN, p.TANGGAL_PESAN, p.STATUS_PESANAN, p.DISCOUNT_PESANAN, p.TOTAL_HARGA, p.JUMLAH_TERBAYARKAN
    from PESANAN p inner join PELANGGAN pl on p.ID_PELANGGAN = pl.ID_PELANGGAN
    where p.STATUS_PESANAN = 1 and 
    not exists (select pg.ID_PESANAN from PENGIRIMAN pg where pg.ID_PESANAN = p.ID_PESANAN);

create or replace view JENIS_EKSPEDISI_PER_PROVINSI as select p.ID_PROVINSI, pg.ID_EKSPEDISI, count(*) as P_COUNT
    from PENGIRIMAN pg inner join PESANAN ps on pg.ID_PESANAN = ps.ID_PESANAN inner join PELANGGAN pl on ps.ID_PELANGGAN = pl.ID_PELANGGAN 
    inner join KOTA_KABUPATEN kk on pl.ID_KABUPATEN = kk.ID_KABUPATEN
    inner join PROVINSI p on kk.ID_PROVINSI = p.ID_PROVINSI
    GROUP BY ID_PROVINSI, pg.ID_EKSPEDISI;

create or replace view MAX_PER_PROVINSI as select ID_PROVINSI, max(P_COUNT) as VAL
    from JENIS_EKSPEDISI_PER_PROVINSI
    GROUP BY ID_PROVINSI;

select jepp.ID_PROVINSI, jepp.ID_EKSPEDISI
    from JENIS_EKSPEDISI_PER_PROVINSI jepp inner join
    MAX_PER_PROVINSI mpp on jepp.ID_PROVINSI = mpp.ID_PROVINSI where jepp.P_COUNT = mpp.VAL;

create or replace trigger TRG_UPDATE_STOCK
before insert on UPDATE_STOCK
for each row
begin
    if (:new.TIPE_UPDATE = 'Tambah')
    then
        update BARANG set STOCK = STOCK + :new.JUMLAH_UPDATE where ID_BARANG = :new.ID_BARANG;
    elsif (:new.TIPE_UPDATE = 'Kurang') then
        update BARANG set STOCK = STOCK - :new.JUMLAH_UPDATE where ID_BARANG = :new.ID_BARANG;
    end if;
end;
/

create sequence ID_SEQ_BARANG
    minvalue 1
    maxvalue 999999
    start with 1
    increment by 1
    cache 20;