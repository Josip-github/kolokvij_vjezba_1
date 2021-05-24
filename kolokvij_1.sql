drop database if exists kolokvij_vjezba_1;
create database kolokvij_vjezba_1;
use kolokvij_vjezba_1;

create table sestra(
	sifra int not null primary key auto_increment,
	introvertno bit,
	haljina varchar(31) not null,
	maraka decimal(16,6),
	hlace varchar(46) not null,
	narukvica int not null
);

create table sestra_svekar(
	sifra int not null primary key auto_increment,
	sestra int not null,
	svekar int not null
);

create table svekar(
	sifra int not null primary key auto_increment,
	bojaociju varchar(40) not null,
	prstena int,
	dukserica varchar(41),
	lipa decimal(13,8),
	eura decimal(12,7) not null,
	majica varchar(35) not null
);

create table zena(
	sifra int not null primary key auto_increment,
	treciputa datetime,
	hlace varchar(46),
	kratkamajica varchar(31) not null,
	jmbag char(11) not null,
	bojaociju varchar(39) not null,
	haljina varchar(44),
	sestra int not null
);

create table muskarac(
	sifra int not null primary key auto_increment,
	bojaociju varchar(50) not null,
	hlace varchar(30),
	modelnaocala varchar(43),
	maraka decimal(14,5) not null,
	zena int not null
);

create table mladic(
	sifra int not null primary key auto_increment,
	suknja varchar(50) not null,
	kuna decimal(16,8) not null,
	drugiputa datetime,
	asocijalno bit,
	ekstrovertno bit not null,
	dukserica varchar(48) not null,
	muskarac int
);

create table punac(
	sifra int not null primary key auto_increment,
	ogrlica int,
	gustoca decimal(14,9),
	hlace varchar(41) not null
);

create table cura(
	sifra int not null primary key auto_increment,
	novcica decimal(16,5) not null,
	gustoca decimal(18,6) not null,
	lipa decimal(13,10),
	ogrlica int not null,
	bojakose varchar(38),
	suknja varchar(36),
	punac int not null
);

alter table sestra_svekar add foreign key (sestra) references sestra(sifra);
alter table sestra_svekar add foreign key (svekar) references svekar(sifra);

alter table zena add foreign key (sestra) references sestra(sifra);

alter table muskarac add foreign key (zena) references zena(sifra);

alter table mladic add foreign key (muskarac) references muskarac(sifra);

alter table cura add foreign key (punac) references punac(sifra);

insert into sestra(haljina,hlace,narukvica)
values('duga haljina','kratke hlače',7),
('kratka haljina','duge hlače',8),
('uska haljina','hlače iz Zare',9);

insert into zena(kratkamajica,jmbag,bojaociju,sestra)
values('kratkih rukava',77666555,'zelena',1),
('bez rukava',77555666,'plava',2),
('top',666555777,'žuta',3);

insert into muskarac(bojaociju,maraka,zena)
values('crna',10.10,1),
('siva',11.10,2),
('bijela',12.10,3);

insert into svekar(bojaociju,eura,majica)
values('smeđa',20.05,'duga majica'),
('crvena',25.76,'kratka majica'),
('zelenkasta',50.067,'Nike majica');

insert into sestra_svekar(sestra,svekar) 
values(1,3),(3,1),(2,2);

update cura set gustoca = 15.77;

delete from mladic where kuna > 15.78;

select kratkamajica from zena where hlace like '%ana%';

select a.dukserica, f.asocijalno, e.hlace 
from svekar a inner join sestra_svekar b on a.sifra = b.svekar 
inner join sestra c on b.sestra = c.sifra 
inner join zena d on c.sifra = d.sestra 
inner join muskarac e on d.sifra = e.zena 
inner join mladic f on e.sifra = f.muskarac 
where d.hlace like 'a%' and c.haljina like '%ba%';

select a.haljina, a.maraka 
from sestra a left join sestra_svekar b on a.sifra = b.sestra 
where b.sestra is null;



