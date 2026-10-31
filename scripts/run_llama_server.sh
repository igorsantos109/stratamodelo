#!/usr/bin/env bash
# Antes: llama-server --help | grep -i spec   (as flags mudam entre compilacoes)
# Se o GGUF nao tiver cabecas MTP, remova a linha --spec-type.
# Ganhos de velocidade/contexto: medir com llama-bench (metrica tg).
exec llama-server -m modelo-mtp.gguf -ngl 99 -c 32768 -np 1 -fa on \
  -ctk q8_0 -ctv q8_0 \
  --spec-type draft-mtp --spec-draft-n-max 2 \
  --cache-reuse 256 --cache-ram 0
