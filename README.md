# Netcdf-Reader
 Matlab function to import netcdf files


Input: 
fn: fullpath to file of interest
for example
fn = 'D:\uol-fssp100-2_oden_20180804_aerosol-size-distribution_v1.nc';

Output: 
a structure containing
header: the gloabal attributes
all the variables in the file

The vriables are structures in themselves made up of 
data: the variables values
all the attributes associated with that variable.

usage:
data = netcdf_reader_v1('D:\uol-fssp100-2_oden_20180804_aerosol-size-distribution_v1.nc')

Works with MATLAB 2017 and above.