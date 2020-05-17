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
    return retval;
end;
/

-- ini harusnya ngikutin yang udah ada di pesanan.sql sih
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
before insert or update or delete on detail_pemesanan
for each row
DECLARE
    newtotal_harga number;
begin
	select sum(subtotal * (1-discount_barang))
        into newtotal_harga
        from detail_pemesanan dp
        where :new.id_pesanan = dp.id_pesanan
        group by dp.id_pesanan;
    update pesanan
        set total_harga=newtotal_harga
        where :new.id_pesanan = id_pesanan;
end;
/

Create or replace procedure UPDATE_ESTIMASI
AS
	cursor update_bar
    is
        select id_barang, avg(next_tanggal - tanggal_update) as average 
            from (
                select id_barang, tanggal_update, lead(tanggal_update,1) over(
                            partition by id_barang
                            order by id_barang, tanggal_update
                        ) as next_tanggal
                from update_stock 
                where Tipe_update = 'Tambah'
            )
            where next_tanggal is not null 
            group by id_barang
            order by id_barang;
begin
	for r_update_bar in update_bar
    loop
        update barang
            set estimasi_produksi= r_update_bar.average
            where r_update_bar.id_barang = id_barang;
    end loop;
END;
/

select p.id_pesanan, estimasi_lama_pengiriman(p.id_pesanan) as estimasi_lama
    from pesanan p;

select p.id_pesanan,p.Tanggal_pesan, pr.Tanggal_mengirim, pr.Tanggal_mengirim - p.Tanggal_pesan AS DateDiff
    from pesanan p, pengiriman pr
    where p.id_pesanan = pr.id_pesanan;