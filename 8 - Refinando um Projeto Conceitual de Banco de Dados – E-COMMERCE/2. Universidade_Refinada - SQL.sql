-- MySQL Script generated by MySQL Workbench
-- qui 29 set 2022 22:24:30
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(120) NULL,
  `CPF` VARCHAR(14) NULL,
  `Contato` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pedido` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Servico` VARCHAR(120) NULL,
  `Descricao` VARCHAR(255) NULL,
  `Data_Solicitacao` DATE NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Finalizado` TINYINT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`),
  INDEX `fk_Pedido_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Responsavel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Responsavel` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Responsavel` (
  `idResponsavel` INT NOT NULL AUTO_INCREMENT,
  `Nivel_HelpDesk` INT NULL,
  `Nome` VARCHAR(120) NULL,
  `Departamento` VARCHAR(120) NULL,
  PRIMARY KEY (`idResponsavel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ordem_Servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ordem_Servico` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Ordem_Servico` (
  `idOrdem_Servico` INT NOT NULL AUTO_INCREMENT,
  `Status_OS` VARCHAR(120) NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idOrdem_Servico`, `Pedido_idPedido`, `Pedido_Cliente_idCliente`),
  INDEX `fk_Ordem_Servico_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_Servico_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente`)
    REFERENCES `mydb`.`Pedido` (`idPedido` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Analise_Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Analise_Pedido` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Analise_Pedido` (
  `Responsavel_idResponsavel` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`Responsavel_idResponsavel`, `Pedido_idPedido`),
  INDEX `fk_Responsavel_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Responsavel_has_Pedido_Responsavel1_idx` (`Responsavel_idResponsavel` ASC) VISIBLE,
  CONSTRAINT `fk_Responsavel_has_Pedido_Responsavel1`
    FOREIGN KEY (`Responsavel_idResponsavel`)
    REFERENCES `mydb`.`Responsavel` (`idResponsavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Responsavel_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pessoa` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pessoa` (
  `idPessoa` INT NOT NULL,
  `Nome` VARCHAR(120) NOT NULL,
  `CPF` VARCHAR(14) NOT NULL,
  `Data_Nascimento` DATE NOT NULL,
  `Endereco` VARCHAR(255) NULL,
  `Contato` VARCHAR(45) NULL,
  `Email` VARCHAR(120) NULL,
  PRIMARY KEY (`idPessoa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aluno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Aluno` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Aluno` (
  `idAluno` INT NOT NULL AUTO_INCREMENT,
  `Pessoa_idPessoa` INT NOT NULL,
  `Matricula` VARCHAR(9) GENERATED ALWAYS AS (),
  PRIMARY KEY (`idAluno`),
  INDEX `fk_Aluno_Pessoa1_idx` (`Pessoa_idPessoa` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa`)
    REFERENCES `mydb`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Departamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(120) NOT NULL,
  `Campus` VARCHAR(120) NULL,
  `idProfessor_Coordenador` INT NOT NULL,
  PRIMARY KEY (`idDepartamento`, `idProfessor_Coordenador`),
  INDEX `fk_Departamento_Professor1_idx` (`idProfessor_Coordenador` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_Professor1`
    FOREIGN KEY (`idProfessor_Coordenador`)
    REFERENCES `mydb`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Professor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Professor` (
  `idProfessor` INT NOT NULL AUTO_INCREMENT,
  `Departamento_idDepartamento` INT NOT NULL,
  `Pessoa_idPessoa` INT NOT NULL,
  `Registro` VARCHAR(9) GENERATED ALWAYS AS (),
  PRIMARY KEY (`idProfessor`, `Departamento_idDepartamento`),
  INDEX `fk_Professor_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  INDEX `fk_Professor_Pessoa1_idx` (`Pessoa_idPessoa` ASC) VISIBLE,
  CONSTRAINT `fk_Professor_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `mydb`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professor_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa`)
    REFERENCES `mydb`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Disciplina` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Disciplina` (
  `idDisciplina` INT NOT NULL AUTO_INCREMENT,
  `Professor_idProfessor` INT NOT NULL,
  `Nome` VARCHAR(120) NOT NULL,
  `Carga_Horaria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDisciplina`, `Professor_idProfessor`),
  INDEX `fk_Disciplina_Professor1_idx` (`Professor_idProfessor` ASC) VISIBLE,
  CONSTRAINT `fk_Disciplina_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `mydb`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Curso` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Curso` (
  `idCurso` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(120) NOT NULL,
  `Semestres` INT NOT NULL,
  `Departamento_idDepartamento` INT NOT NULL,
  PRIMARY KEY (`idCurso`, `Departamento_idDepartamento`),
  INDEX `fk_Curso_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Curso_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `mydb`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Matriculado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Matriculado` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Matriculado` (
  `Aluno_idAluno` INT NOT NULL,
  `Disciplina_idDisciplina` INT NOT NULL,
  PRIMARY KEY (`Aluno_idAluno`, `Disciplina_idDisciplina`),
  INDEX `fk_Aluno_has_Disciplina_Disciplina1_idx` (`Disciplina_idDisciplina` ASC) VISIBLE,
  INDEX `fk_Aluno_has_Disciplina_Aluno1_idx` (`Aluno_idAluno` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_has_Disciplina_Aluno1`
    FOREIGN KEY (`Aluno_idAluno`)
    REFERENCES `mydb`.`Aluno` (`idAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluno_has_Disciplina_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `mydb`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pre_Requisito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pre_Requisito` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pre_Requisito` (
  `idPreRequisito` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idPreRequisito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Grade Curricular`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Grade Curricular` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Grade Curricular` (
  `Disciplina_idDisciplina` INT NOT NULL,
  `Curso_idCurso` INT NOT NULL,
  PRIMARY KEY (`Disciplina_idDisciplina`, `Curso_idCurso`),
  INDEX `fk_Disciplina_has_Curso_Curso1_idx` (`Curso_idCurso` ASC) VISIBLE,
  INDEX `fk_Disciplina_has_Curso_Disciplina1_idx` (`Disciplina_idDisciplina` ASC) VISIBLE,
  CONSTRAINT `fk_Disciplina_has_Curso_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `mydb`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Disciplina_has_Curso_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `mydb`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pre_Requisito das Disciplinas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pre_Requisito das Disciplinas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pre_Requisito das Disciplinas` (
  `Disciplina_idDisciplina` INT NOT NULL,
  `Pre_Requisito_idPreRequisito` INT NOT NULL,
  PRIMARY KEY (`Disciplina_idDisciplina`, `Pre_Requisito_idPreRequisito`),
  INDEX `fk_Disciplina_has_Pre_Requisito_Pre_Requisito1_idx` (`Pre_Requisito_idPreRequisito` ASC) VISIBLE,
  INDEX `fk_Disciplina_has_Pre_Requisito_Disciplina1_idx` (`Disciplina_idDisciplina` ASC) VISIBLE,
  CONSTRAINT `fk_Disciplina_has_Pre_Requisito_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `mydb`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Disciplina_has_Pre_Requisito_Pre_Requisito1`
    FOREIGN KEY (`Pre_Requisito_idPreRequisito`)
    REFERENCES `mydb`.`Pre_Requisito` (`idPreRequisito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Periodo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Periodo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Periodo` (
  `idPeriodo` INT NOT NULL,
  `Ano` INT NOT NULL,
  `Semestre` INT NOT NULL,
  PRIMARY KEY (`idPeriodo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Oferta Disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Oferta Disciplina` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Oferta Disciplina` (
  `Periodo_idPeriodo` INT NOT NULL,
  `Disciplina_idDisciplina` INT NOT NULL,
  `Disciplina_Professor_idProfessor` INT NOT NULL,
  PRIMARY KEY (`Periodo_idPeriodo`, `Disciplina_idDisciplina`, `Disciplina_Professor_idProfessor`),
  INDEX `fk_Periodo_has_Disciplina_Disciplina1_idx` (`Disciplina_idDisciplina` ASC, `Disciplina_Professor_idProfessor` ASC) VISIBLE,
  INDEX `fk_Periodo_has_Disciplina_Periodo1_idx` (`Periodo_idPeriodo` ASC) VISIBLE,
  CONSTRAINT `fk_Periodo_has_Disciplina_Periodo1`
    FOREIGN KEY (`Periodo_idPeriodo`)
    REFERENCES `mydb`.`Periodo` (`idPeriodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Periodo_has_Disciplina_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina` , `Disciplina_Professor_idProfessor`)
    REFERENCES `mydb`.`Disciplina` (`idDisciplina` , `Professor_idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aluno_Matriculado_Curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Aluno_Matriculado_Curso` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Aluno_Matriculado_Curso` (
  `Aluno_idAluno` INT NOT NULL,
  `Curso_idCurso` INT NOT NULL,
  PRIMARY KEY (`Aluno_idAluno`, `Curso_idCurso`),
  INDEX `fk_Aluno_has_Curso_Curso1_idx` (`Curso_idCurso` ASC) VISIBLE,
  INDEX `fk_Aluno_has_Curso_Aluno1_idx` (`Aluno_idAluno` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_has_Curso_Aluno1`
    FOREIGN KEY (`Aluno_idAluno`)
    REFERENCES `mydb`.`Aluno` (`idAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluno_has_Curso_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `mydb`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Extensao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Extensao` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Extensao` (
  `idExtensao` INT NOT NULL,
  `Nome` VARCHAR(120) NOT NULL,
  `Area` VARCHAR(120) NOT NULL,
  `Instituicao` VARCHAR(120) NOT NULL,
  `Carga_Horaria` INT NOT NULL,
  PRIMARY KEY (`idExtensao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Extensao_has_Aluno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Extensao_has_Aluno` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Extensao_has_Aluno` (
  `Extensao_idExtensao` INT NOT NULL,
  `Aluno_idAluno` INT NOT NULL,
  PRIMARY KEY (`Extensao_idExtensao`, `Aluno_idAluno`),
  INDEX `fk_Extensao_has_Aluno_Aluno1_idx` (`Aluno_idAluno` ASC) VISIBLE,
  INDEX `fk_Extensao_has_Aluno_Extensao1_idx` (`Extensao_idExtensao` ASC) VISIBLE,
  CONSTRAINT `fk_Extensao_has_Aluno_Extensao1`
    FOREIGN KEY (`Extensao_idExtensao`)
    REFERENCES `mydb`.`Extensao` (`idExtensao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Extensao_has_Aluno_Aluno1`
    FOREIGN KEY (`Aluno_idAluno`)
    REFERENCES `mydb`.`Aluno` (`idAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
