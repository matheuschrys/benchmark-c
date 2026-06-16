#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/src"
RESULTS_DIR="$ROOT_DIR/results"

mkdir -p "$RESULTS_DIR"

gcc -O0 "$SRC_DIR/benchmark_ram.c" -o "$ROOT_DIR/benchmark_ram"
gcc -O0 "$SRC_DIR/benchmark_register.c" -o "$ROOT_DIR/benchmark_register"

RAM_RESULTS="$RESULTS_DIR/linux_benchmark_ram.txt"
REGISTER_RESULTS="$RESULTS_DIR/linux_benchmark_register.txt"

: > "$RAM_RESULTS"
: > "$REGISTER_RESULTS"

echo "Executando benchmark_ram 10 vezes..."
for i in $(seq 1 10); do
    echo "Execucao $i" >> "$RAM_RESULTS"
    "$ROOT_DIR/benchmark_ram" >> "$RAM_RESULTS"
    echo >> "$RAM_RESULTS"
done

echo "Executando benchmark_register 10 vezes..."
for i in $(seq 1 10); do
    echo "Execucao $i" >> "$REGISTER_RESULTS"
    "$ROOT_DIR/benchmark_register" >> "$REGISTER_RESULTS"
    echo >> "$REGISTER_RESULTS"
done

echo "Resultados salvos em $RESULTS_DIR"
