# HOD_Pipeline

Scripts and files for HOD fitting to a particular AbacusSummit box.

Updating the cosmology and phase at the top of create_new_HOD_fit.sh then running the script will generate the cosmology rescaling factors and then submit a slurm script to perform the HOD fitting. 

The best fit HOD parameters can then be used as inputs with Alex's mock creation script: https://github.com/amjsmith/shared_code/

Much of this code could be better linked to the mock creation code, to avoid having to define the phase/cosmology in separate places, but this should do for now.
