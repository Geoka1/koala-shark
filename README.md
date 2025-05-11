# Shark Characterization

This repository evaluates the proposed [Shark]([https://www.gnu.org/software/parallel/](https://web.cs.umass.edu/publication/docs/2003/UM-CS-2003-009.pdf)) sytem using the [Koala](https://github.com/binpash/benchmarks) benchmarks for the shell. 
Most of the transformations outlined in the original paper has been manually implemented in each of the benchmarks. All transformations (and their size in loc) are outlined as follows:

| Benchmark      | LoC      | Notes                                                                                  |
|----------------|----------|----------------------------------------------------------------------------------------|
| `aurpkg`       | 4        | run loop in parallel, remove `cat`                                                    |
| `bio`          | 8        | identify parallelizable region, export as command, run outer loop in parallel with `while`, remove `cat` |
| `covid-mts`    | 4        | remove `cat`                                                                           |
| `file-enc`     | 4        | par/ize with `&` and `wait`                                                            |
| `log-analysis` | 4        | par/ize with `&` and `wait`                                                            |
| `makeself`     |          |                                                                                        |
| `max-temp`     | 4        | par/ize with `&`, `wait`, use `tee`                                                    |
| `media-conv`   | 4        | par/ize with `&`, `wait`, use `tee`                                                    |
| `nlp`          | 3–5      | par/ize with `&`, `wait`, remove `cat` (~90 loc total)                                 |
| `oneliners`    | 13       | remove `cat`, `&`                                                                      |
| `riker`        | 56       | par/ize with `&` and `wait`                                                            |
| `sklearn`      | 10       | par/ize independent runs                                                               |
| `unix50`       | 36       | remove `cat` per script                                                                |
| `vps-audit`    | 65       | use `{}` `&` and `wait`                                                                |
| `web-index`    | 4        | use `tee` and pipelines to remove `cat`                                               |

## Instructions

The top-level `main.sh` script is a quick script for downloading dependencies and inputs, running, profiling, and verifying a _single Koala benchmark_.

```bash
./main.sh <BENCHMARK_NAME> [OPTIONS] [<args passed to execute.sh>]
```

For more information and context on the benchmarks used, please visit the [Koala](https://github.com/binpash/benchmarks) repository.

## License

The Koala Benchmarks are licensed under the MIT License. See the LICENSE file for more information.
