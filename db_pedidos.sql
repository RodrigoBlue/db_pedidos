CREATE SCHEMA IF NOT EXISTS db_pedidos DEFAULT CHARSET=UTF8 ;
USE db_pedidos;

-- -----------------------------------------------------
-- Table `db_pedidos`.`tbl_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tbl_cliente (
  `nome_cliente` VARCHAR(45) NULL DEFAULT NULL,
  `cpf_cliente` VARCHAR(14) NULL DEFAULT NULL,
  `cod_cliente` INT NOT NULL,
  PRIMARY KEY (`cod_cliente`))
ENGINE=MyISAM DEFAULT CHARSET=UTF8;


-- -----------------------------------------------------
-- Table `db_pedidos`.`tbl_produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tbl_produtos (
  `cod_produto` INT UNSIGNED NOT NULL,
  `valor` FLOAT NULL DEFAULT NULL,
  `nome_produto` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cod_produto`))
ENGINE=MyISAM DEFAULT CHARSET=UTF8;


-- -----------------------------------------------------
-- Table `db_pedidos`.`tbl_vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tbl_vendedor (
  `cod_vendedor` INT UNSIGNED NOT NULL,
  `cpf_vendedor` VARCHAR(45) NULL DEFAULT NULL,
  `nome_vendedor` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cod_vendedor`))
ENGINE=MyISAM DEFAULT CHARSET=UTF8;


-- -----------------------------------------------------
-- Table `db_pedidos`.`tbl_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tbl_pedidos(
  `cod_pedidos` INT UNSIGNED NOT NULL,
  `cod_cliente` INT NULL DEFAULT NULL,
  `cod_vendedor` INT NULL DEFAULT NULL,
  INDEX `cod_cliente` (`cod_cliente` ASC) VISIBLE,
  INDEX `fk_tbl_pedidos_tbl_vendedor_idx` (`cod_vendedor` ASC) VISIBLE,
  PRIMARY KEY (`cod_pedidos`))
ENGINE=MyISAM DEFAULT CHARSET=UTF8;


-- -----------------------------------------------------
-- Table `db_pedidos`.`tbl_itens_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tbl_itens_pedidos (
  `cod_int_pedidos` INT UNSIGNED NULL DEFAULT NULL,
  `cod_produtos` INT UNSIGNED NULL DEFAULT NULL,
  `cod_pedidos` INT UNSIGNED NULL DEFAULT NULL,
  `quant` INT UNSIGNED NULL DEFAULT NULL,
  INDEX `cod_produtos` (`cod_produtos` ASC) VISIBLE,
  INDEX `cod_pedidos` (`cod_pedidos` ASC) VISIBLE)
ENGINE=MyISAM DEFAULT CHARSET=UTF8;

select * from tbl_produtos;
insert into tbl_produtos(cod_produto, nome_produto, valor) values('121', 'frango', '10.77' );
insert into tbl_produtos(cod_produto, nome_produto, valor) values('663', 'guarana', '3.88' );
insert into tbl_produtos(cod_produto, nome_produto, valor) values('341', 'azeite', '19.65' );
insert into tbl_produtos(cod_produto, nome_produto, valor) values('633', 'miojo', '1.55' );
insert into tbl_produtos(cod_produto, nome_produto, valor) values('512', 'cucuz', '2.66' );
insert into tbl_produtos(cod_produto, nome_produto, valor) values('235', 'guaranajesus', '4.66' );

select * from tbl_vendedor;
insert into tbl_vendedor(cod_vendedor, nome_vendedor, cpf_vendedor) values ("05", "ricardo", "95682347112");
insert into tbl_vendedor(cod_vendedor, nome_vendedor, cpf_vendedor) values ("01", "bruna", "74859612474");
insert into tbl_vendedor(cod_vendedor, nome_vendedor, cpf_vendedor) values ("04", "luiza", "84858526231");

select * from tbl_pedidos;
insert into tbl_pedidos(cod_pedidos, cod_vendedor, cod_cliente) values('01', '05', '12');
insert into tbl_pedidos(cod_pedidos, cod_vendedor, cod_cliente) values('02', '01', '77');
insert into tbl_pedidos(cod_pedidos, cod_vendedor, cod_cliente) values('03', '04', '14');
insert into tbl_pedidos(cod_pedidos, cod_vendedor, cod_cliente) values('04', null, '99');
insert into tbl_pedidos(cod_pedidos, cod_vendedor, cod_cliente) values('05', null, null);
insert into tbl_pedidos(cod_pedidos, cod_vendedor, cod_cliente) values('06', null, null);



select * from tbl_itens_pedidos;
insert into tbl_itens_pedidos(cod_int_pedidos, cod_produtos, cod_pedidos, quant) values ('010', '121', '01', '7') ;
insert into tbl_itens_pedidos(cod_int_pedidos, cod_produtos, cod_pedidos, quant) values ('011', '663', '02', '3');
insert into tbl_itens_pedidos(cod_int_pedidos, cod_produtos, cod_pedidos, quant) values ('045', '341', '03', '8');
insert into tbl_itens_pedidos(cod_int_pedidos, cod_produtos, cod_pedidos, quant) values ('024', '633', '04', '5');
insert into tbl_itens_pedidos(cod_int_pedidos, cod_produtos, cod_pedidos, quant) values ('065', '512', null, '6');

select * from tbl_cliente;
insert into tbl_cliente(cod_cliente, nome_cliente, cpf_cliente) values('12', 'joao', '67184965841');
insert into tbl_cliente(cod_cliente, nome_cliente, cpf_cliente) values('77', 'maria', '85469213567');
insert into tbl_cliente(cod_cliente, nome_cliente, cpf_cliente) values('14', 'pedro', '45123652365');
insert into tbl_cliente(cod_cliente, nome_cliente, cpf_cliente) values('99', 'elson', '51697435869');
insert into tbl_cliente(cod_cliente, nome_cliente, cpf_cliente) values('61', 'isaque', '77445581236');

-- Consultar o nome do cliente e o nome do vendedor do pedido 1.
select nome_cliente, nome_vendedor, cod_pedidos
from tbl_cliente, tbl_vendedor, tbl_pedidos
where tbl_cliente.cod_cliente = tbl_pedidos.cod_cliente and tbl_vendedor.cod_vendedor = tbl_pedidos.cod_vendedor
and cod_pedidos = '01';

-- Consultar todos os pedidos efetuados
select count(cod_pedidos)
from tbl_pedidos;

-- Consultar o nome de todos os itens do pedido 2.
select nome_produto, cod_pedidos
from tbl_pedidos, tbl_produtos
where cod_pedidos = '02';

select tbl_produtos.cod_produto, tbl_itens_pedidos.quant
from tbl_produtos, tbl_itens_pedidos
where tbl_itens_pedidos.cod_produtos = tbl_produtos.cod_produto
group by quant
order by cod_produto;

select tbl_produtos.cod_produto, tbl_itens_pedidos.quant, tbl_produtos.nome_produto 
from tbl_produtos, tbl_itens_pedidos
where tbl_itens_pedidos.cod_produtos = tbl_produtos.cod_produto
order by nome_produto desc;

select tbl_produtos.cod_produto, tbl_produtos.nome_produto, tbl_pedidos.cod_pedidos
from tbl_produtos, tbl_itens_pedidos, tbl_pedidos
group by cod_produto;

SELECT nome_produto AS 'nome do produto',
       cod_produto as 'produto',
       nome_cliente,
       count(cod_pedidos) as `pedidos`
 FROM tbl_cliente, tbl_produtos, tbl_pedidos;
 
select count(cod_pedidos) as 'pedidos',
	   nome_cliente as 'cliente'
from tbl_cliente, tbl_pedidos;

SELECT nome_cliente AS cliente,
       cod_produto AS produto,
       SUM(quant) AS quantidade
  FROM tbl_cliente, tbl_produtos, tbl_itens_pedidos
 WHERE cod_produto = '121' and nome_cliente = 'maria';



