CREATE DATABASE IF NOT EXISTS empresa_inseminacao;
USE empresa_inseminacao;

-- tabela de endereços --
CREATE TABLE endereco (
	id INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(100),
	numero int,
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2),
	pais VARCHAR(100)
);

-- Tabela de Fazendas
CREATE TABLE fazendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
	id_endereco INT,
    nome_fazenda VARCHAR(100),
	FOREIGN KEY (id_endereco) REFERENCES endereco(id)
);

-- Tabela de vacas
CREATE TABLE vacas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_fazenda INT,
    numero_animal INT,
    lote VARCHAR(50),
    vaca VARCHAR(50),
    categoria VARCHAR(50),
    ECC FLOAT,
    ciclicidade INT,
    peso DECIMAL(10,3),
    FOREIGN KEY (id_fazenda) REFERENCES fazendas(id)
);

-- Tabela de Inseminadores
CREATE TABLE inseminadores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_inseminador VARCHAR(100)
);

CREATE TABLE vendedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(11) UNIQUE NOT NULL
);

-- Tabela de Vendas
CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_fazenda INT,
	id_vendedor INT,
	protocolo varchar(100),
    data_venda DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_fazenda) REFERENCES fazendas(id),
	FOREIGN KEY (id_vendedor) REFERENCES vendedores(id)
);

CREATE TABLE visitas(
    id int AUTO_INCREMENT PRIMARY KEY,
    id_fazenda int NOT NULL,
    id_vendedor int NOT NULL,
    id_venda int,
    data_visita date NOT NULL,
    houve_venda TINYINT NOT NULL,
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id),
    FOREIGN KEY (id_fazenda) REFERENCES fazendas(id)
);

-- Tabela de Resultados de Inseminação
CREATE TABLE resultados_inseminacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_vaca INT,
	protocolo varchar(100),
    touro varchar(100),
    id_inseminador INT,
    id_venda INT,
    data_inseminacao DATE,
    numero_IATF VARCHAR(100),
    DG TINYINT,
    vazia_Com_Ou_Sem_CL TINYINT,
    perda TINYINT,
    FOREIGN KEY (id_vaca) REFERENCES vacas(id),
    FOREIGN KEY (id_inseminador) REFERENCES inseminadores(id),
    FOREIGN KEY (id_venda) REFERENCES vendas(id)
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(25) UNIQUE NOT NULL,
    password VARCHAR(25) NOT NULL
);

CREATE TABLE chats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(40) NOT NULL,
    user_id INT NOT NULL,
    id_gpt TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    text_usuario TEXT NOT NULL,
    text_servidor TEXT NOT NULL,
    chat_id INT NOT NULL,
    FOREIGN KEY (chat_id) REFERENCES chats(id)
);


use empresa_inseminacao;

-- Inserindo endereços --
INSERT INTO endereco (rua, numero, bairro, cidade, estado, pais) VALUES
('Rua Piracicaba', '123', 'Centro', 'Piracicaba', 'SP', 'Brasil'),
('Rua Uberlândia', '456', 'Centro', 'Uberlândia', 'MG', 'Brasil'),
('Rua Santa Maria', '789', 'Centro', 'Santa Maria', 'RS', 'Brasil'),
('Rua Cascavel', '1011', 'Centro', 'Cascavel', 'PR', 'Brasil'),
('Rua Rondonópolis', '1213', 'Centro', 'Rondonópolis', 'MT', 'Brasil'),
('Rua Catalão', '1415', 'Centro', 'Catalão', 'GO', 'Brasil'),
('Rua Feira de Santana', '1617', 'Centro', 'Feira de Santana', 'BA', 'Brasil'),
('Rua Chapecó', '1819', 'Centro', 'Chapecó', 'SC', 'Brasil'),
('Rua Volta Redonda', '2021', 'Centro', 'Volta Redonda', 'RJ', 'Brasil'),
('Rua Dourados', '2223', 'Centro', 'Dourados', 'MS', 'Brasil'),
('Rua Vitória', '2425', 'Centro', 'Vitória', 'ES', 'Brasil'),
('Rua Manaus', '2627', 'Centro', 'Manaus', 'AM', 'Brasil'),
('Rua Palmas', '2829', 'Centro', 'Palmas', 'TO', 'Brasil'),
('Rua Porto Velho', '3031', 'Centro', 'Porto Velho', 'RO', 'Brasil'),
('Rua Rio Branco', '3233', 'Centro', 'Rio Branco', 'AC', 'Brasil'),
('Rua Campinas', '3435', 'Centro', 'Campinas', 'SP', 'Brasil'),
('Rua Campo Grande', '3637', 'Centro', 'Campo Grande', 'MS', 'Brasil');


INSERT INTO fazendas (id_endereco, nome_fazenda) VALUES
(1, 'Fazenda Alegria'),
(2, 'Fazenda Floresta'),
(3, 'Fazenda Aurora'),
(4, 'Fazenda Vista Verde'),
(5, 'Fazenda Boa Esperança'),
(6, 'Fazenda Primavera'),
(7, 'Fazenda Sol Poente'),
(8, 'Fazenda Vale do Sol'),
(9, 'Fazenda Rio Claro'),
(10,  'Fazenda Santo Antônio'),
(11,  'Fazenda Esperança'),
(12,  'Fazenda Boa Vista'),
(13,  'Fazenda Bela Vista'),
(14,  'Fazenda Esperança'),
(15,  'Fazenda São Pedro'),
(16,  'Fazenda Boa Esperança');


INSERT INTO vacas (id_fazenda, numero_animal, lote, vaca, categoria, ECC, ciclicidade, peso) VALUES
(1, 112349, 'LT01MRJ', 'Nelore', 'Multípara', 3, 0, 400),
(2, 178423, 'LT02EX', 'Angus', 'Multípara', 3.5, 1, 600),
(3, 333423, 'LT03BV', 'Guzerá', 'Nulípara', 3, 0, 550),
(4, 446753, 'LT04SJ', 'Gir Leiteiro', 'Multípara', 2.75, 1, 500),
(5, 559023, 'LT05SN', 'Simental', 'Primípara tardia', 4, 0, 550),
(6, 678431, 'LT06BE', 'Charolês', 'Multípara', 3.75, 1, 600),
(7, 700940, 'LT07SR', 'Brahman', 'Primípara precoce', 2.5, 1, 550),
(8, 809843, 'LT08PS', 'Angus', 'Multípara', 3.25, 1, 600),
(9, 994758, 'LT09SF', 'Hereford', 'Nulípara', 3.5, 1, 600),
(10, 109384, 'LT10BV', 'Bonsmara', 'Primípara precoce', 3, 1, 500),
(11, 119011, 'LT11PV', 'Girolando', 'Secundípara', 2.75, 1, 550),
(12, 149820, 'LT14EP', 'Holandesa', 'Primípara precoce', 3.25, 1, 600),
(13, 151423, 'LT15CA', 'Tabapuã', 'Primípara tardia', 3.5, 1, 500),
(14, 222333, 'LT16AA', 'Simental', 'Primípara tardia', 3.8, 0, 550),
(15, 333444, 'LT17BB', 'Brahman', 'Primípara precoce', 2.7, 1, 550);

INSERT INTO vacas (id_fazenda, numero_animal, lote, vaca, categoria, ECC, ciclicidade, peso) VALUES
(1, 1001, 'Lote A', 'Bela', 'Leiteira', 3.5, 2, 500),
(2, 2001, 'Lote B', 'Foguete', 'Corte', 3.8, 3, 600),
(3, 3001, 'Lote C', 'Diamante', 'Leiteira', 4.0, 2, 550),
(1, 1002, 'Lote D', 'Esperança', 'Corte', 3.7, 2, 600),
(2, 2002, 'Lote E', 'Aurora', 'Leiteira', 3.9, 3, 550),
(3, 3002, 'Lote F', 'Cacau', 'Corte', 4.1, 2, 500),
(1, 1003, 'Lote G', 'Lua', 'Leiteira', 3.6, 2, 550),
(2, 2003, 'Lote H', 'Estrela', 'Corte', 4.0, 3, 600),
(3, 3003, 'Lote I', 'Pérola', 'Leiteira', 3.8, 2, 550),
(1, 1004, 'Lote J', 'Rosa', 'Corte', 4.2, 3, 600),
(2, 2004, 'Lote K', 'Cristal', 'Leiteira', 3.7, 2, 550),
(3, 3004, 'Lote L', 'Jade', 'Corte', 3.9, 3, 500),
(1, 1005, 'Lote M', 'Íris', 'Leiteira', 3.9, 2, 550),
(2, 2005, 'Lote N', 'Sol', 'Corte', 3.5, 3, 600),
(3, 3005, 'Lote O', 'Marfim', 'Leiteira', 4.1, 2, 550),
(1, 1006, 'Lote P', 'Céu', 'Corte', 3.8, 2, 500),
(2, 2006, 'Lote Q', 'Rubi', 'Leiteira', 4.0, 3, 600),
(3, 3006, 'Lote R', 'Safira', 'Corte', 3.6, 2, 550),
(1, 1007, 'Lote S', 'Estrela do Mar', 'Leiteira', 4.2, 2, 600),
(12, 2007, 'Lote T', 'Amora', 'Corte', 3.7, 3, 550),
(3, 3007, 'Lote U', 'Polar', 'Leiteira', 3.8, 2, 550);

INSERT INTO inseminadores (nome_inseminador) VALUES
('Rafael'),
('Bruna'),
('Henrique'),
('Carlos'),
('Daniela'),
('Felipe'),
('James'),
('Karla'),
('Marcos'),
('Jader'),
('Bernardo'),
('Josafá'),
('Daniel'),
('Mariana'),
('Lucas');

INSERT INTO vendedores (nome, cpf) VALUES
('Lucas Martins', '12345678901'),
('Camila Ribeiro', '23456789012'),
('Tiago Neves', '34567890123'),
('Juliana Costa', '45678901234'),
('Marcelo Silva', '56789012345'),
('Fernanda Lima', '67890123456'),
('Rodrigo Pereira', '78901234567'),
('Beatriz Santos', '89012345678'),
('Gustavo Gomes', '90123456789'),
('Amanda Souza', '01234567890');

INSERT INTO vendas (id_fazenda, id_vendedor, protocolo, data_venda, valor_total) VALUES
(1, 1, 'Protocolo de Sincronização Rápida', '2024-01-10', 1500.00),
(2, 2, 'Protocolo de Sincronização Estendida', '2024-01-15', 2000.00),
(3, 3, 'Protocolo de Sincronização Completa', '2024-01-20', 1800.00),
(4, 4, 'Protocolo de Sincronização Moderada', '2024-01-25', 1700.00),
(5, 5, 'Protocolo de Sincronização Estendida Completa', '2024-01-30', 2200.00),
(6, 6, 'Protocolo de Sincronização Rápida', '2024-02-05', 1600.00),
(7, 7, 'Protocolo de Sincronização Estendida', '2024-02-10', 2100.00),
(8, 8, 'Protocolo de Sincronização Completa', '2024-02-15', 1900.00),
(9, 9, 'Protocolo de Sincronização Moderada', '2024-02-20', 1750.00),
(10, 10, 'Protocolo de Sincronização Estendida Completa', '2024-02-25', 2300.00),
(11, 1, 'Protocolo de Sincronização Rápida', '2024-03-01', 1550.00),
(12, 2, 'Protocolo de Sincronização Estendida', '2024-03-05', 2050.00),
(13, 3, 'Protocolo de Sincronização Completa', '2024-03-10', 1850.00),
(14, 4, 'Protocolo de Sincronização Moderada', '2024-03-15', 1650.00),
(15, 5, 'Protocolo de Sincronização Estendida Completa', '2024-03-20', 2250.00),
(16, 6, 'Protocolo de Sincronização Rápida', '2024-04-01', 1575.00),
(1, 7, 'Protocolo de Sincronização Estendida', '2024-04-10', 2075.00),
(2, 8, 'Protocolo de Sincronização Completa', '2024-04-20', 1875.00),
(3, 9, 'Protocolo de Sincronização Moderada', '2024-04-30', 1675.00),
(4, 2, 'Protocolo de Sincronização Estendida Completa', '2024-05-10', 2275.00),
(5, 1, 'Protocolo de Sincronização Rápida', '2024-05-20', 1600.00),
(6, 1, 'Protocolo de Sincronização Estendida', '2024-05-30', 2100.00),
(7, 2, 'Protocolo de Sincronização Completa', '2024-06-10', 1900.00),
(8, 3, 'Protocolo de Sincronização Moderada', '2024-06-20', 1750.00),
(9, 4, 'Protocolo de Sincronização Estendida Completa', '2024-06-30', 2300.00);

INSERT INTO resultados_inseminacao (id_vaca, protocolo, touro, id_inseminador, id_venda, data_inseminacao, numero_IATF, DG, vazia_Com_Ou_Sem_CL, perda) VALUES
(1, 'Protocolo de Sincronização Rápida', 'Max', 1, 1, '2024-01-12', 'IATF001', 1, 0, 0),
(2, 'Protocolo de Sincronização Estendida', 'Bella', 2, 2, '2024-01-17', 'IATF002', 1, 0, 0),
(3, 'Protocolo de Sincronização Completa', 'Charlie', 3, 3, '2024-01-22', 'IATF003', 0, 1, 0),
(4, 'Protocolo de Sincronização Moderada', 'Lucy', 4, 4, '2024-01-27', 'IATF004', 1, 0, 0),
(5, 'Protocolo de Sincronização Estendida Completa', 'Rocky', 5, 5, '2024-02-01', 'IATF005', 1, 0, 0),
(6, 'Protocolo de Sincronização Rápida', 'Molly', 6, 6, '2024-02-07', 'IATF006', 0, 1, 0),
(7, 'Protocolo de Sincronização Estendida', 'Buddy', 7, 7, '2024-02-12', 'IATF007', 1, 0, 0),
(8, 'Protocolo de Sincronização Completa', 'Daisy', 8, 8, '2024-02-17', 'IATF008', 1, 0, 0),
(9, 'Protocolo de Sincronização Moderada', 'Bailey', 9, 9, '2024-02-22', 'IATF009', 0, 1, 0),
(10, 'Protocolo de Sincronização Estendida Completa', 'Sadie', 10, 10, '2024-02-27', 'IATF010', 1, 0, 0),
(11, 'Protocolo de Sincronização Rápida', 'Maggie', 11, 11, '2024-03-03', 'IATF011', 0, 0, 0),
(12, 'Protocolo de Sincronização Estendida', 'Max', 12, 12, '2024-03-08', 'IATF012', 0, 1, 0),
(13, 'Protocolo de Sincronização Completa', 'Bella', 13, 13, '2024-03-13', 'IATF013', 1, 0, 0),
(14, 'Protocolo de Sincronização Moderada', 'Charlie', 14, 14, '2024-03-18', 'IATF014', 1, 0, 0),
(15, 'Protocolo de Sincronização Estendida Completa', 'Lucy', 2, 15, '2024-03-23', 'IATF015', 0, 1, 0),
(16, 'Protocolo de Sincronização Rápida', 'Rocky', 1, 16, '2024-04-05', 'IATF016', 1, 0, 0),
(1, 'Protocolo de Sincronização Estendida', 'Molly', 1, 17, '2024-04-12', 'IATF017', 1, 0, 0),
(2, 'Protocolo de Sincronização Completa', 'Buddy', 2, 18, '2024-04-22', 'IATF018', 0, 1, 0),
(3, 'Protocolo de Sincronização Moderada', 'Daisy', 3, 19, '2024-05-02', 'IATF019', 1, 0, 0),
(4, 'Protocolo de Sincronização Estendida Completa', 'Lucy', 4, 20, '2024-05-12', 'IATF020', 1, 0, 0),
(9, 'Protocolo de Sincronização Moderada', 'Bailey', 9, 9, '2024-07-01', 'IATF009', 1, 1, 0);

INSERT INTO visitas (id_fazenda, id_venda, id_vendedor,data_visita, houve_venda) VALUES
(1, 1, 1, '2024-01-10', 1),
(2, 2, 2, '2024-01-15', 1),
(3, 3, 3, '2024-01-20', 1),
(4, 4, 4, '2024-01-25', 1),
(5, 5, 5, '2024-01-30', 1),
(6, 6, 6, '2024-02-05', 1),
(6, NULL, 2, '2024-02-04', 0),
(7, 7, 7, '2024-02-10', 1),
(8, 8, 8, '2024-02-15', 1),
(9, NULL, 9, '2024-02-16', 0),
(9, 9, 9, '2024-02-20', 1),
(10, 10, 10, '2024-02-25', 1),
(11, 11, 1, '2024-03-01', 1),
(12, 12, 2, '2024-03-05', 1),
(12, NULL, 1, '2024-03-07', 0),
(13, 13, 3, '2024-03-10', 1),
(14, 14, 4, '2024-03-15', 1),
(15, NULL, 10, '2024-03-19', 0),
(15, 15, 5, '2024-03-20', 0),
(16, 16, 6, '2024-04-01', 1),
(1, 1, 7, '2024-04-10', 1),
(2, 2, 8, '2024-04-20', 1),
(3, NULL, 3, '2024-04-29', 0),
(4, 4, 2, '2024-05-10', 1);
