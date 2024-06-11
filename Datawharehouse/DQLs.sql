# Quantos clientes o restaurante teve desde a abertura ?
select count(*) from tb_cliente;

# Quantas vezes estes clientes estiveram no restaurante ?
select count(*) from tb_mesa;

# Quantas vezes estes clientes estiveram no restaurante acompanhados ?
describe tb_mesa;
select count(*) from tb_mesa where num_pessoa_mesa >1;

#Qual o período do ano em que o restaurante tem maior movimento
-- ???

# Quantas mesas estão em dupla no dia dos namorados ?
select count(*),year(data_hora_entrada)
from tb_mesa
	where num_pessoa_mesa = 2 
	and day(data_hora_entrada) = 12 
    and month(data_hora_entrada) = 06
group by 2
order by 2
;

# Qual(is) o(s) cliente(s) que trouxe(ram) mais pessoas por ano
-- 1
select distinct year(data_hora_entrada)
from tb_mesa;
-- 2
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 10;
-- 3

select * 
from (
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 10)
union
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2023
group by 1,2
order by 3 desc
limit 10)
union(
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2024
group by 1,2
order by 3 desc
limit 10
)) as
tb_top10_major_consumer_per_year;

#2.1 Qual o cliente que mais fez pedidos por ano
-- ?? OK

select * 
from (
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(pd.quantidade_pedido) as qtd_pedido 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido pd
on ms.codigo_mesa = pd.codigo_mesa
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 1)
union
(
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(pd.quantidade_pedido) as qtd_pedido 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido pd
on ms.codigo_mesa = pd.codigo_mesa
where year(ms.data_hora_entrada) = 2023
group by 1,2
order by 3 desc
limit 1
)
union(
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(pd.quantidade_pedido) as qtd_pedido 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido pd
on ms.codigo_mesa = pd.codigo_mesa
where year(ms.data_hora_entrada) = 2024
group by 1,2
order by 3 desc
limit 1
)) as
tb_major_consumer_per_year;


#2.2 Qual o cliente que mais gastou em todos os anos
-- ??

select * 
from (
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(pr.preco_unitario_prato * pd.quantidade_pedido) as valor_pedido
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido pd
on ms.codigo_mesa = pd.codigo_mesa
left join tb_prato pr
on pd.codigo_prato = pr.codigo_prato
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 1)
union
(
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(pr.preco_unitario_prato * pd.quantidade_pedido) as valor_pedido
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido pd
on ms.codigo_mesa = pd.codigo_mesa
left join tb_prato pr
on pd.codigo_prato = pr.codigo_prato
where year(ms.data_hora_entrada) = 2023
group by 1,2
order by 3 desc
limit 1
)
union(
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(pr.preco_unitario_prato * pd.quantidade_pedido) as valor_pedido
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido pd
on ms.codigo_mesa = pd.codigo_mesa
left join tb_prato pr
on pd.codigo_prato = pr.codigo_prato
where year(ms.data_hora_entrada) = 2024
group by 1,2
order by 3 desc
limit 1
)) as
tb_mais_gastou_por_ano;

#2.3 Qual(is) o(s) cliente(s) trouxe(ram) mais pessoas por ano
-- ??

-- 1
select distinct year(data_hora_entrada)
from tb_mesa;
-- 2
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 1;
-- 3

select * 
from (
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 1)
union
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2023
group by 1,2
order by 3 desc
limit 1)
union(
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2024
group by 1,2
order by 3 desc
limit 1
)) as
tb_top10_major_consumer_per_year;

#2.4 Qual a empresa que tem mais funcionários como clientes do restaurante
-- ??
select * from `tb_empresa`;

select * 
from (
(select em.nome_empresa as empresa, count(bn.email_funcionario) 
from tb_empresa em
left join tb_beneficio bn
on bn.codigo_empresa = em.codigo_empresa
left join tb_cliente cl
on bn.email_funcionario = cl.email_cliente
where bn.email_funcionario = cl.email_cliente
group by 1
order by 2 desc
limit 3))as
tb_cliente_funcionario;

#2.5 Qual empresa que tem mais funcionários que consomem sobremesas no restaurante por ano
-- ??
-- quantidade de sobremesa que foram pedidas
select tp.nome_tipo_prato, count(p.nome_prato)
from tb_prato p
left join tb_tipo_prato tp
on p.codigo_tipo_prato = tp.codigo_tipo_prato
left join tb_pedido 
on tb_pedido.codigo_prato = p.codigo_prato
where tp.codigo_tipo_prato = 3
group by 1
order by 1;


-- quantidade de pedidos por funcionário
select * 
from (
(select em.nome_empresa as empresa, cl.nome_cliente, sum(pd.quantidade_pedido) as qtd_pedido_func
from tb_empresa em
left join tb_beneficio bn
on bn.codigo_empresa = em.codigo_empresa
left join tb_cliente cl
on bn.email_funcionario = cl.email_cliente
left join tb_mesa ms
on ms.id_cliente = cl.id_cliente
left join tb_pedido pd
on pd.codigo_mesa = ms.codigo_mesa
where bn.email_funcionario = cl.email_cliente
group by em.nome_empresa, cl.nome_cliente
order by 3 desc
))as
tb_funcionario_pedido;

-- quandidade de sobremesa por empresa/funcionário
select * 
from (
(select em.nome_empresa as empresa, count(bn.email_funcionario) as qtd_ped_sobremesa
from tb_empresa em
left join tb_beneficio bn
on bn.codigo_empresa = em.codigo_empresa
left join tb_cliente cl
on bn.email_funcionario = cl.email_cliente
left join tb_mesa ms
on ms.id_cliente = cl.id_cliente
left join tb_pedido pd
on pd.codigo_mesa = ms.codigo_mesa
left join tb_prato pr
on pr.codigo_prato = pd.codigo_prato
left join tb_tipo_prato tp
on tp.codigo_tipo_prato = pr.codigo_tipo_prato
where (bn.email_funcionario = cl.email_cliente) and (pr.codigo_tipo_prato = 3)
group by 1
order by 2 desc
limit 1))as
tb_func_sobremesa;
