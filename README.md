
# Museu de Música — Preservação e Digitalização do Acervo

**Projeto Integrador II — Fatec Itu**  
**Curso:** Análise e Desenvolvimento de Sistemas

## Sobre o Projeto

O projeto consiste no desenvolvimento de um sistema de gerenciamento de acervo para um museu de música, com foco na preservação, organização e digitalização de materiais históricos e culturais relacionados à música.

A proposta é facilitar o cadastro, a catalogação e o acompanhamento dos itens pertencentes ao acervo, contribuindo para sua conservação e disponibilização em formato digital.

O sistema contempla diferentes tipos de materiais, como instrumentos musicais, documentos históricos e partituras, além do armazenamento de mídias digitais e da organização dos itens em coleções.

## Objetivos

- Organizar e catalogar os itens do acervo musical.
- Registrar informações sobre a origem e o estado de conservação dos materiais.
- Acompanhar o status de preservação e digitalização dos itens.
- Armazenar referências de arquivos digitais associados ao acervo.
- Organizar os materiais em coleções temáticas.
- Facilitar o gerenciamento e a consulta das informações.

## Tecnologias Utilizadas

- **MySQL:** sistema gerenciador do banco de dados relacional.
- **AlwaysData:** hospedagem do banco de dados.
- **phpMyAdmin:** administração e gerenciamento do banco.
- **SQL:** linguagem utilizada para criação e manipulação dos dados.
- **GitHub:** versionamento e armazenamento dos arquivos do projeto.

## Estrutura do Banco de Dados

O banco de dados foi desenvolvido em MySQL e utiliza tabelas relacionadas por meio de chaves primárias e estrangeiras.

### Tabelas

| Tabela | Descrição |
|---|---|
| `ITEM_ACERVO` | Armazena os dados gerais dos itens do museu. |
| `CATEGORIA` | Classifica os itens do acervo. |
| `USUARIO` | Armazena os usuários responsáveis pelos cadastros. |
| `DOCUMENTO` | Registra informações específicas dos documentos históricos. |
| `INSTRUMENTO` | Armazena informações dos instrumentos musicais. |
| `MUSICA` | Registra informações das composições musicais. |
| `PARTITURA` | Armazena informações das partituras associadas às músicas. |
| `MIDIA` | Registra arquivos digitais relacionados aos itens. |
| `COLECAO` | Armazena as coleções temáticas do museu. |
| `COLECAO_ITEM` | Relaciona os itens do acervo às coleções. |

### Controle de Preservação e Digitalização

A tabela `ITEM_ACERVO` possui o atributo `status`, utilizado para acompanhar as etapas dos materiais:

- Cadastrado
- Em conservação
- Em digitalização
- Digitalizado
- Indisponível

## Relacionamentos e Integridade

O banco de dados utiliza:

- Chaves primárias (PK) para identificação única dos registros.
- Chaves estrangeiras (FK) para estabelecer relacionamentos entre as tabelas.
- Restrições `NOT NULL` para campos obrigatórios.
- Restrições `UNIQUE` para evitar duplicidade em determinados campos.
- Restrição `CHECK` para controlar os valores permitidos no status dos itens.
- `AUTO_INCREMENT` para geração automática de identificadores.

As tabelas `DOCUMENTO`, `INSTRUMENTO` e `PARTITURA` complementam as informações gerais dos itens do acervo.

## Organização do Repositório

```text
Projeto-Integrador-II/
│
├── sql/
│   └── museu_musica.sql
│
└── README.md
```

## Como Executar o Banco de Dados

1. Instale ou tenha acesso a um servidor MySQL.
2. Abra o MySQL Workbench ou phpMyAdmin.
3. Abra o arquivo `sql/museu_musica.sql`.
4. Execute o script SQL integralmente.
5. Verifique a criação das tabelas e a inserção dos dados de teste.

O script contém os comandos de criação da estrutura do banco, definição dos relacionamentos e inserção de registros para testes.

**Observação:** em ambientes hospedados, como o AlwaysData, o nome do banco deve ser ajustado conforme o banco criado na plataforma.


## Informações Acadêmicas

**Instituição:** Faculdade de Tecnologia de Itu — Fatec Itu  
**Curso:** Análise e Desenvolvimento de Sistemas  
**Disciplina:** Projeto Integrador II  
**Projeto:** Museu de Música — Preservação e Digitalização do Acervo
