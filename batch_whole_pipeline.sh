#!/bin/bash -l

#!/bin/bash
#SBATCH -p regular
#SBATCH -o logs/pipeline.out
#SBATCH --time=2880
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --constraint=haswell

# Activate the conda environment which I use
# I believe the most important ones to be included
# are abacusutils, corrfunc, nbodykit
conda activate halo_env

module load gcc
module load gsl

# This next command seems to be necessary on NERSC
module unload craype-hugepages2M


# Get the halo catalogue files
python3 tracer_snapshot.py
python3 tracer_snapshot_unresolved.py

cd FastHodFitting/paircounting/

# Run the halo mass/distance binned paircounting
python3 cencen.py
python3 censat.py
python3 satsat.py
python3 satsat_onehalo.py


# Run the HOD fitting
cd ../fitting_smoothed_curves_nersc/

# Run multiple chains from randomised starting points 

python3 fasthod_fitting.py 1
python3 fasthod_fitting.py 2
python3 fasthod_fitting.py 3
python3 fasthod_fitting.py 4
python3 fasthod_fitting.py 5
python3 fasthod_fitting.py 6
python3 fasthod_fitting.py 7
python3 fasthod_fitting.py 8
python3 fasthod_fitting.py 9
python3 fasthod_fitting.py 10


