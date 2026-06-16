#!/usr/bin/env python3

import csv
import re
import statistics
from pathlib import Path


ROOT_DIR = Path(__file__).resolve().parent.parent
RESULTS_DIR = ROOT_DIR / "results"
OUTPUT_CSV = RESULTS_DIR / "tabela_final.csv"
TIME_PATTERN = re.compile(r"Tempo decorrido:\s*([0-9]+(?:[.,][0-9]+)?)\s*segundos")


def extrair_tempos(caminho):
    texto = caminho.read_text(encoding="utf-8", errors="ignore")
    tempos = []

    for match in TIME_PATTERN.finditer(texto):
        valor = match.group(1).replace(",", ".")
        tempos.append(float(valor))

    return tempos


def identificar_ambiente(nome_arquivo):
    nome = nome_arquivo.lower()

    if nome.startswith("linux"):
        return "Linux Intel 64 bits"
    if nome.startswith("windows"):
        return "Windows Intel 64 bits"

    return "Nao identificado"


def identificar_programa(nome_arquivo):
    nome = nome_arquivo.lower()

    if "register" in nome:
        return "register long int"
    if "ram" in nome:
        return "long int"

    return "Nao identificado"


def main():
    arquivos = sorted(RESULTS_DIR.glob("*benchmark*.txt"))
    linhas = []

    for arquivo in arquivos:
        tempos = extrair_tempos(arquivo)

        if not tempos:
            continue

        linhas.append(
            {
                "arquivo": arquivo.name,
                "ambiente": identificar_ambiente(arquivo.name),
                "programa": identificar_programa(arquivo.name),
                "execucoes": len(tempos),
                "media_segundos": f"{statistics.mean(tempos):.6f}",
                "desvio_padrao_segundos": f"{statistics.stdev(tempos):.6f}"
                if len(tempos) > 1
                else "0.000000",
            }
        )

    if not linhas:
        raise SystemExit("Nenhum tempo encontrado nos arquivos .txt em results.")

    RESULTS_DIR.mkdir(exist_ok=True)

    with OUTPUT_CSV.open("w", newline="", encoding="utf-8") as csvfile:
        campos = [
            "arquivo",
            "ambiente",
            "programa",
            "execucoes",
            "media_segundos",
            "desvio_padrao_segundos",
        ]
        writer = csv.DictWriter(csvfile, fieldnames=campos)
        writer.writeheader()
        writer.writerows(linhas)

    print(f"Tabela final gerada em: {OUTPUT_CSV}")


if __name__ == "__main__":
    main()
