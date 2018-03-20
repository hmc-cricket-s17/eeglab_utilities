# Import system modules
import sys, string, os

# Python Wrapper for running the amica15
# Shota Yasunaga (shotayasunaga1996@gmail.com)
# 3/18/2018

# This script is for running the binary amica15 from python
# It only works for Mac (created on Sierra 10.12.6)
# You need to have amica15 (executable binary)downloaded
# You also need to have some EEG data to run it on 

#####################################################
# In order to use the script                        #
# 1. BINFILE is the binary amica path. Change the   #
#    path to your local directry                    #
# 2. outdier is the directory (not a file) that you #
#    want the output to be. You can set it to be an #
#    arbitrary path as you want. It creates the     #
#    folder if that doesn't exist.                  #
# 3. files is the path to the eegdata               #
# 4. You should also specify different variables    #
#    that control the behavior of the algorithm     #
#    (I haven't given close look at it too much)    #
#####################################################

#### Your input ####
BINFILE = "/Users/macbookpro/Dropbox/Matlab/Toolboxes/eeglab14_0_0b/plugins/amica1.5/amica15mac"

#output dir
outdir = "/Users/macbookpro/Documents/Beep_Only/DownSample/amicaout/"

# The file name of the data
# TODO: it might be possible to run it for multiple files? 
files = "/Users/macbookpro/Documents/Beep_Only/DownSample/AMICA_64_FASTER_epo10_170613_TRIAL1_LP.fdt"


# other inputs to the file
input_dic = ({
"block_size":128,
"do_opt_block":0,
"blk_min":256,
"blk_step":256,
"blk_max":1024,
"num_models":1,
"max_threads":2,
"use_min_dll":1,
"min_dll":1.000000e-09,
"use_grad_norm":1,
"min_grad_norm":1.000000e-07,
"num_mix_comps":3,
"pdftype":0,
"max_iter":2000,
"num_samples":1,
"data_dim":128,
"field_dim":4800,
"field_blocksize":1,
"do_history":0,
"histstep":10,
"share_comps":0,
"share_start":100,
"comp_thresh":0.990000,
"share_iter":100,
"lrate":0.050000,
"minlrate":1.000000e-08,
"mineig":1.000000e-12,
"lratefact":0.500000,
"rholrate":0.050000,
"rho0":1.500000,
"minrho":1.000000,
"maxrho":2.000000,
"rholratefact":0.500000,
"kurt_start":3,
"num_kurt":5,
"kurt_int":1,
"do_newton":1,
"newt_start":50,
"newt_ramp":10,
"newtrate":1.000000,
"do_reject":0,
"numrej":3,
"rejsig":3.000000,
"rejstart":2,
"rejint":3,
"writestep":20,
"write_nd":0,
"write_LLt":1,
"decwindow":1,
"max_decs":3,
"fix_init":0,
"update_A":1,
"update_c":1,
"update_gm":1,
"update_alpha":1,
"update_mu":1,
"update_beta":1,
"invsigmax":100.000000,
"invsigmin":0.000000,
"do_rho":1,
"load_rej":0,
"load_W":0,
"load_c":0,
"load_gm":0,
"load_alpha":0,
"load_mu":0,
"load_beta":0,
"load_rho":0,
"load_comp_list":0,
"do_mean":1,
"do_sphere":1,
"doPCA":1,
"pcakeep":128,
"pcadb":30.000000,
"byte_size":4,
"doscaling":1,
"scalestep":1,
})

# Create the path to the directory
if not os.path.exists(outdir):
    os.mkdir(outdir)

input_file = outdir + "input.params"
# File writing

# Open the file with the writing mode 
# (to deletes the previous contents)
# or, to create a file if it doesn't exist
f = open(input_file,'w')
files = "files " + files + "\n"
f.write(files)
f.close()

# Open the file with appending mode
f = open(input_file,'a')
outdir = "ourdir "+outdir + "\n"

f.write(outdir)
for key in input_dic:
    write = key + ' ' + str(input_dic[key]) + "\n"
    f.write(write)
f.close()


input_string= BINFILE + ' ' + input_file
os.system(input_string)
