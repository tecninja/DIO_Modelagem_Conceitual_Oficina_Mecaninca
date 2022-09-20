-- Criação de banco de dados
create database desafio_oficina;

-- Definção do banco como default 
use desafio_oficina;

-- Criação das tabelas

create table funcionario (
id int not null auto_increment,
nome varchar(45) not null,
data_nascimento date not null,
salario float not null,
tipo_regime varchar(3) not null default 'CLT',
constraint primarykey primary key (id)
);

create table administrativo (
id int not null auto_increment,
departamento varchar(20),
funcionario_id int not null,
constraint primary key (id),
constraint foreign key (funcionario_id) references funcionario(id) on delete cascade
);

create table mecanico (
id int not null auto_increment,
especialidade varchar(30) not null,
funcionario_id int not null,
constraint primary key (id),
constraint foreign key (funcionario_id) references funcionario(id) on delete cascade
);

create table cliente (
id int not null auto_increment,
nome varchar(45) not null,
telefone varchar(11) not null,
cpf_cnpj varchar(14) not null,
constraint primary key (id));

create table veiculo (
id int not null auto_increment,
marca varchar(30) not null,
modelo varchar(30) not null,
ano_fabricacao date not null,
ano_modelo date,
combustivel varchar(10),
seguro boolean,
cliente_id int not null,
constraint pk primary key (id),
constraint fk foreign key (cliente_id) references cliente(id) on delete cascade
);

create table pedido (
id int not null auto_increment,
cliente_id int not null,
administrativo_id int not null,
tipo varchar(30) not null,
descricao varchar(255) not null,
valor float not null,
constraint pk primary key (id),
constraint fk1 foreign key (cliente_id) references cliente(id) on delete cascade,
constraint fk2 foreign key (administrativo_id) references administrativo(id) on delete cascade
);

create table ordem_servico (
id int not null auto_increment,
pedido_id int not null,
veiculo_id int not null,
data_inicio date not null,
data_entrega date,
status_ordem smallint comment '0: Pendente, 1: Em andamento, 2: Finalizado, 3: Cancelado',
constraint pk primary key (id),
constraint foreign key (pedido_id) references pedido(id) on delete cascade,
constraint foreign key (veiculo_id) references veiculo(id) on delete cascade
);

create table mecanico_ordem_servico (
mecanico_id int not null,
ordem_servico_id int not null,
constraint primary key (mecanico_id, ordem_servico_id),
constraint foreign key (mecanico_id) references mecanico(id) on delete cascade,
constraint foreign key (ordem_servico_id) references ordem_servico(id) on delete cascade
);

-- Inserção dos valores

insert into funcionario values 
(Default, 'Naruto Uzumaki', '1985-02-22', 3590.10, 'CLT'),
(Default, 'Sasuke Uchiha', '1984-10-12', 3228.00, 'PJ'),
(Default, 'Shikamaru Nara', '1985-07-19', 5560.20, 'PJ'),
(Default, 'Minato Namikaze', '1982-06-24', 4510.40, 'CLT'),
(Default, 'Sakura Haruno', '1995-01-25', 2320.20, 'CLT'),
(Default, 'Hinata Hyuga', '1990-09-11', 4510.40, 'CLT'),
(Default, 'Hiruzen Sarutobi', '1960-08-01', 1500.00, 'CLT');

insert into administrativo values
(Default, 'GESTAO',3),
(Default, 'MARKETING',4),
(Default, 'MARKETING',6),
(Default, 'ATENDIMENTO',5),
(Default, 'MANUTENCAO',7);

insert into mecanico values 
(Default, 'ELETRICA',2),
(Default, 'LANTERNAGEM',1);

insert into cliente values 
(Default, 'Eren Yeager', '11998899889', '10100142000123'),
(Default, 'Monkey D. Luffy', '81998899889', '12345678911'),
(Default, 'Saitama', '81998899881', '12345678912'),
(Default, 'Son Goku', '81998899882', '12345678913'),
(Default, 'Izuku Midoriya', '81998899883', '12345678914'),
(Default, 'Satoru Gojo', '81998899884', '12345678915');

insert into veiculo values 
(Default, 'FIAT','TORO','2022-01-01','2023-01-01','Diesel',True,6),
(Default, 'VOLKSWAGEN','SAVEIRO','2019-01-01','2019-01-01','GASOLINA',True,2),
(Default, 'RENAULT','DUSTER','2020-01-01','2021-01-01','DIESEL',True,5),
(Default, 'HYUNDAI','TUCSON','2022-01-01','2023-01-01','ALCOOL',True,1),
(Default, 'HYUNDAI','I30','2022-01-01','2023-01-01','GASOLINA',True,3),
(Default, 'TOYOTA','COROLLA','2022-01-01','2023-01-01','ALCOOL',True,4);

insert into pedido values 
(Default, 1, 5, 'REPARO ELETRICO','Reparo eletrico nos vídros dianteiros do veiculo',600.00),
(Default, 2, 5, 'REPARO ELETRICO','Reparo eletrico nos vídros do veiculo',1100.00),
(Default, 3, 5, 'LANTERNAGEM PORTA','Serviço de lanternagem na porta trazeira, lado motorista',420.00),
(Default, 4, 5, 'LANTERNAGEM MALA','Serviço de lanternagem na porta da mala',350.00),
(Default, 5, 5, 'REPARO ELETRICO','Reparo eletrico ignição',780.00),
(Default, 6, 5, 'LANTERNAGEM TOTAL','Serviço de lanternagem em todo o veículo',2530.00);

insert into ordem_servico values
(default, 1, 1, '2022-09-01',null,3),
(default, 2, 3, '2022-09-01',null,0),
(default, 3, 5, '2022-09-01',null,1),
(default, 4, 6, '2022-09-01',null,2),
(default, 5, 2, '2022-09-01',null,0),
(default, 6, 4, '2022-09-01',null,2);

insert into mecanico_ordem_servico values
(1,1),
(1,2),
(2,3),
(2,4),
(1,5),
(2,6);

-- Selects 

-- Selecionar funcionários que são da área administrativo 
select f.*, a.departamento
from funcionario as f
right join administrativo a on a.funcionario_id = f.id
order by salario desc;

-- Verificar a quantidade funcionários por tipo de regime.
select f.tipo_regime, count(*) as  as quantidade_funcionarios from funcionario f 
group by f.tipo_regime 
order by f.tipo_regime

-- Verificar a quantidade de funcionários por departamento administrativo
select a.departamento, count(*)  from funcionario f 
right join administrativo a on a.funcionario_id = f.id
group by a.departamento
order by 2

-- Verificar o ticket médio dos pedidos
select round(avg(p.valor), 2) as ticket_médio from pedido p 

-- Verificar os clientes e seus veículos
select c.nome as cliente, v.marca, v.modelo  from cliente c 
left join veiculo v on v.cliente_id = c.id

-- Verifique o lucro de cada pedido (considerando um lucro de 21% por pedido de eletrica, e 29% em pedidos de lanternagem)
select 
p.id pedido_no,
p.tipo, 
p.valor,
case 
	when m.especialidade = 'ELETRICA' then p.valor * 0.21
	when m.especialidade = 'LANTERNAGEM' then p.valor * 0.29
end as lucro
from pedido p
left join ordem_servico os on os.pedido_id = p.id
left join mecanico_ordem_servico mos on mos.ordem_servico_id = os.id
left join mecanico m on m.id = mos.mecanico_id;

-- Verifique os tipos de pedidos que somados representam mais de 1000 reais em serviço
select p.tipo,
count(*) as quantidade,
sum(p.valor) as valor
from pedido p 
group by p.tipo
having valor > 1000
order by p.tipo


