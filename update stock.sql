drop sequence SEQ_ID_UPDATE_STOCK;

create sequence SEQ_ID_UPDATE_STOCK
    minvalue 1
    maxvalue 99999
    start with 1
    increment by 1
    cache 20;

create or replace trigger TRG_INS_UPDATE_STOCK
before insert on UPDATE_STOCK
for each row
begin
    if (:new.ID_UPDATE_STOCK is null)
    then
        select 'US' || SEQ_ID_UPDATE_STOCK.nextval into :new.ID_UPDATE_STOCK from dual;
    end if;
end;
/

delete from UPDATE_STOCK;

insert into UPDATE_STOCK values (null, null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 1000);