#! /usr/bin/env python
from astropy.io import fits
import numpy as np
from argparse import ArgumentParser

def combine(files,band,outname):
    f = [fits.open(file) for file in files]
    data = np.array([chan[0].data for chan in f])
    shape = data[0].shape
    data = data.reshape(shape[0],-1,shape[2],shape[3])

    header = f[0][0].header
    header['CRPIX3'] = 1
    header['CRVAL3'] = band[0]
    header['CDELT3'] = band[1]
    header['NAXIS3'] = data.shape[2]
    header['history'] = f'Combined {files} using continuum_combine.py (https://github.com/affanadly)'
    
    fits.writeto(outname,data,header,overwrite=True)

def __main__():
    ps = ArgumentParser(description='Combines continuum images into a pseudo-spectral image. (https://github.com/affanadly)')
    ps.add_argument('-f','--files', type=str, nargs='+', help='list of continuum images to combine.')
    ps.add_argument('-b','--band', type=float, nargs=2, help='frequency bands (Hz) for the pseudo-spectral image. Two arguments required; the first band of the first file, and the bandwidth.')
    ps.add_argument('-o', '--outname', type=str, default='output.fits', help='output file name. This OVERWRITES existing image of the same name.')	

    args = ps.parse_args()

    combine(
        args.files,
        args.band,
        args.outname
    )

if __name__ == '__main__':
	__main__()