#!/bin/bash -l

#SBATCH --job-name=lammps_run
#SBATCH --time=01:00:00
#SBATCH --partition=shared
#SBATCH --nodes=1
# number of tasks (processes) per node
#SBATCH --ntasks-per-node=1
# number of cpus (threads) per task (process)
#SBATCH --export=OMP_NUM_THREADS=16
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=end
#SBATCH --mail-user=yqian1@villanova.edu


# Determine the equilibrium lattice constant of the potential.
mpirun   --bind-to none -x OMP_NUM_THREADS=16  lmp  -in  equilibrium_lattice_constant.in -log equilibrium_lattice_constant.log \
        -var potfile "$potfile" \
        -var pair_style "$pair_style" \
        -var initial_lattice_constant "$initial_lattice_constant"

# Extract lattice constant from LAMMPS log file.
lattice_constant=`awk '$1>0 && $2==128 && $10>2 { print $10 }' equilibrium_lattice_constant.log`
echo "***** Equilibrium lattice constant: ${lattice_constant} ***** " 

echo "********************************************************"






