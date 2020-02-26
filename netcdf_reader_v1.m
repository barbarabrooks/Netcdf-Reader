function data = netcdf_reader_v1(fn)

%Input: fn: fullpath to file of interest
%for example
%fn = 'D:\uol-fssp100-2_oden_20180804_aerosol-size-distribution_v1.nc';

%Output: a structure containing
%   header: the gloabal attributes
%   all the variables in the file

%The vriables are structures in themselves made up of 
%   data: the variables values
%   all the attributes associated with that variable.

%usage:
%data = netcdf_reader_v1('D:\uol-fssp100-2_oden_20180804_aerosol-size-distribution_v1.nc')

%written by
%Barbara Brooks: Dec 2019

%open nc file in read only mode
ncid = netcdf.open(fn,'NC_NOWRITE');

%retrun info about file
%number of dimentions: numdim
%number of variables: numvars
%number of global attributes: numglobatts
%ID of dimension defined with unlimited length if present: unlimdimID
[numdims, numvars, numglobatts, unlimdimID] = netcdf.inq(ncid);

%read in global attrigutes
data.header = [];
for n=1:numglobatts-1
    ga_name = netcdf.inqAttName(ncid, netcdf.getConstant('NC_GLOBAL'),n);
    ga_val = netcdf.getAtt(ncid, netcdf.getConstant('NC_GLOBAL'),ga_name);
    data.header = setfield(data.header,ga_name,ga_val);
end
%read in data and attributes
for n=0:numvars-1
    [va_name, ~, va_dimID, VarAtts] = netcdf.inqVar(ncid,n);
    va_data = netcdf.getVar(ncid, n);
    data.(va_name).data = va_data;     
    va_ID = netcdf.inqVarID(ncid, va_name);
    %add dimensions attribute
    for m = 1: length(va_dimID)      
        data.(va_name).('dimensions'){m}= netcdf.inqDim(ncid, va_dimID(m));
    end
    %add variable attributes
    for m=0:VarAtts-1
        att_name = netcdf.inqAttName(ncid, va_ID, m);
        att_val = netcdf.getAtt(ncid,va_ID, att_name);
        if (strcmpi(att_name, '_FillValue')) == 1
            att_name = 'FillValue';
        end 
        data.(va_name).(att_name)= att_val;
    end
end

%close nc file
netcdf.close(ncid)
