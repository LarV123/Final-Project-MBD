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
insert into UPDATE_STOCK values ('B1', null, TO_DATE('13/05/2020', 'DD/MM/YYYY'), 'Tambah', 10);
insert into UPDATE_STOCK values ('B2', null, TO_DATE('22/05/2020', 'DD/MM/YYYY'), 'Tambah', 12);
insert into UPDATE_STOCK values ('B3', null, TO_DATE('23/05/2020', 'DD/MM/YYYY'), 'Tambah', 130);
insert into UPDATE_STOCK values ('B4', null, TO_DATE('12/06/2020', 'DD/MM/YYYY'), 'Tambah', 110);
insert into UPDATE_STOCK values ('B5', null, TO_DATE('19/05/2020', 'DD/MM/YYYY'), 'Tambah', 130);
insert into UPDATE_STOCK values ('B6', null, TO_DATE('20/05/2020', 'DD/MM/YYYY'), 'Tambah', 120);
insert into UPDATE_STOCK values ('B7', null, TO_DATE('23/05/2020', 'DD/MM/YYYY'), 'Tambah', 130);
insert into UPDATE_STOCK values ('B8', null, TO_DATE('6/05/2020', 'DD/MM/YYYY'), 'Tambah', 160);
insert into UPDATE_STOCK values ('B9', null, TO_DATE('17/05/2020', 'DD/MM/YYYY'), 'Tambah', 110);
insert into UPDATE_STOCK values ('B10', null, TO_DATE('1/05/2020', 'DD/MM/YYYY'), 'Tambah', 10);
insert into UPDATE_STOCK values ('B11', null, TO_DATE('11/05/2020', 'DD/MM/YYYY'), 'Tambah', 11);
insert into UPDATE_STOCK values ('B12', null, TO_DATE('17/05/2020', 'DD/MM/YYYY'), 'Tambah', 13);
insert into UPDATE_STOCK values ('B13', null, TO_DATE('19/05/2020', 'DD/MM/YYYY'), 'Tambah', 14);
insert into UPDATE_STOCK values ('B14', null, TO_DATE('30/05/2020', 'DD/MM/YYYY'), 'Tambah', 16);
insert into UPDATE_STOCK values ('B15', null, TO_DATE('22/05/2020', 'DD/MM/YYYY'), 'Tambah', 13);
insert into UPDATE_STOCK values ('B16', null, TO_DATE('21/05/2020', 'DD/MM/YYYY'), 'Tambah', 112);
insert into UPDATE_STOCK values ('B17', null, TO_DATE('16/05/2020', 'DD/MM/YYYY'), 'Tambah', 11);
insert into UPDATE_STOCK values ('B18', null, TO_DATE('13/05/2020', 'DD/MM/YYYY'), 'Tambah', 110);
insert into UPDATE_STOCK values ('B19', null, TO_DATE('20/05/2020', 'DD/MM/YYYY'), 'Tambah', 110);
insert into UPDATE_STOCK values ('B20', null, TO_DATE('12/07/2020', 'DD/MM/YYYY'), 'Tambah', 100);
insert into UPDATE_STOCK values ('B21', null, TO_DATE('12/08/2020', 'DD/MM/YYYY'), 'Tambah', 23);
insert into UPDATE_STOCK values ('B22', null, TO_DATE('12/11/2020', 'DD/MM/YYYY'), 'Tambah', 45);
insert into UPDATE_STOCK values ('B23', null, TO_DATE('12/06/2020', 'DD/MM/YYYY'), 'Tambah', 36);
insert into UPDATE_STOCK values ('B24', null, TO_DATE('13/05/2020', 'DD/MM/YYYY'), 'Tambah', 56);
insert into UPDATE_STOCK values ('B25', null, TO_DATE('30/06/2020', 'DD/MM/YYYY'), 'Tambah', 78);
insert into UPDATE_STOCK values ('B26', null, TO_DATE('30/07/2020', 'DD/MM/YYYY'), 'Tambah', 45);
insert into UPDATE_STOCK values ('B27', null, TO_DATE('23/08/2020', 'DD/MM/YYYY'), 'Tambah', 45);
insert into UPDATE_STOCK values ('B28', null, TO_DATE('14/06/2020', 'DD/MM/YYYY'), 'Tambah', 67);
insert into UPDATE_STOCK values ('B29', null, TO_DATE('14/07/2020', 'DD/MM/YYYY'), 'Tambah', 12);
insert into UPDATE_STOCK values ('B30', null, TO_DATE('14/08/2020', 'DD/MM/YYYY'), 'Tambah', 23);
insert into UPDATE_STOCK values ('B31', null, TO_DATE('14/09/2020', 'DD/MM/YYYY'), 'Tambah', 25);
insert into UPDATE_STOCK values ('B32', null, TO_DATE('14/10/2020', 'DD/MM/YYYY'), 'Tambah', 27);
insert into UPDATE_STOCK values ('B33', null, TO_DATE('17/06/2020', 'DD/MM/YYYY'), 'Tambah', 35);
insert into UPDATE_STOCK values ('B34', null, TO_DATE('17/08/2020', 'DD/MM/YYYY'), 'Tambah', 13);
insert into UPDATE_STOCK values ('B35', null, TO_DATE('17/07/2020', 'DD/MM/YYYY'), 'Tambah', 67);
insert into UPDATE_STOCK values ('B36', null, TO_DATE('17/09/2020', 'DD/MM/YYYY'), 'Tambah', 35);
insert into UPDATE_STOCK values ('B37', null, TO_DATE('17/10/2020', 'DD/MM/YYYY'), 'Tambah', 58);
insert into UPDATE_STOCK values ('B38', null, TO_DATE('19/05/2020', 'DD/MM/YYYY'), 'Tambah', 37);
insert into UPDATE_STOCK values ('B39', null, TO_DATE('22/05/2020', 'DD/MM/YYYY'), 'Tambah', 14);
insert into UPDATE_STOCK values ('B40', null, TO_DATE('13/05/2020', 'DD/MM/YYYY'), 'Tambah', 37);
insert into UPDATE_STOCK values ('B41', null, TO_DATE('17/05/2020', 'DD/MM/YYYY'), 'Tambah', 24);
insert into UPDATE_STOCK values ('B42', null, TO_DATE('18/05/2020', 'DD/MM/YYYY'), 'Tambah', 12);
insert into UPDATE_STOCK values ('B43', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 46);