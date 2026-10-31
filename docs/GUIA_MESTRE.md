# Guia Mestre do S.T.R.A.T.A. v2.1

O S.T.R.A.T.A. é uma convenção de trabalho, não um padrão da indústria. Serve como andaime para a IA programadora: quanto maior o risco da tarefa, mais estrutura; a IA pode dispensá-la quando só atrapalha, desde que justifique.

## 1. Conceitos

| Função | Passos antigos | Para que serve | Custo em tokens |
|---|---|---|---|
| Contrato | Specify | Fixar linguagem, invariantes, assinaturas e erros antes do código | Baixo |
| Rastro | Trace | Pensar passos e falhas antes de escrever | Médio (só em L2) |
| Entrega | Actuate, Test | Patch mínimo com testes | Proporcional à tarefa |
| Prova | Audit | Rodar build, testes e linter de verdade | Quase nulo (roda fora do modelo) |

- Route deixou de ser etapa: a ideia de que o texto de planeamento guia os especialistas do MoE nunca foi provada. Ficou só como estilo (vocabulário técnico, sem floreio).
- READY_FOR_BUILD saiu: o status é calculado pelo orquestrador a partir do código de saída dos comandos.

## 2. Onde aplicar

| Situação | Nível | Motivo |
|---|---|---|
| Renomear, ajustar texto, comando de shell | L0 | Estrutura só gastaria tokens |
| Função nova, bug localizado | L1 | Contrato curto basta |
| Concorrência, dinheiro, segurança, API pública, migração | L2 | Custo alto de errar |
| Modelo pequeno ou muito quantizado | Subir um nível | Hipótese: perde precisão mais fácil (medir) |
| Modelo grande/de raciocínio, tarefa simples | Descer um nível | O `<think>` já faz o rastro |
| OCR e digitalização | L1 com testes por amostra | Verificar com páginas de referência |
| Conversa, explicação, brainstorming | Não aplicar | Não é programação agêntica |

### MoE

- Em MoE cada token ativa só parte dos especialistas; a memória, porém, é a do modelo inteiro.
- Não presumir que o S.T.R.A.T.A. estabiliza o roteamento. A medida certa é o resultado: passou nos testes na primeira tentativa?
- Quantização forte pode piorar obediência a formato e precisão em código. Se o modelo erra o bloco final com frequência, considerar subir a quantização antes de endurecer o prompt.

## 3. Procedimento

1. Classificar a tarefa (L0, L1, L2) e anotar o motivo em uma linha.
2. Ler os arquivos que serão tocados. Não inventar API, caminho nem flag.
3. Contrato: L1 com 2 a 4 linhas; L2 completo (stack, invariantes, assinaturas, erros).
4. Rastro (só L2): 3 a 5 passos numerados, incluindo caminhos de falha.
5. Patch mínimo, sem TODO, sem `...`, sem erro engolido, sem pânico não verificado.
6. Testes: caminho normal, vazio e limites. Em L2: estouro, tempo esgotado, cancelamento.
7. Prova: rodar build, testes e linter e citar os comandos.
8. Falha: corrigir a causa-raiz; máximo de 3 tentativas por erro; depois parar e relatar o bloqueio.
9. Registro: atualizar `PLAN.md` (objetivo, feito, próximo passo, riscos) em tarefas de vários passos.
10. Relatório: `[STRATA_REPORT]` do modelo, seguido de `[STRATA_STATUS]` do orquestrador.

Contexto: descartar o `<think>` do histórico ao fim de cada turno. Gramática GBNF somente em chamada separada para o relatório final, nunca no turno principal (o `--grammar-file` condiciona a geração desde o primeiro token).

## 4. Liberdade da IA programadora

Ver `prompts/autonomy_clause.md`. Ordem de prioridade: correção > intenção do usuário > segurança > economia de tokens > conformidade com o protocolo. Se seguir o protocolo prejudicar a correção, a IA segue a correção e registra o desvio.

## 5. Medir e evoluir

1. Montar 10 a 20 tarefas reais, misturando L0, L1 e L2.
2. Rodar cada uma em três modos: sem protocolo, v2.1, v2.1 com cláusula de autonomia.
3. Anotar: passou de primeira (sim/não), número de voltas, tokens gerados, tempo total.
4. Cortar o nível que não melhorar o acerto de primeira.

Nenhum ganho de velocidade é afirmado: medir com `llama-bench` (métrica tg) no modelo e hardware reais.
