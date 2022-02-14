import numpy as np

path = ""

best_chain = 1
best_val = -100000000


for i in range(1,10):
    file_path = path+"diff_start_low_prior_%d_log_probs.npy"%i
    data = np.load(file_path)
    best_val_temp = np.max(data)
    if best_val_temp > best_val:
        best_chain = i
        best_val = best_val_temp
        
file_path = path+"diff_start_low_prior_%d_best_params_smooth_functions.txt"%best_chain
data = np.genfromtxt(file_path)
np.savetxt(path+"best_HOD_params.txt",data)
