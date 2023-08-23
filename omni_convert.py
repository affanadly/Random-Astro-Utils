from astropy.table import Table
from astropy import units as u
import sys

# This script converts OMNIweb data from ASCII to FITS format

# USAGE: python omni_convert.py <filename> <mode>
# <filename> is the name of the file to be converted
# <mode> is the file type, either 1 (for 1-min data) or 5 (for 5-min data)

# References:
# 1. https://omniweb.gsfc.nasa.gov/form/dx1.html
# 2. https://spdf.gsfc.nasa.gov/pub/data/omni/
# 3. https://omniweb.gsfc.nasa.gov/html/HROdocum.html

# HRO header formats
hro1 = {
    'col1'  : ['Year',None],
    'col2'  : ['Day',None],
    'col3'  : ['Hour',None],
    'col4'  : ['Minute',None],
    'col5'  : ['IMF_ID',None],
    'col6'  : ['SW_ID',None],
    'col7'  : ['Number_IMF_AVG',None],
    'col8'  : ['Number_Plasma_AVG',None],
    'col9'  : ['Percent_interp',None],
    'col10' : ['Timeshift',u.second],
    'col11' : ['RMS_timeshift',u.second],
    'col12' : ['RMS_Phasefront',u.degree],
    'col13' : ['Time_btwn_obs',u.second],
    'col14' : ['Field_mag_avg',u.nT],
    'col15' : ['Bx_GSE/GSM',u.nT],
    'col16' : ['By_GSE',u.nT],
    'col17' : ['Bz_GSE',u.nT],
    'col18' : ['By_GSM',u.nT],
    'col19' : ['Bz_GSM',u.nT],
    'col20' : ['RMS_SD_B_scalar',u.nT],
    'col21' : ['RMS_SD_field_vector',u.nT],
    'col22' : ['Flow_speed',u.km/u.s],
    'col23' : ['Vx_GSE',u.km/u.s],
    'col24' : ['Vy_GSE',u.km/u.s],
    'col25' : ['Vz_GSE',u.km/u.s],
    'col26' : ['Proton_density',u.cm**-3],
    'col27' : ['Temp',u.K],
    'col28' : ['Flow_pressure',u.nPa],
    'col29' : ['Electric_field',u.mV/u.m],
    'col30' : ['Plasma_beta',None],
    'col31' : ['Alfven_mach_num',None],
    'col32' : ['X_GSE',None],
    'col33' : ['Y_GSE',None],
    'col34' : ['Z_GSE',None],
    'col35' : ['BSN_X_GSE',None],
    'col36' : ['BSN_Y_GSE',None],
    'col37' : ['BSN_Z_GSE',None],
    'col38' : ['AE-index',u.nT],
    'col39' : ['AL-index',u.nT],
    'col40' : ['AU-index',u.nT],
    'col41' : ['SYM/D-index',u.nT],
    'col42' : ['SYM/H-index',u.nT],
    'col43' : ['ASY/D-index',u.nT],
    'col44' : ['ASY/H-index',u.nT],
    'col45' : ['PC_N_index',None],
    'col46' : ['Magnetosonic_mach_num',None],
}

hro5 = {
    'col1'  : ['Year',None],
    'col2'  : ['Day',None],
    'col3'  : ['Hour',None],
    'col4'  : ['Minute',None],
    'col5'  : ['IMF_ID',None],
    'col6'  : ['SW_ID',None],
    'col7'  : ['Number_IMF_AVG',None],
    'col8'  : ['Number_Plasma_AVG',None],
    'col9'  : ['Percent_interp',None],
    'col10' : ['Timeshift',u.second],
    'col11' : ['RMS_timeshift',u.second],
    'col12' : ['RMS_Phasefront',u.degree],
    'col13' : ['Time_btwn_obs',u.second],
    'col14' : ['Field_mag_avg',u.nT],
    'col15' : ['Bx_GSE/GSM',u.nT],
    'col16' : ['By_GSE',u.nT],
    'col17' : ['Bz_GSE',u.nT],
    'col18' : ['By_GSM',u.nT],
    'col19' : ['Bz_GSM',u.nT],
    'col20' : ['RMS_SD_B_scalar',u.nT],
    'col21' : ['RMS_SD_field_vector',u.nT],
    'col22' : ['Flow_speed',u.km/u.s],
    'col23' : ['Vx_GSE',u.km/u.s],
    'col24' : ['Vy_GSE',u.km/u.s],
    'col25' : ['Vz_GSE',u.km/u.s],
    'col26' : ['Proton_density',u.cm**-3],
    'col27' : ['Temp',u.K],
    'col28' : ['Flow_pressure',u.nPa],
    'col29' : ['Electric_field',u.mV/u.m],
    'col30' : ['Plasma_beta',None],
    'col31' : ['Alfven_mach_num',None],
    'col32' : ['X_GSE',None],
    'col33' : ['Y_GSE',None],
    'col34' : ['Z_GSE',None],
    'col35' : ['BSN_X_GSE',None],
    'col36' : ['BSN_Y_GSE',None],
    'col37' : ['BSN_Z_GSE',None],
    'col38' : ['AE-index',u.nT],
    'col39' : ['AL-index',u.nT],
    'col40' : ['AU-index',u.nT],
    'col41' : ['SYM/D-index',u.nT],
    'col42' : ['SYM/H-index',u.nT],
    'col43' : ['ASY/D-index',u.nT],
    'col44' : ['ASY/H-index',u.nT],
    'col45' : ['PC_N_index',None],
    'col46' : ['Magnetosonic_mach_num',None],
    'col47' : ['Proton_flux_>10_MeV',u.cm**-2*u.s**-1*u.sr**-1],
    'col48' : ['Proton_flux_>30_MeV',u.cm**-2*u.s**-1*u.sr**-1],
    'col49' : ['Proton_flux_>60_MeV',u.cm**-2*u.s**-1*u.sr**-1],
}

if __name__ == '__main__':
    filename = sys.argv[1]
    mode = sys.argv[2]
    
    print('Reading file: ' + filename)
    table = Table.read(filename,format='ascii')
    
    if mode == '1':
        for key,value in hro1.items():
            table[key].unit = value[1]
            table.rename_column(key,value[0])
    if mode == '5':
        for key,value in hro5.items():
            table[key].unit = value[1]
            table.rename_column(key,value[0])
    
    table.write(filename.strip('.asc') + '.fits',overwrite=True)
    print('Convert complete: ' + filename.strip('.asc') + '.fits')