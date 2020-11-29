# SLURM GRES config generator
This program generates SLURM GRES config.

## Requirements
- CUDA Toolkit
- GCC >= 4.8

## Build
```bash
git clone https://github.com/enp1s0/gres_config_gen
cd gres_config_gen
make
```

## Usage
```
Usage: gres_conf_gen [-?] [-h FILENAME] [-n NAME] [--header=FILENAME]
            [--name=NAME] [--help] [--usage]
```

## Output file
```
# Contents of [header]

Name=[name] File=/dev/nvidia0 CPUs=0-A
Name=[name] File=/dev/nvidia1 CPUs=A-B
...
Name=[name] File=/dev/nvidiaX CPUs=Q-P
```
