-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS uplife_cursos;
USE uplife_cursos;

-- Tabela de usuários
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo_usuario ENUM('aluno', 'admin') DEFAULT 'aluno'
);

-- Tabela de categorias
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL,
    descricao TEXT
);

-- Tabela de cursos
CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) DEFAULT 0.00,
    duracao VARCHAR(50),
    professor VARCHAR(100),
    categoria_id INT,
    data_publicacao DATE,
    status ENUM('ativo', 'inativo') DEFAULT 'ativo',
    FOREIGN KEY (categoria_id) REFERENCES categorias(id_categoria)
);

-- Tabela de matrículas
CREATE TABLE matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_curso INT,
    data_matricula DATETIME DEFAULT CURRENT_TIMESTAMP,
    progresso INT DEFAULT 0,
    status ENUM('ativo', 'concluido', 'cancelado') DEFAULT 'ativo',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

-- Tabela de certificados
CREATE TABLE certificados (
    id_certificado INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT,
    data_emissao DATETIME DEFAULT CURRENT_TIMESTAMP,
    codigo_verificacao VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula)
);

-- Tabela de planos de assinatura
CREATE TABLE planos_assinatura (
    id_plano INT AUTO_INCREMENT PRIMARY KEY,
    nome_plano VARCHAR(100) NOT NULL,
    descricao TEXT,
    duracao_meses INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela de assinaturas
CREATE TABLE assinaturas (
    id_assinatura INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_plano INT,
    data_inicio DATE,
    data_fim DATE,
    status ENUM('ativa', 'inativa') DEFAULT 'ativa',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_plano) REFERENCES planos_assinatura(id_plano)
);

-- Tabela de pagamentos
CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pagamento VARCHAR(50),
    status_pagamento ENUM('pago', 'pendente', 'cancelado') DEFAULT 'pago',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabela de gamificação
CREATE TABLE gamificacao (
    id_gamificacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    pontos INT DEFAULT 0,
    nivel INT DEFAULT 1,
    data_ultima_atividade DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

