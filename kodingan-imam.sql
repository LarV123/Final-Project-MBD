CREATE OR REPLACE FUNCTION estimasi_lama_pengiriman(id varchar2)
return number
as
    retval number;
begin
    select max(b.estimasi_produksi)
    into retval
    from detail_pemesanan dp, barang b
    where dp.id_pesanan = id
    and b.id_barang = dp.id_barang;
end;
/

create sequence id_pesanan_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger AIUD_PESANAN_TOTAL_HARGA
after insert,update,delete on detail_pemesanan
AS
    newtotal_harga number;
begin
	select sum(subtotal * discount_barang)
        into newtotal_harga
        from detail_pemesanan dp
        where :new.id_pesanan = dp.id_pesanan;
    update pesanan
        set total_harga=newtotal_harga
        where :new.id_pesanan = id_pesanan;
end;
/

-- Create or replace procedure UPDATE_ESTIMASI
-- AS
-- 	cursor update_bar
--     is
--         select b.id_barang, us.Tanggal_update
--             from barang b, update_stock us
--             where b.id_barang = us.id_barang
--             and us.tipe_update = 'Tambah';
--     newestimate number;
-- begin
	
-- END;
-- /

select p.id_pesanan, estimasi_lama_pengiriman(p.id_pesanan)
    from pesanan p

select p.id_pesanan, DATEDIFF(day,p.Tanggal_pesan,pr.Tanggal_mengirim)
    drom pesanan p, pengiriman pr