#!/bin/bash -l


# Choose the phase and cosmology of the box which is to be fit to
cosmo_number=0
phase_number=0

mkdir "halo_fitting_${cosmo_number}_${phase_number}"

cd "halo_fitting_${cosmo_number}_${phase_number}"

mkdir logs

# copy useful functions from Alex's code
cp ../Alex_Functions/*.py ./
cp ../Alex_Functions/*.csv ./
cp ../Alex_Functions/*.dat ./
cp ../Alex_Functions/*.sh ./
cp ../batch_whole_pipeline.sh ./


# Update the cosmo_number & phase_number in the functions 
sed -i "s/cosmo_number=1/cosmo_number=${cosmo_number}/" rescaling_factor.py

sed -i "s/ph = 0/ph = ${phase_number}/" tracer_snapshot.py

sed -i "s/cosmo = 0/cosmo = ${cosmo_number}/" tracer_snapshot.py

sed -i "s/ph = 0/ph = ${phase_number}/" tracer_snapshot_unresolved.py

sed -i "s/cosmo = 0/cosmo = ${cosmo_number}/" tracer_snapshot_unresolved.py


# Activate conda environment containing abacusutils, corrfunc & nbodykit
conda activate halo_env
# Run script to get the rescaling factors for the cosmology
python rescaling_factor.py

# Get code from remote repositories
git clone "https://github.com/cejgrove/FastHodFitting"

git clone "https://github.com/amjsmith/shared_code/"
# copy new rescaling factor files into the relevant repository
cp cosmology_rescaling_factor_xi_zel_8.txt FastHodFitting/fitting_smoothed_curves_nersc/
cp target_num_den_rescaled.txt FastHodFitting/fitting_smoothed_curves_nersc/

# Run the paircounting and HOD fitting within a slurm script
sbatch batch_whole_pipeline.sh
