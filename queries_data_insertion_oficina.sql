-- Inserção de valores em oficina
use oficina;

desc endereco;
insert into endereco (CEP, logradouro, numero, complemento, bairro, cidade, siglaestado) values 
	('11111111', 'Rua Palmeiras', 12, 'Casa', 'Botafogo', 'Rio de Janeiro', 'RJ'),
    ('22222222', 'Avenida Limoeiros', 435, null , 'Piratini', 'Sorocaba', 'SP'),
    ('33333333', 'Rua Alameda Becker', 9845, 'Prédio verde escuro', 'Boqueirão', 'Curitiba', 'PR');

desc cliente;
insert into cliente (idEndereco, PrimeiroNome, NomeDoMeio, Sobrenome, telefone, email, CPF) values
	(1, 'Roberto', 'Gilberto', 'Carlos', '11999999999', 'roberto@email.com', '12345678901'),
	(2, 'Maria', null, 'Rosa', '41988888888', 'roberto@email.com', '09876543210'),
    (3, 'Paulo', 'Jorge', 'Cordeiro', '55977777777', null, '13243546576');
    
desc veiculo;
insert into veiculo (idCliente, marca, modelo, tipo, ano, placa, UltimaRevisao) values
	(1, 'Nissan', 'Sentra', 'Carro', 2022, 'ABC1D23', '2023-02-02'),
	(2, 'Toyota', 'Corolla', 'Carro', 2020, 'XYZ9M45', '2021-11-27'),
	(3, 'Volvo', 'FH16', 'Caminhão', 2022, 'PQR2E78', '2023-05-17');

desc servico;
insert into servico (nome, descricao, valor) values
	('Troca de Bateria', 'Serviço de substituição da bateria do veículo por uma nova, incluindo testes e descarte adequado da bateria antiga.', 250.00),
    ('Diagnóstico Eletrônico', 'Serviço de análise do sistema eletrônico do veículo para identificar e solucionar problemas relacionados a sensores, módulos ou componentes eletrônicos.', 150.00),
    ('Revisão Geral', 'Serviço de revisão completa do veículo, incluindo troca de óleo, inspeção de fluidos, verificação de freios, suspensão, direção e sistemas elétricos.', 300.00);

desc servicoveiculo;
insert into servicoveiculo (idServico, idVeiculo, DataEntrada, DataPrevista, StatusServico, observacoes) values
	(1, 1, '2023-06-30', '2023-07-22', 'Em andamento', 'Substituição de bateria'),
    (2, 2, '2023-05-22', '2023-06-03', 'Concluído', 'Revisão geral com ajuste de marcha'),
    (3, 3, '2023-07-13', '2023-08-04', 'Em espera', null);

desc material;
insert into material (idServico, nome, descricao, quantidade, PrecoUnidade) values
	(1,'Bateria Automotiva', 'Bateria de partida para veículos automotivos.', 1, 400.00),
    (2,'Scanner OBD-II', 'Ferramenta de diagnóstico eletrônico que se conecta ao conector OBD-II do veículo.', 3, 500.00),
    (3,'Filtro de Ar Condicionado', 'Filtro de ar para o sistema de ar condicionado do veículo.', 1, 50.00);
    
-- Queries / consultas

-- Recuperações simples com SELECT Statement;
select * from cliente;

select * from servico;

-- Filtros com WHERE Statement;
select * from veiculo where marca = 'Nissan';

select * from cliente where email is not null;

-- Crie expressões para gerar atributos derivados;
select concat(PrimeiroNome, ' ', NomeDoMeio, ' ', Sobrenome) as NomeCompleto from cliente;

-- Defina ordenações dos dados com ORDER BY;
select * from veiculo order by ano desc;

select * from servico order by valor;

select v.*, concat(c.primeironome, ' ', c.sobrenome) as nomecliente
from veiculo v
join cliente c on v.idcliente = c.idcliente
order by nomecliente asc;

-- Condições de filtros aos grupos – HAVING Statement;
select * from servico having valor > 200.00;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;
select os.*, v.marca, v.modelo, v.tipo, c.PrimeiroNome, c.Sobrenome, s.nome as nome_servico, s.valor
from servicoveiculo os
join veiculo v on os.idVeiculo = v.idVeiculo
join cliente c on v.idCliente = c.idCliente
join servico s on os.idServico = s.idServico;

select v.tipo, avg(s.valor) as media_valor
from veiculo v
join servicoveiculo sv on v.idveiculo = sv.idveiculo
join servico s on sv.idservico = s.idservico
where sv.statusservico = 'Concluído'
group by v.tipo;

select sv.idservico, count(m.idservico) as quantidade_materiais
from servicoveiculo sv
left join material m on sv.idservico = m.idservico
group by sv.idservico;




