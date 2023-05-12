CREATE TABLE pengguna (
	idPengguna char(17),
    namaPengguna varchar(50),
    emailPengguna varchar(50),
    noTelp varchar(12),
    primary key (idPengguna)
);

CREATE TABLE kendaraan (
	idKendaraan char(17),
	platNomor varchar(8),
    merk varchar(10),
    tipe varchar(10),
    primary key (idKendaraan)
);

CREATE TABLE driver (
    idDriver char(17),
	idKendaraan char(17),
	namaDriver varchar(50),
    emailDriver varchar(50),
    noTelp varchar(12),
    primary key (idDriver),
    constraint FK_idKendaraan foreign key (idKendaraan) references kendaraan(idKendaraan) 
);

CREATE TABLE lokasi (
	koordinat char(20),
    namaTempat varchar(50),
    alamat varchar(50), 
    kota varchar(10), 
    provinsi varchar(10), 
    kodePos varchar(5), 
    negara varchar(10),
    primary key (koordinat)
);

CREATE TABLE pesanan (
	idPesanan char(17),
    idPengguna char(17),
    idDriver char(17),
    titikPickup char(20),
    titikDropOff char(20),
	tanggal datetime,
	jarak float, 
    waktuPickup time,
    waktuDropOff time,
    durasi time,
    biayaPerjalanan int, 
    biayaAplikasi int, 
    total int,
    statusPesanan varchar(20),
    primary key (idPesanan),
    constraint FK_idPengguna foreign key (idPengguna) references pengguna(idPengguna),
    constraint FK_idDriver foreign key (idDriver) references driver(idDriver),
	constraint FK_titikPickup foreign key (titikPickup) references lokasi(koordinat),
    constraint FK_titikDropoff foreign key (titikDropoff) references lokasi(koordinat)
);

CREATE TABLE metodePembayaran (
	idMetode char(17),
    namaMetode varchar(20)
);

CREATE TABLE pembayaran (
	idPembayaran char(17),
    idPesanan char(17),
    idMetode char(17),
    tanggal datetime,
    jumlah int,
    statusPembayaran varchar(20),
    constraint FK_idPesanan foreign key (idPesanan) references pesanan(idPesanan),
    constraint FK_idMetode foreign key (idMetode) references metodePembayaran(idMetode)
);


