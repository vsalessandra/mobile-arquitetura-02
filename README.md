# Em qual camada foi implementado o mecanismo de cache? Explique por que essa decisão é adequada dentro da arquitetura proposta.

O cache foi implementado na camada de dados, no `ProductLocalDataSource`, e o `Repository` decide quando usar.
Isso é adequado porque mantém IO fora da UI e do ViewModel, respeitando a separação de responsabilidades.

# Por que o ViewModel não deve realizar chamadas HTTP diretamente?

Porque o papel do ViewModel é gerenciar estado de tela, não infraestrutura.
Se ele fizer HTTP direto, fica acoplado à rede e mais difícil de testar e manter.

# O que poderia acontecer se a interface acessasse diretamente o DataSource?

A UI ficaria acoplada ao detalhe técnico dos dados (API/cache).
Isso gera mais manutenção, repetição de lógica de erro e testes mais difíceis.

# Como essa arquitetura facilitaria a substituição da API por um banco de dados local?

A troca fica na camada de dados.
Você cria um novo DataSource local (ex.: SQLite/Drift/Hive) e ajusta o `Repository`, sem precisar mexer na UI.
