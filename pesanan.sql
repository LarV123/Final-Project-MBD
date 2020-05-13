drop sequence SEQ_ID_PESANAN;

create sequence SEQ_ID_PESANAN
    minvalue 1
    maxvalue 999999
    start with 1
    increment by 1
    cache 20;

create or replace trigger TRG_INS_PESANAN
before insert on PESANAN
for each row
begin
    if (:new.ID_PESANAN is null)
    then
        select 'P' || SEQ_ID_PESANAN.nextval into :new.ID_PESANAN from dual;
    end if;
end;
/

delete from BARANG;