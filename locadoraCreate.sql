1  - Listar todos os filmes alugados por um cliente específico, incluindo a data de locação e a data de devolução.
2  - Obter uma lista de clientes e seus dependentes.
3  - Listar todos os filmes de um determinado gênero.
4  - Exibir todos os clientes que têm uma profissão específica.
5  - Encontrar todos os filmes em uma categoria específica com quantidade disponível maior que 5.
6  - Listar todos os atores que participaram de filmes com um determinado título.
7  - Obter o endereço completo de um cliente específico.
8  - Listar todos os filmes e seus respectivos gêneros e categorias.
9  - Mostrar todos os clientes que alugaram um filme específico e a data de locação.
10 - Exibir a lista de clientes com multas superiores a um valor específico.
11 - Listar todas as locações feitas em um período específico.
12 - Obter a quantidade total de filmes alugados por cada cliente. (DESAFIO)
13 - Listar os clientes e os filmes que eles alugaram, ordenados por data de locação.
14 - Mostrar todos os clientes que moram em uma cidade específica e que alugaram filmes de uma categoria específica.
15 - Encontrar todos os atores que participaram de pelo menos 5 filmes, listando o nome do ator e o número de filmes em que atuou. (DESAFIO)
16 - Exibir a quantidade total de filmes alugados por categoria e gênero, incluindo apenas as categorias e gêneros que têm mais de 5
	filmes alugados no total (DESAFIO)

create table atores (
	id serial primary key,
	nome varchar(60) not null
)

create table generos (
	id serial primary key,
	nome varchar(60) not null
)	

create table categorias (
	id serial primary key,
	nome varchar(60) not null,
	valor_base money
)

create table profissoes (
	id serial primary key,
	nome varchar(60) not null
)

create table enderecos (
	id serial primary key,
	logradouro varchar(60) not null,
	tipo_log varchar(20) not null,
	complemento varchar(20),
	cidade varchar(60) not null,
	uf varchar(40) not null,
	cep varchar(20) not null,
	numero varchar(10) not null,
	bairro varchar(60) not null
)	
	
create table filmes (
	id serial primary key,
	titulo_original varchar(100) not null,
	titulo varchar(100) not null,
	quantidade integer not null,
	fk_categoria integer not null,
	fk_genero integer not null,
	foreign key (fk_categoria) references categorias(id),
	foreign key (fk_genero) references generos(id)	
)

create table filme_ator (
	id serial primary key,
	fk_ator integer not null,
	fk_filme integer not null,
	IsDiretor boolean default false,
	foreign key (fk_ator) references atores(id),
	foreign key (fk_filme) references filmes(id),
	unique (fk_ator, fk_filme)
)	

create table clientes (
	id serial primary key,
	nome varchar(100) not null,
	cpf varchar(11) not null,
	telefone varchar(10) not null,
	fk_prof integer,	
	foreign key (fk_prof) references profissoes(id)		
)

create table cliente_endereco (
	id serial primary key,
	fk_endereco integer not null,
	fk_cliente integer not null,	
	foreign key (fk_endereco) references enderecos(id),
	foreign key (fk_cliente) references clientes(id)	
)

create table locacoes (
	id serial primary key,
	data_locacao date not null,
	desconto numeric(15,2),
	multa numeric(15,2),
	sub_total numeric (15,2) not null,
	fk_cliente integer not null,	
	foreign key (fk_cliente) references clientes(id)	
)

create table locacao_filme (
	id serial primary key,
	valor money not null,
	num_dias integer not null,
	data_devolucao date not null,
	fk_filme integer not null,	
	foreign key (fk_filme) references filmes(id),
	fk_locacao integer not null,	
	foreign key (fk_locacao) references locacoes(id)
)

create table dependentes (
	id serial primary key,
	fk_cliente integer,	
	foreign key (fk_cliente) references clientes(id),
	fk_cliente_dep integer,	
	foreign key (fk_cliente_dep) references clientes(id),
	parentesco varchar(20) not null
);

// inserindo dados
insert into atores (nome) values	
('jennifer Aniston'),
('Tom Hanks'),
('Morgan Freeman'),
('Sandra Bullock'),
('Robert Downey Jr.'),
('Johnny Depp'),
('Jennifer Lawrence'),
('Scarlett Johansson'),
('Will Smith'),
('Gal Gadot'),
('Al pacino');

insert into generos (nome) values
('Ação'),
('Drama'),
('Comédia'),
('Suspense'),
('Ficção Científica'),
('Aventura'),
('Romance'),
('Terror');

insert into categorias (nome, valor_base) values
('Lançamento', 10.00),
('Catálogo', 5.00),
('Promoção', 2.00);

insert into profissoes (nome) values
('Engenheiro'),
('Professor'),
('Designer'),
('Programador'),
('Gestor de Projetos');

insert into enderecos (logradouro, tipo_log, complemento, cidade, uf, cep, numero, bairro) values
('Paulista', 'Avenida', 'Apto 101', 'São Paulo', 'SP', '01310-000', '1000', 'Bela Vista'),
('Avenida Delfim Moreira', 'Avenida', '', 'Rio de Janeiro', 'RJ', '22441-000', '700', 'Leblon'),
('Rua Dias Ferreira', 'Rua', 'Sobreloja', 'Rio de Janeiro', 'RJ', '22431-050', '1500', 'Leblon'),
('Rua Moreira César', 'Rua', 'Sala 101', 'Niterói', 'RJ', '24230-151', '350', 'Icaraí'),
('Avenida Quintino Bocaiúva', 'Avenida', 'Cobertura', 'Niterói', 'RJ', '24360-022', '1000', 'São Francisco'),
('Rua Gavião Peixoto', 'Rua', '', 'Niterói', 'RJ', '24220-000', '450', 'Icaraí'),
('Rua Presidente Pedreira', 'Rua', 'Casa 2', 'Niterói', 'RJ', '24210-470', '210', 'Ingá');

insert into filmes (titulo_original, titulo, quantidade, fk_categoria, fk_genero) values
('Cake', 'Cake - Uma Razão para Viver', 2, 2, 2),
('The Godfather', 'O Poderoso Chefão', 2, 2, 2),
('The Dark Knight', 'O Cavaleiro das Trevas', 2, 1, 1),
('Pulp Fiction', 'Pulp Fiction: Tempo de Violência', 2, 2, 2),
('Forrest Gump', 'Forrest Gump: O Contador de Histórias', 1, 2, 2),
('The Switch', 'Coincidências do Amor', 2, 1, 7),
('Fight Club', 'Clube da Luta', 3, 2, 2),
('The Matrix', 'Matrix', 3, 1, 5),
('The Avengers', 'Os Vingadores', 4, 1, 6),
('Were the Millers', 'Família do Bagulho', 1, 2, 3),
('Star Wars: Episode IV - A New Hope', 'Star Wars: Episódio IV - Uma Nova Esperança', 1, 2, 6),
('The Silence of the Lambs', 'O Silêncio dos Inocentes', 2, 2, 4),
('Jurassic Park', 'Jurassic Park: O Parque dos Dinossauros', 1, 2, 6),
('Joker', 'Coringa', 2, 1, 4),
('Toy Story', 'Toy Story', 2, 2, 3);

insert into clientes (nome, cpf, telefone, fk_prof) values
('João Silva', '12345678901', '1112345678', 1),
('Maria Oliveira', '23456789012', '1123456789', 2),
('José Santos', '34567890123', '1134567890', 3),
('Ana Costa', '45678901234', '1145678901', 4),
('Paulo Souza', '56789012345', '1156789012', 5),
('Mariana Pereira', '67890123456', '1167890123', 2),
('Carlos Lima', '78901234567', '1178901234', 4),
('Juliana Mendes', '89012345678', '1189012345', 5),
('Pedro Almeida', '90123456789', '1190123456', 1),
('Luciana Barbosa', '01234567890', '1101234567', 4);

insert into cliente_endereco (fk_endereco, fk_cliente) values
(1, 1),
(2, 11),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

insert into filme_ator (fk_ator, fk_filme, isdiretor) values
(1, 1, false),
(11, 2, false), 
(5, 3, true), 
(8, 4, false), 
(5, 5, false),  
(1, 6, true), 
(2, 7, false),  
(4, 8, false),
(10, 9, false),
(9, 10, false), 
(7, 11, true),  
(3, 12, false), 
(5, 13, false), 
(6, 14, true);

insert into cliente_endereco (fk_cliente, fk_endereco) values
(1,1),
(2,2),
(3,2),
(4,3),
(5,4),
(6,4),
(7,5),
(8,6),
(9,7),
(10,7);

insert into dependentes (fk_cliente, fk_cliente_dep, parentesco) values
(2, 3, 'Esposa'),
(5, 6, 'Filho'),
(9, 10, 'Marido');

insert into locacoes (data_locacao, desconto, multa, sub_total, fk_cliente) values
('2024-06-01', 0.00, 0.00, 30.00, 1),
('2024-06-02', 5.00, 2.00, 25.00, 2),
('2024-06-03', 2.00, 0.00, 28.00, 3),
('2024-06-04', 0.00, 1.00, 20.00, 4),
('2024-06-05', 3.00, 0.00, 27.00, 5),
('2024-06-06', 1.00, 2.00, 22.00, 6),
('2024-06-07', 0.00, 0.00, 15.00, 7),
('2024-06-08', 4.00, 0.00, 26.00, 8),
('2024-06-09', 0.00, 3.00, 17.00, 9),
('2024-06-10', 2.00, 0.00, 30.00, 10),
('2024-06-11', 0.00, 1.00, 20.00, 1),
('2024-06-12', 1.00, 0.00, 18.00, 2),
('2024-06-13', 0.00, 2.00, 25.00, 3),
('2024-06-14', 3.00, 0.00, 22.00, 4),
('2024-06-15', 0.00, 0.00, 15.00, 5),
('2024-06-16', 2.00, 1.00, 30.00, 6),
('2024-06-17', 1.00, 0.00, 28.00, 7),
('2024-06-18', 0.00, 3.00, 25.00, 8),
('2024-06-19', 4.00, 0.00, 22.00, 9),
('2024-06-20', 0.00, 0.00, 30.00, 10);

insert into locacao_filme (valor, num_dias, data_devolucao, fk_filme, fk_locacao) values
(10.00, 5, '2024-06-06', 1, 1),
(15.00, 7, '2024-06-09', 2, 2),
(5.00, 3, '2024-06-06', 3, 3),
(20.00, 4, '2024-06-08', 4, 4),
(10.00, 6, '2024-06-11', 5, 5),
(8.00, 2, '2024-06-08', 6, 6),
(12.00, 5, '2024-06-12', 7, 7),
(10.00, 7, '2024-06-14', 8, 8),
(15.00, 3, '2024-06-12', 9, 9),
(10.00, 4, '2024-06-14', 10, 10),
(20.00, 5, '2024-06-16', 11, 11),
(25.00, 6, '2024-06-18', 12, 12),
(8.00, 2, '2024-06-15', 13, 13),
(10.00, 5, '2024-06-19', 14, 14),
(15.00, 7, '2024-06-22', 15, 15),
(5.00, 3, '2024-06-17', 1, 16),
(20.00, 4, '2024-06-20', 2, 17),
(10.00, 6, '2024-06-24', 3, 18),
(8.00, 2, '2024-06-20', 4, 19),
(12.00, 5, '2024-06-23', 5, 20);

select * from atores
select * from generos
select * from categorias
select * from profissoes
select * from enderecos
select * from filmes
select * from filme_ator
select * from clientes
select * from cliente_endereco
select * from locacoes
select * from locacao_filme
select * from dependentes

