# Benchmark em C: long int vs register long int

Projeto academico para comparar o tempo de execucao de dois programas em C:

- `src/benchmark_ram.c`: usa `long int x, y;`
- `src/benchmark_register.c`: usa `register long int x, y;`

Os dois programas executam dois loops aninhados de `0` ate `60000` e medem o tempo com `clock()` da biblioteca `time.h`.

## Estrutura

```text
benchmark-c/
├── src/
│   ├── benchmark_ram.c
│   └── benchmark_register.c
├── scripts/
│   ├── run_linux.sh
│   ├── run_windows.bat
│   └── calcular_resultados.py
├── results/
└── relatorio/
```

## Compilacao manual

Use `gcc -O0` para evitar otimizacoes automaticas do compilador.

### Linux Intel 64 bits

```bash
gcc -O0 src/benchmark_ram.c -o benchmark_ram
gcc -O0 src/benchmark_register.c -o benchmark_register
```

Para executar manualmente:

```bash
./benchmark_ram
./benchmark_register
```

### Windows Intel 64 bits

No Prompt de Comando, dentro da pasta do projeto:

```bat
gcc -O0 src\benchmark_ram.c -o benchmark_ram.exe
gcc -O0 src\benchmark_register.c -o benchmark_register.exe
```

Para executar manualmente:

```bat
benchmark_ram.exe
benchmark_register.exe
```

## Execucao automatica

Os scripts compilam os programas com `gcc -O0`, executam cada programa 10 vezes e salvam os resultados em `results/`.

### Linux

```bash
chmod +x scripts/run_linux.sh
./scripts/run_linux.sh
```

Arquivos gerados:

- `results/linux_benchmark_ram.txt`
- `results/linux_benchmark_register.txt`

### Windows

No Prompt de Comando:

```bat
scripts\run_windows.bat
```

Arquivos gerados:

- `results\windows_benchmark_ram.txt`
- `results\windows_benchmark_register.txt`

## Calculo dos resultados

Depois de executar os benchmarks no Linux e no Windows, rode:

```bash
python3 scripts/calcular_resultados.py
```

No Windows, se `python3` nao estiver disponivel:

```bat
python scripts\calcular_resultados.py
```

O script le os arquivos `.txt` em `results/`, extrai os tempos, calcula media e desvio padrao e gera:

```text
results/tabela_final.csv
```

## Observacao

Em compiladores modernos, `register` e apenas uma sugestao ao compilador. Mesmo com `-O0`, os resultados podem variar por causa do sistema operacional, processos em segundo plano, temperatura, frequencia da CPU e outras condicoes do ambiente.
