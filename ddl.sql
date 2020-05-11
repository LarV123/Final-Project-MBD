/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     11-May-20 1:49:42 PM                         */
/*==============================================================*/


alter table BARANG
   drop constraint FK_BARANG_KATEGORI__KATEGORI;

alter table DETAIL_PEMESANAN
   drop constraint FK_DETAIL_P_MEMESAN_B_BARANG;

alter table DETAIL_PEMESANAN
   drop constraint FK_DETAIL_P_MEMILIKI__PESANAN;

alter table KOTA_KABUPATEN
   drop constraint FK_KOTA_KAB_MEMILIKI__PROVINSI;

alter table PELANGGAN
   drop constraint FK_PELANGGA_BERTEMPAT_KOTA_KAB;

alter table PELANGGAN
   drop constraint FK_PELANGGA_JENIS_PEL_JENIS_PE;

alter table PEMBAYARAN
   drop constraint FK_PEMBAYAR_DETAIL_PE_PESANAN;

alter table PEMBAYARAN
   drop constraint FK_PEMBAYAR_JENIS_PEM_JENIS_PE;

alter table PENGIRIMAN
   drop constraint FK_PENGIRIM_JENIS_EKS_JENIS_EK;

alter table PENGIRIMAN
   drop constraint FK_PENGIRIM_MENGIRIM_PESANAN;

alter table PESANAN
   drop constraint FK_PESANAN_MEMESAN_PELANGGA;

alter table PESANAN
   drop constraint FK_PESANAN_MENGIRIM2_PENGIRIM;

alter table UPDATE_STOCK
   drop constraint FK_UPDATE_S_UPDATE_ST_BARANG;

drop index KATEGORI_BARANG_FK;

drop table BARANG cascade constraints;

drop index MEMESAN_BARANG_FK;

drop index MEMILIKI_DETAIL_FK;

drop table DETAIL_PEMESANAN cascade constraints;

drop table JENIS_EKSPEDISI cascade constraints;

drop table JENIS_PELANGGAN cascade constraints;

drop table JENIS_PEMBAYARAN cascade constraints;

drop table KATEGORI_BARANG cascade constraints;

drop index MEMILIKI_KABUPATEN_FK;

drop table KOTA_KABUPATEN cascade constraints;

drop index BERTEMPAT_KOTA_FK;

drop index JENIS_PELANGGAN_FK;

drop table PELANGGAN cascade constraints;

drop index DETAIL_PEMBAYARAN_FK;

drop index JENIS_PEMBAYARAN_FK;

drop table PEMBAYARAN cascade constraints;

drop index JENIS_EKSPEDISI_FK;

drop index MENGIRIM_FK;

drop table PENGIRIMAN cascade constraints;

drop index MEMESAN_FK;

drop index MENGIRIM2_FK;

drop table PESANAN cascade constraints;

drop table PROVINSI cascade constraints;

drop index UPDATE_STOCK_FK;

drop table UPDATE_STOCK cascade constraints;

/*==============================================================*/
/* Table: BARANG                                                */
/*==============================================================*/
create table BARANG (
   ID_BARANG            VARCHAR2(1024)        not null,
   ID_KATEGORI_BARANG   VARCHAR2(1024),
   NAMA_BARANG          VARCHAR2(1024),
   HARGA_PRODUKSI       INTEGER,
   HARGA_JUAL           INTEGER,
   ESTIMASI_PRODUKSI    INTEGER,
   STOCK                INTEGER,
   constraint PK_BARANG primary key (ID_BARANG)
);

/*==============================================================*/
/* Index: KATEGORI_BARANG_FK                                    */
/*==============================================================*/
create index KATEGORI_BARANG_FK on BARANG (
   ID_KATEGORI_BARANG ASC
);

/*==============================================================*/
/* Table: DETAIL_PEMESANAN                                      */
/*==============================================================*/
create table DETAIL_PEMESANAN (
   ID_BARANG            VARCHAR2(1024),
   ID_PESANAN           VARCHAR2(1024),
   KUANTITAS            INTEGER,
   SUBTOTAL             INTEGER,
   DISCOUNT_BARANG      INTEGER
);

/*==============================================================*/
/* Index: MEMILIKI_DETAIL_FK                                    */
/*==============================================================*/
create index MEMILIKI_DETAIL_FK on DETAIL_PEMESANAN (
   ID_PESANAN ASC
);

/*==============================================================*/
/* Index: MEMESAN_BARANG_FK                                     */
/*==============================================================*/
create index MEMESAN_BARANG_FK on DETAIL_PEMESANAN (
   ID_BARANG ASC
);

/*==============================================================*/
/* Table: JENIS_EKSPEDISI                                       */
/*==============================================================*/
create table JENIS_EKSPEDISI (
   ID_EKSPEDISI         VARCHAR2(1024)        not null,
   NAMA_EKSPEDISI       VARCHAR2(1024),
   KONTAK_EKSPEDISI     VARCHAR2(1024),
   constraint PK_JENIS_EKSPEDISI primary key (ID_EKSPEDISI)
);

/*==============================================================*/
/* Table: JENIS_PELANGGAN                                       */
/*==============================================================*/
create table JENIS_PELANGGAN (
   ID_JENIS_PELANGGAN   VARCHAR2(1024)        not null,
   NAMA_JENIS_PELANGGAN VARCHAR2(1024),
   PRIORITAS_PELANGGAN  INTEGER,
   constraint PK_JENIS_PELANGGAN primary key (ID_JENIS_PELANGGAN)
);

/*==============================================================*/
/* Table: JENIS_PEMBAYARAN                                      */
/*==============================================================*/
create table JENIS_PEMBAYARAN (
   ID_JENIS_PEMBAYARAN  VARCHAR2(1024)        not null,
   NAMA_JENIS_PEMBAYARAN VARCHAR2(1024),
   constraint PK_JENIS_PEMBAYARAN primary key (ID_JENIS_PEMBAYARAN)
);

/*==============================================================*/
/* Table: KATEGORI_BARANG                                       */
/*==============================================================*/
create table KATEGORI_BARANG (
   ID_KATEGORI_BARANG   VARCHAR2(1024)        not null,
   NAMA_KATEGORI_BARANG VARCHAR2(1024),
   constraint PK_KATEGORI_BARANG primary key (ID_KATEGORI_BARANG)
);

/*==============================================================*/
/* Table: KOTA_KABUPATEN                                        */
/*==============================================================*/
create table KOTA_KABUPATEN (
   ID_PROVINSI          VARCHAR2(1024),
   ID_KABUPATEN         VARCHAR2(1024)        not null,
   NAMA_KABUPATEN       VARCHAR2(1024),
   constraint PK_KOTA_KABUPATEN primary key (ID_KABUPATEN)
);

/*==============================================================*/
/* Index: MEMILIKI_KABUPATEN_FK                                 */
/*==============================================================*/
create index MEMILIKI_KABUPATEN_FK on KOTA_KABUPATEN (
   ID_PROVINSI ASC
);

/*==============================================================*/
/* Table: PELANGGAN                                             */
/*==============================================================*/
create table PELANGGAN (
   ID_PELANGGAN         VARCHAR2(1024)        not null,
   ID_JENIS_PELANGGAN   VARCHAR2(1024),
   ID_KABUPATEN         VARCHAR2(1024),
   NAMA_PELANGGAN       VARCHAR2(1024),
   TELEPON_PELANGGAN    VARCHAR2(1024),
   ALAMAT_PELANGGAN     VARCHAR2(1024),
   EMAIL_PELANGGAN      VARCHAR2(1024),
   constraint PK_PELANGGAN primary key (ID_PELANGGAN)
);

/*==============================================================*/
/* Index: JENIS_PELANGGAN_FK                                    */
/*==============================================================*/
create index JENIS_PELANGGAN_FK on PELANGGAN (
   ID_JENIS_PELANGGAN ASC
);

/*==============================================================*/
/* Index: BERTEMPAT_KOTA_FK                                     */
/*==============================================================*/
create index BERTEMPAT_KOTA_FK on PELANGGAN (
   ID_KABUPATEN ASC
);

/*==============================================================*/
/* Table: PEMBAYARAN                                            */
/*==============================================================*/
create table PEMBAYARAN (
   ID_PEMBAYARAN        VARCHAR2(1024)        not null,
   ID_JENIS_PEMBAYARAN  VARCHAR2(1024),
   ID_PESANAN           VARCHAR2(1024),
   TANGGAL_PEMBAYARAN   DATE,
   JUMLAH_PEMBAYARAN    NUMBER(8,2),
   KEPERLUAN_PEMBAYARAN VARCHAR2(1024),
   constraint PK_PEMBAYARAN primary key (ID_PEMBAYARAN)
);

/*==============================================================*/
/* Index: JENIS_PEMBAYARAN_FK                                   */
/*==============================================================*/
create index JENIS_PEMBAYARAN_FK on PEMBAYARAN (
   ID_JENIS_PEMBAYARAN ASC
);

/*==============================================================*/
/* Index: DETAIL_PEMBAYARAN_FK                                  */
/*==============================================================*/
create index DETAIL_PEMBAYARAN_FK on PEMBAYARAN (
   ID_PESANAN ASC
);

/*==============================================================*/
/* Table: PENGIRIMAN                                            */
/*==============================================================*/
create table PENGIRIMAN (
   ID_PENGIRIMAN        VARCHAR2(1024)        not null,
   ID_PESANAN           VARCHAR2(1024),
   ID_EKSPEDISI         VARCHAR2(1024),
   TANGGAL_MENGIRIM     TIMESTAMP,
   KODE_RESI            VARCHAR2(1024),
   constraint PK_PENGIRIMAN primary key (ID_PENGIRIMAN)
);

/*==============================================================*/
/* Index: MENGIRIM_FK                                           */
/*==============================================================*/
create index MENGIRIM_FK on PENGIRIMAN (
   ID_PESANAN ASC
);

/*==============================================================*/
/* Index: JENIS_EKSPEDISI_FK                                    */
/*==============================================================*/
create index JENIS_EKSPEDISI_FK on PENGIRIMAN (
   ID_EKSPEDISI ASC
);

/*==============================================================*/
/* Table: PESANAN                                               */
/*==============================================================*/
create table PESANAN (
   ID_PESANAN           VARCHAR2(1024)        not null,
   ID_PENGIRIMAN        VARCHAR2(1024),
   ID_PELANGGAN         VARCHAR2(1024),
   NAMA_PESANAN         VARCHAR2(1024),
   TANGGAL_PESAN        TIMESTAMP,
   STATUS_PESANAN       SMALLINT,
   DISCOUNT_PESANAN     INTEGER,
   TOTAL_HARGA          INTEGER,
   JUMLAH_TERBAYARKAN   INTEGER,
   constraint PK_PESANAN primary key (ID_PESANAN)
);

/*==============================================================*/
/* Index: MENGIRIM2_FK                                          */
/*==============================================================*/
create index MENGIRIM2_FK on PESANAN (
   ID_PENGIRIMAN ASC
);

/*==============================================================*/
/* Index: MEMESAN_FK                                            */
/*==============================================================*/
create index MEMESAN_FK on PESANAN (
   ID_PELANGGAN ASC
);

/*==============================================================*/
/* Table: PROVINSI                                              */
/*==============================================================*/
create table PROVINSI (
   ID_PROVINSI          VARCHAR2(1024)        not null,
   NAMA_PROVINSI        VARCHAR2(1024),
   constraint PK_PROVINSI primary key (ID_PROVINSI)
);

/*==============================================================*/
/* Table: UPDATE_STOCK                                          */
/*==============================================================*/
create table UPDATE_STOCK (
   ID_BARANG            VARCHAR2(1024),
   ID_UPDATE_STOCK      VARCHAR2(1024),
   TANGGAL_UPDATE       DATE,
   TIPE_UPDATE          VARCHAR2(1024),
   JUMLAH_UPDATE        INTEGER
);

/*==============================================================*/
/* Index: UPDATE_STOCK_FK                                       */
/*==============================================================*/
create index UPDATE_STOCK_FK on UPDATE_STOCK (
   ID_BARANG ASC
);

alter table BARANG
   add constraint FK_BARANG_KATEGORI__KATEGORI foreign key (ID_KATEGORI_BARANG)
      references KATEGORI_BARANG (ID_KATEGORI_BARANG);

alter table DETAIL_PEMESANAN
   add constraint FK_DETAIL_P_MEMESAN_B_BARANG foreign key (ID_BARANG)
      references BARANG (ID_BARANG);

alter table DETAIL_PEMESANAN
   add constraint FK_DETAIL_P_MEMILIKI__PESANAN foreign key (ID_PESANAN)
      references PESANAN (ID_PESANAN);

alter table KOTA_KABUPATEN
   add constraint FK_KOTA_KAB_MEMILIKI__PROVINSI foreign key (ID_PROVINSI)
      references PROVINSI (ID_PROVINSI);

alter table PELANGGAN
   add constraint FK_PELANGGA_BERTEMPAT_KOTA_KAB foreign key (ID_KABUPATEN)
      references KOTA_KABUPATEN (ID_KABUPATEN);

alter table PELANGGAN
   add constraint FK_PELANGGA_JENIS_PEL_JENIS_PE foreign key (ID_JENIS_PELANGGAN)
      references JENIS_PELANGGAN (ID_JENIS_PELANGGAN);

alter table PEMBAYARAN
   add constraint FK_PEMBAYAR_DETAIL_PE_PESANAN foreign key (ID_PESANAN)
      references PESANAN (ID_PESANAN);

alter table PEMBAYARAN
   add constraint FK_PEMBAYAR_JENIS_PEM_JENIS_PE foreign key (ID_JENIS_PEMBAYARAN)
      references JENIS_PEMBAYARAN (ID_JENIS_PEMBAYARAN);

alter table PENGIRIMAN
   add constraint FK_PENGIRIM_JENIS_EKS_JENIS_EK foreign key (ID_EKSPEDISI)
      references JENIS_EKSPEDISI (ID_EKSPEDISI);

alter table PENGIRIMAN
   add constraint FK_PENGIRIM_MENGIRIM_PESANAN foreign key (ID_PESANAN)
      references PESANAN (ID_PESANAN);

alter table PESANAN
   add constraint FK_PESANAN_MEMESAN_PELANGGA foreign key (ID_PELANGGAN)
      references PELANGGAN (ID_PELANGGAN);

alter table PESANAN
   add constraint FK_PESANAN_MENGIRIM2_PENGIRIM foreign key (ID_PENGIRIMAN)
      references PENGIRIMAN (ID_PENGIRIMAN);

alter table UPDATE_STOCK
   add constraint FK_UPDATE_S_UPDATE_ST_BARANG foreign key (ID_BARANG)
      references BARANG (ID_BARANG);

