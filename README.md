# MM_PersistentHomology

This project is for our paper: A Multi-parameter Persistence Framework for Mathematical Morphology (https://arxiv.org/abs/2103.13013).  

# Settings

## Step 0. Check the backgrond environment
Windows 10, Matlab 2019

## Step 1. Download Perseus
Please download perseusWin.exe and put it under the folder ``Perseus`` for computing the persistent homology.  
Website: http://people.maths.ox.ac.uk/nanda/perseus/

# How to use the codes?

## To remove salts and peppers in binary images
Please execute the function ``Do_Morphology`` (an m file) to remove the salts and peppers in binary images. See ``demo.m`` for a demostratoion.

## To generate the 100 iterations
Please execute the Matlab m file named by ``Test_100_Iterations``. Because of the copyright issue, in this project, we only generate the result for the Matlab function ``denoiseImage`` and ours. If you want to test other algorithms, please download the corresponding Matlab m files and put them into the root folder of the project.

## Related denoising algorithms

The following Matlab codes are also compared in this paper.

AMF:  https://www.mathworks.com/matlabcentral/fileexchange/30068-adaptive-median-filter-matlab-code  
NAMF: https://github.com/ProfHubert/NAMF  
