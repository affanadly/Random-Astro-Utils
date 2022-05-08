#! /usr/bin/env python

from astropy.io import fits
import numpy as np
from argparse import ArgumentParser
    
def __main__():
    ps = ArgumentParser(description='Performs weighting on continuum images based on sensitivity map, analogous to sampling distributions in MCMC. (https://github.com/affanadly)')
    ps.add_argument('image', help='image to clip')
    ps.add_argument('clip_image', help='sensitivity map to clip by')
    ps.add_argument('-o', '--outname', type=str, default='output.fits', help='output file name. This OVERWRITES existing image of the same name.')	

    args = ps.parse_args()

    o = fits.open(args.image)
    c = fits.open(args.clip_image)
    
    o[0].data /= c[0].data
    
    o[0].header['history'] = f'Weight-clipped using weighted_clip.py with {args.clip_image} sensitivity map (https://github.com/affanadly)'
    
    fits.writeto(args.outname,o[0].data,o[0].header,overwrite=True)


if __name__ == '__main__':
    __main__()
