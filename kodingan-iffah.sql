/*  
https://livesql.oracle.com/apex/livesql/s/j3q4sm4941ekxsql4nlmqk8w1
*/

/*
Query 1
Pelanggan beralamat di Jawa Timur yang memesan lebih dari 100 barang pada Desember 2019 hingga Januari 2020
*/

SELECT P.ID_PELANGGAN, PL.NAMA_PELANGGAN, SUM(DP.KUANTITAS) AS JUMLAH_BARANG 
FROM DETAIL_PEMESANAN DP INNER JOIN PESANAN P ON DP.ID_PESANAN = P.ID_PESANAN  
  INNER JOIN PELANGGAN PL ON P.ID_PELANGGAN = PL.ID_PELANGGAN  
  INNER JOIN KOTA_KABUPATEN K ON PL.ID_KABUPATEN = K.ID_KABUPATEN 
WHERE P.TANGGAL_PESAN >= '01-DEC-19 12.00.00.000000 AM'  
  AND P.TANGGAL_PESAN <= '31-JAN-20 12.00.00.000000 AM' 
GROUP BY P.ID_PELANGGAN, PL.NAMA_PELANGGAN, K.ID_PROVINSI 
HAVING SUM(DP.KUANTITAS) >100  
  AND K.ID_PROVINSI = 'PV1'
/

/*
Query 2
Total harga pembelian tiap kabupaten/kota selama Agustus 2019
*/

SELECT K.NAMA_KABUPATEN, SUM(P.TOTAL_HARGA) AS TOTAL_PER_KABUPATEN  
FROM PESANAN P INNER JOIN PELANGGAN PL ON P.ID_PELANGGAN = PL.ID_PELANGGAN   
  INNER JOIN KOTA_KABUPATEN K ON PL.ID_KABUPATEN = K.ID_KABUPATEN  
WHERE P.TANGGAL_PESAN >= '01-AUG-2019 12.00.00.000000 AM'   
  AND P.TANGGAL_PESAN <= '31-AUG-2019 12.00.00.000000 AM'  
GROUP BY PL.ID_KABUPATEN, K.NAMA_KABUPATEN  
ORDER BY K.NAMA_KABUPATEN
/

/*
Procedure mengisi kolom diskon :
    Dison Kusus Surabaya, beralamat Surabaya mendapat diskon 20%, selain Surabaya mendapat 10%
*/

CREATE OR REPLACE PROCEDURE DISCOUNT_SBY 
AS 
  CURSOR CUR_SBY IS 
    SELECT DISTINCT P.ID_PESANAN, PL.ID_KABUPATEN 
    FROM PESANAN P, PELANGGAN PL 
    WHERE P.ID_PELANGGAN = PL.ID_PELANGGAN; 
BEGIN 
    FOR TMP IN CUR_SBY 
    LOOP 
        IF TMP.ID_KABUPATEN = 'K1' THEN 
            UPDATE PESANAN 
            SET DISCOUNT_PESANAN = 0.2
            WHERE ID_PESANAN = TMP.ID_PESANAN; 
        ELSE 
            UPDATE PESANAN 
            SET DISCOUNT_PESANAN = 0.1 
            WHERE ID_PESANAN = TMP.ID_PESANAN; 
        END IF; 
    END LOOP; 
END;
/

EXECUTE DISCOUNT_SBY;
/

/*
Function return nilai pendapatan per bulan
*/

CREATE OR REPLACE FUNCTION PENDAPATAN(BULAN NUMBER, TAHUN NUMBER) 
RETURN FLOAT 
AS 
  CURSOR CUR_TRANSAKSI IS 
    SELECT * 
    FROM PESANAN; 
  DISCOUNT FLOAT;
  RESULT FLOAT; 
BEGIN 
    RESULT := 0; 
    FOR TMP IN CUR_TRANSAKSI 
    LOOP
        DISCOUNT := 0;
        IF EXTRACT(MONTH FROM TMP.TANGGAL_PESAN) = BULAN AND EXTRACT(YEAR FROM TMP.TANGGAL_PESAN) = TAHUN THEN 
        DISCOUNT := TMP.TOTAL_HARGA * (1 - TMP.DISCOUNT_PESANAN);
        RESULT := RESULT + DISCOUNT; 
        END IF; 
    END LOOP; 
    RETURN RESULT; 
END;
/

SELECT PENDAPATAN(2, 2020) FROM DUAL
/

/*
Sequence ID Pelanggan
*/

create sequence SEQ_ID_PELANGGAN   
    minvalue 1    
    maxvalue 99999    
    start with 1    
    increment by 1    
    cache 20

/*
Trigger Before Insert Pelanggan, generate ID otomatis
*/

create or replace trigger TRG_INS_PELANGGAN   
before insert on PELANGGAN   
for each row   
begin   
    if (:new.ID_PELANGGAN is null)   
    then   
        select 'PL' || SEQ_ID_PELANGGAN.nextval into :new.ID_PELANGGAN from dual;   
    end if;   
end; 
/
