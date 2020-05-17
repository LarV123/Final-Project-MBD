/* 

Menampilkan pesanan yang sudah ready namun belum dikirim

 */
select p.ID_PESANAN, pl.NAMA_PELANGGAN, p.TANGGAL_PESAN, p.STATUS_PESANAN, p.DISCOUNT_PESANAN, p.TOTAL_HARGA, p.JUMLAH_TERBAYARKAN
    from PESANAN p inner join PELANGGAN pl on p.ID_PELANGGAN = pl.ID_PELANGGAN
    where p.STATUS_PESANAN = 1 and 
    not exists (select pg.ID_PESANAN from PENGIRIMAN pg where pg.ID_PESANAN = p.ID_PESANAN);

/* 

Menampilkan jenis ekspedisi yang paling populer tiap provinsi

 */
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

/* 

Before insert tabel update stock akan mengubah isi stock di tabel barang

 */
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

/* 

Fungsi memeriksa apakah suatu pesanan ready atau tidak

 */
create or replace function FUNC_CHECK_PESANAN_READY(ID_PESANAN_CEK varchar2)
return number
is
    cursor DETAIL_PESANAN is 
        select dp.ID_BARANG as ID_BARANG, dp.KUANTITAS as KUANTITAS
            from DETAIL_PEMESANAN dp
            where dp.ID_PESANAN = ID_PESANAN_CEK;
    SUDAH_DI_BAYAR PESANAN.JUMLAH_TERBAYARKAN%type;
    TOTAL PESANAN.TOTAL_HARGA%type;
    READY_STATUS number;
    CUR_AMOUNT_BARANG BARANG.STOCK%type;
begin
    select p.JUMLAH_TERBAYARKAN, p.TOTAL_HARGA into SUDAH_DI_BAYAR, TOTAL from Pesanan p where p.ID_PESANAN = ID_PESANAN_CEK;
    READY_STATUS := 1;
    if (SUDAH_DI_BAYAR < (TOTAL/2))
    then
        return 0;
    end if;
    for REC_DETAIL_PESANAN in DETAIL_PESANAN
    loop
        select b.STOCK into CUR_AMOUNT_BARANG from BARANG b where b.ID_BARANG = REC_DETAIL_PESANAN.ID_BARANG;
        if CUR_AMOUNT_BARANG < REC_DETAIL_PESANAN.KUANTITAS
        then
            READY_STATUS := 0;
        end if;
    end loop;
    return READY_STATUS;
end;
/

/* 

Prosedur memproses pesanan sesuai dengan prioritas

 */
create or replace procedure PROC_PROSES_PESANAN(TANGGAL_UPDATE DATE)
as
    cursor PESANAN_HANDLE is 
      select p.ID_PESANAN as ID_PESANAN
        from PESANAN p inner join PELANGGAN pl on p.ID_PELANGGAN = pl.ID_PELANGGAN 
        inner join JENIS_PELANGGAN jp on pl.ID_JENIS_PELANGGAN = jp.ID_JENIS_PELANGGAN where p.STATUS_PESANAN = 0
        ORDER BY p.TANGGAL_PESAN ASC, jp.PRIORITAS_PELANGGAN;
    
begin
    for REC_PESANAN in PESANAN_HANDLE
    loop
        if FUNC_CHECK_PESANAN_READY(REC_PESANAN.ID_PESANAN) = 1
        then
            for REC_DETAIL_PESANAN in (select dp.ID_BARANG as ID_BARANG, dp.KUANTITAS as KUANTITAS from DETAIL_PEMESANAN dp where dp.ID_PESANAN = REC_PESANAN.ID_PESANAN)
            loop
                insert into UPDATE_STOCK values (REC_DETAIL_PESANAN.ID_BARANG , null, TANGGAL_UPDATE, 'Kurang', REC_DETAIL_PESANAN.KUANTITAS);
            end loop;
        end if;
    end loop;
end;

/* 

Sequence ID Kategori Barang

 */
create sequence ID_SEQ_BARANG
    minvalue 1
    maxvalue 999999
    start with 1
    increment by 1
    cache 20;