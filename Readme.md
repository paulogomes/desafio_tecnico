## Desafio Técnico


## Fontes de dados

* Usuários: https://fakestoreapi.com/users
* Carrinhos: https://fakestoreapi.com/carts
* Produtos: https://fakestoreapi.com/products (Precisei usar para pegar os dados de price e category)

## Tecnologias utilizadas

* Pentaho Data Integration 9.4
* SQLite

## Entregáveis

### Pipeline em funcionamento.

- Ver no video.

### Principais decisões técnicas de modelagem, transformação e agregação.

- Utilizei o SQLite para facilitar a entrega
- Fiz uma transformação para a criação das tabelas para manter a simplicidade. Em produção custumo criar uma pasta Schema com as alterações na estrutura do banco para poder versionando as alterações.
- Utilizei o step "Insert / update" para não ter duplicação de registros nas reexecuções
- Como o banco SQLite não permite mais de uma escrita no banco ao mesmo tempo, usei o step "Block this step until steps finish" para contornar isso

### Como executar o pipeline e gerar os dados para dashboard.

- Git Clone:
```console
git clone https://github.com/paulogomes/desafio_tecnico.git
```

- Pelo kettle:
    Abrindo o arquivo "Job_fakestoreapi.kjb" e usando a opção "Run"

- Pela linha de comando:

```console
C:\path\to\PDI\kitchen.bat /file:C:\path\projeto\Job_fakestoreapi.kjb /level:Basic
```

- Depois de executado o Job, será gerado o banco de dados na mesma pasta do projeto com o nome "db.sqlite"