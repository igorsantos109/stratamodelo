# S.T.R.A.T.A. v2.1 (modo agêntico)

Convenção de trabalho para IAs programadoras (coding agents), pensada para modelos locais quantizados (inclusive MoE) em hardware modesto, como a Tesla P40.

Não é padrão da indústria: é uma convenção própria, a ser medida e ajustada.

## Ideia central

- Rigor proporcional ao risco: níveis L0, L1 e L2.
- Patch mínimo em vez de arquivo inteiro.
- Status calculado pelo orquestrador (código de saída de build/testes), nunca declarado pelo modelo.
- Estado em `PLAN.md`; o `<think>` é descartado a cada turno.
- A IA tem liberdade de avaliar e desviar, justificando (ver cláusula de autonomia).

## Conteúdo (a ser enviado a seguir)

- `docs/GUIA_MESTRE.md`: conceitos, onde aplicar, procedimento e avaliação.
- `prompts/system_prompt_v2.1.md`: prompt de sistema canônico.
- `prompts/autonomy_clause.md`: cláusula de autonomia.
- `scripts/strata_verify.sh`: verificação por código de saída (bash).
- `grammar/strata_report.gbnf`: gramática opcional, só para chamada separada do relatório.
- `scripts/run_llama_server.sh`: comando de partida do llama-server.

## Aviso sobre números

Nenhum ganho de velocidade ou de contexto é afirmado aqui. Meça com `llama-bench` no seu modelo e hardware.
