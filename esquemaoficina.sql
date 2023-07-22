-- Criar esquema de banco de dados Oficina

create database if not exists oficina;
use oficina;

-- Criar tabela endereco
create table endereco (
	idEndereco int auto_increment primary key,
    CEP char(8) not null,
    logradouro varchar(255) not null,
    numero int not null,
    complemento varchar(45),
    bairro varchar(45) not null,
    cidade varchar(45) not null,
    siglaestado char(2) not null,
    constraint unique_cep unique (CEP)
);

-- Criar tabela cliente
create table cliente (
	idCliente int auto_increment primary key,
	idEndereco int,
    PrimeiroNome varchar(30) not null,
    NomeDoMeio varchar(45),
    Sobrenome varchar(30) not null,
    telefone char(11) not null,
    email varchar(50),
    CPF char(11) not null,
    constraint unique_cpf unique (CPF),
    constraint fk_endereco foreign key(idEndereco) references endereco (idEndereco)
);

-- Criar tabela veiculo
create table veiculo (
	idVeiculo int auto_increment primary key,
	idCliente int,
    marca varchar(30) not null,
    modelo varchar(30) not null,
    tipo enum('Carro', 'Moto', 'Caminhão', 'Van') not null,
    ano int not null,
    placa char(7) not null,
    UltimaRevisao date,
    constraint unique_placa unique (placa),
    constraint fk_cliente foreign key(idCliente) references cliente (idCliente)
);

-- Criar tabela servico
create table servico(
	idServico int auto_increment primary key,
    nome varchar(45) not null,
    descricao varchar(255) not null,
    valor float
);

-- Criar tabela servicoveiculo
create table servicoveiculo(
	idServicoVeiculo int auto_increment primary key,
	idServico int,
    idVeiculo int,
    DataEntrada date not null,
    DataPrevista date not null,
    StatusServico enum('Em espera', 'Em andamento', 'Concluído', 'Cancelado'),
    observacoes varchar(255),
    constraint fk_servico_servicoveiculo foreign key (idServico) references servico (idServico),
    constraint fk_veiculo_servicoveiculo foreign key (idVeiculo) references veiculo (idVeiculo)
);


-- Criar tabela material
create table material(
	idMaterial int auto_increment primary key,
    idServico int,
    nome varchar(50) not null,
    descricao varchar(255) not null,
    quantidade int not null,
    PrecoUnidade float not null,
    constraint fk_servico_material foreign key (idServico) references servico (idServico)
);