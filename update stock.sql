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

insert into UPDATE_STOCK values ('B1', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B2', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B3', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B4', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B5', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B6', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B7', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B8', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B9', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B10', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B11', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B12', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B13', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B14', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B15', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B16', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B17', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B18', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B19', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B20', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B21', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B22', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B23', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B24', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B25', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B26', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B27', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B28', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B29', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B30', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B31', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B32', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B33', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B34', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B35', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B36', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B37', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B38', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B39', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B40', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B41', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B42', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B43', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100);