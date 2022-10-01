# Modelando do Zero

## Oficina

Narrativa:

* Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica.


>Identificar os objetos, identificar as entidades importantes do contexto para criar os relacionamentos entre elas.


* Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões periódicas.

>Atributo ou Entidade?
>Revisão e Serviço: São entidates separadas?
>Uma entidade só faz sentido existir se houver um relacionamento.

* Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com a data de entrega.

* A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de refêrencia de mão-de-obra.

>Tipo de serviço e valor são tabelados.

* O valor de cada peça também irá compor a OS.

>Valor da peça e Valor da Mão de Obra iram compor a OS.

OS        | Valor do Peça    | Valor do Mão de Obra
--------- | ---------------- | --------------------
Exemplo 1 | Peça 1           | R$ 10
Exemplo 2 | Peça 2           | R$ 8
Exemplo 3 | Peça 3           | R$ 7
Exemplo 4 | Peça 4           | R$ 60

* O cliente autoriza a execução dos serviços.

* A mesma equipe avalia e executa os serviços

* Os mecânicos possuem código, nome, endereço, e especialidade.

* Cada OS possui: Nº, data de emissão, um valor, status e uma data para a conclusão dos trabalhos.

* Uma OS pode ser composta por vários serviços e um mesmo serviço pode estar contido em mais de uma OS.

* Uma OS pode ter vários tipos de peça e uma peça pode estar presente em mais de uma OS.

>Relacionamento N-M
