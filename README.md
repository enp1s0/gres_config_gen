# SLURM GRES config generator
This program generates SLURM GRES config.

## Requirements
- NVIDIA Driver (nvidia-smi)

## Usage
```
Usage:
gres_conf_gen [-n|--name DeviceName [Default:gpu]] [-h|--header HeaderFileName [Default:none]]
```

## Output file
```
# Contents of [HeaderFileName]

Name=[DeviceName] File=/dev/nvidia0 CPUs=0-A
Name=[DeviceName] File=/dev/nvidia1 CPUs=A-B
...
Name=[DeviceName] File=/dev/nvidiaX CPUs=Q-P
```
