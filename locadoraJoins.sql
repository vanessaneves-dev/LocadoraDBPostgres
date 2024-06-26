select * from atores
select * from categorias
select * from generos
select * from filmes
select * from filme_ator
select * from profissoes
select * from clientes	
select * from enderecos
select * from cliente_endereco
select * from dependentes
select * from locacoes
select * from locacao_filme;
	
-- 1- Listar todos os filmes alugados por um cliente específico,incluindo a data de locação e a data de devolução.

select clientes.nome as Cliente, 
		filmes.titulo as Filme, 
		locacoes.data_locacao as DataLocação,
		locacao_filme.data_devolucao as DataDevolução
from clientes
join locacoes on clientes.id = locacoes.fk_cliente
join locacao_filme on locacoes.id = locacao_filme.fk_locacao
join filmes on locacao_filme.fk_filme = filmes.id
where clientes.id = 3;

-- 2  - Obter uma lista de clientes e seus dependentes.

select c.nome as ClientePrincipal,
		d.nome as Dependente,
		dep.parentesco as Parentesco
from clientes c
join dependentes dep on c.id = dep.fk_cliente
join clientes d on dep.fk_cliente_dep = d.id;

-- 3  - Listar todos os filmes de um determinado gênero.

select f.titulo as Filme,
		g.nome as Genero
from filmes f
join generos g on f.fk_genero = g.id
where g.id = 2;

-- 4  - Exibir todos os clientes que têm uma profissão específica.

select c.nome as Cliente,
		p.nome as Profissão
from clientes c
join profissoes p on c.fk_prof = p.id
where p.id = 5;


-- 5  - Encontrar todos os filmes em uma categoria específica com quantidade disponível maior que 5.
/* atualizações necessárias para a consulta ter resultado*/
update filmes
	set quantidade = 6
	where fk_categoria = 2

update filmes
	set quantidade = 8
	where fk_genero = 2

update filmes
	set quantidade = 5
	where fk_genero = 6

select f.titulo as Filme,
		c.nome as Categoria,
		f.quantidade as Quatidade
from filmes f
join categorias c on f.fk_categoria = c.id
where f.quantidade > 5;
	
-- 6  - Listar todos os atores que participaram de filmes com um determinado título.
--inserindo mais atores em filmes
insert into filme_ator (fk_ator, fk_filme, isdiretor) values
	(1, 5, false),
	(3, 5, false),
	(7, 5, false),
	(1, 10, false),
	(4, 10, false),
	(5, 10, false),
	(3, 3, false)

select  a.nome as Ator, f.titulo as Filme
	from atores a
	join filme_ator fa on a.id = fa.fk_ator
	join filmes f on fa.fk_filme = f.id
	where f.id = 5
-- pesquisando pelo id do filme, se não souber o nome, caso saiba o where seria o abaixo:
	where f.titulo = "nome do filme"	


-- 7  - Obter o endereço completo de um cliente específico.

select 
    c.nome as Cliente,
    e.tipo_log || ' ' || e.logradouro || ', ' || e.numero || 
    coalesce(', ' || e.complemento, '') || 
    ', ' || e.bairro || ', ' || e.cidade || ' - ' || e.uf || ', CEP: ' || e.cep as EnderecoCompleto
from 
    clientes c
join 
    cliente_endereco ce on c.id = ce.fk_cliente
join 
    enderecos e ON ce.fk_endereco = e.id
where 
    c.id = 1;  
	
-- 8  - Listar todos os filmes e seus respectivos gêneros e categorias.	

select 
    f.titulo as Filme,
    g.nome as Genero,
    c.nome as Categoria
from filmes f
join generos g ON f.fk_genero = g.id
join categorias c ON f.fk_categoria = c.id
	
	
-- 9  - Mostrar todos os clientes que alugaram um filme específico e a data de locação.

select 
    c.nome as Cliente,
    l.data_locacao as DataLocacao,
    f.titulo as Filme
from locacoes l
join locacao_filme lf on l.id = lf.fk_locacao
join clientes c on l.fk_cliente = c.id
join filmes f on lf.fk_filme = f.id
where f.id = 5;

-- 10 - Exibir a lista de clientes com multas superiores a um valor específico.

select c.nome as Cliente,
   		l.multa as Multa
from clientes c
join locacoes l on c.id = l.fk_cliente
where l.multa > "valor"

-- 11 - Listar todas as locações feitas em um período específico.

select l.id as LocacaoID,
		c.nome as Cliente, 
		l.data_locacao as DataLocacao
from locacoes l
join clientes c on l.fk_cliente = c.id
where l.data_locacao between '2024-06-01' and '2024-06-15'; --exemplo de data

-- 12 - Obter a quantidade total de filmes alugados por cada cliente. (DESAFIO)
/*insert para variar o resultado da consulta que estava 2 para cada cliente*/
	insert into locacoes (data_locacao, desconto, multa, sub_total, fk_cliente) values
	('2024-06-21', 0.00, 4.00, 30.00, 4),
	('2024-06-21', 0.00, 4.00, 30.00, 3),
	('2024-06-23', 0.00, 4.00, 25.00, 4),
	('2024-06-21', 0.00, 4.00, 30.00, 5)

	insert into locacao_filme (valor, num_dias, data_devolucao, fk_filme, fk_locacao) values
	(10.00, 5, '2024-06-26', 12, 21),
	(10.00, 5, '2024-06-26', 10, 22),
	(10.00, 5, '2024-06-28', 2, 23),
	(10.00, 5, '2024-06-26', 5, 24)
	
select c.nome as Cliente,
    count(lf.id) as TotalFilmesAlugados
from clientes c
join locacoes l on c.id = l.fk_cliente
join locacao_filme lf on l.id = lf.fk_locacao
group by c.nome
order by TotalFilmesAlugados desc;

-- 13 - Listar os clientes e os filmes que eles alugaram, ordenados por data de locação.
	
select c.nome as Cliente,
   		f.titulo as Filme,
   		l.data_locacao as DataLocacao
from locacao_filme lf
join locacoes l on lf.fk_locacao = l.id
join clientes c on l.fk_cliente = c.id
join filmes f ON lf.fk_filme = f.id
order by l.data_locacao ASC;


-- 14 - Mostrar todos os clientes que moram em uma cidade específica e que alugaram filmes de uma categoria específica.

select c.nome as Cliente,
		e.cidade as Cidade,
		f.titulo as Filme,
		ca.nome as Categoria
from clientes c
join cliente_endereco ce on c.id = ce.fk_endereco
join enderecos e on ce.fk_endereco = e.id
join locacoes l on c.id = l.fk_cliente
join locacao_filme lf on l.id = lf.fk_locacao
join filmes f on lf.fk_filme = f.id
join categorias ca on f.fk_categoria = ca.id
where e.cidade = 'Rio de Janeiro' and ca.id = 2; -- exemplo de busca



/* 15 - Encontrar todos os atores que participaram de pelo menos 5 filmes,
	listando o nome do ator e o número de filmes em que atuou. (DESAFIO) */
--inserindo mais atores em filmes
insert into filme_ator (fk_ator, fk_filme, isdiretor)
values
    (5, 2, false),
    (1, 2, false),
    (1, 3, false),
    (5, 7, false),
    (3, 8, true),
    (3, 10, false);
	

select a.nome as Ator,
count (fa.fk_filme) as NumFilmes
from atores a
join filme_ator fa on a.id = fa.fk_ator
group by a.nome
having count (fa.fk_filme) >= 5;

/* 16 - Exibir a quantidade total de filmes alugados por categoria e gênero, 
     incluindo apenas as categorias e gêneros que têm mais de 5 filmes alugados no total (DESAFIO)*/ 

select ca.nome as Categoria,
		g.nome as Genero,
count (lf.fk_filme) as TotalFilmesAlugados
from locacao_filme lf
join filmes f on lf.fk_filme = f.id
join categorias ca on f.fk_categoria = ca.id
join generos g on f.fk_genero = g.id
group by ca.nome, g.nome
having count (lf.fk_filme) > 5;
