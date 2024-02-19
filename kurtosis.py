import numpy as np
from scipy.special import gammainc, gammaincc
from scipy.optimize import newton

'''
Utility functions to perform spectral kurtosis in RFI detection and flagging.

Reference: Nita, G. M., & Gary, D. E. (2010). The generalized spectral kurtosis 
estimator. Monthly Notices of the Royal Astronomical Society: Letters, 406(1), 
L60-L64. doi:10.1111/j.1745-3933.2010.00882.x
'''

def gamma_ratio(x, n): 
    '''calculates gamma(x)/gamma(x+n)'''
    return 1/(np.product(x + np.arange(0, n)))

def gsk_moment(M, N, d):
    '''calculates the first four moments of the GSK estimator'''
    M, N, d = np.double(M), np.double(N), np.double(d)
    mu1 = 1
    mu2 = 2*N*d*(N*d + 1)*M**2 / (M - 1) * gamma_ratio(M*N*d + 2, 2)
    mu3 = 8*N*d*(N*d + 1)*M**3 / (M - 1)**2 * gamma_ratio(M*N*d + 2, 4) \
          * ((N*d + 4)*M*N*d - 5*N*d - 2)
    mu4 = 12*N*d*(N*d + 1)*M**4 / (M - 1)**3 * gamma_ratio(M*N*d + 2, 6) \
          * (M**3*N**4*d**4 + 3*M**2*N**4*d**4 + M**3*N**3*d**3 + 68*M**2*N**3*d**3 \
          - 93*M*N**3*d**3 + 125*M**2*N**2*d**2 - 245*M*N**2*d**2 \
          + 84*N**2*d**2 - 32*M*N*d + 48*N*d + 24)
    return mu1, mu2, mu3, mu4

def type3_params(mu1, mu2, mu3, mu4): 
    '''calculates the parameters of the type III pdf'''
    alpha = mu3 / (2*mu2)
    beta = 4*mu2**3 / mu3**2
    delta = mu1 - 2*mu2**2 / mu3
    return alpha, beta, delta

def type3_CF(xi, alpha, beta, delta):
    '''calculates the cumulative function of the type III pdf'''
    if hasattr(xi, '__iter__'):
        return np.vectorize(type3_CF)(xi, alpha, beta, delta)
    return 0 if (xi - delta)/alpha < 0 else gammainc(beta, (xi - delta)/alpha)

def type3_CCF(xi, alpha, beta, delta):
    '''calculates the complementary cumulative function of the type III pdf'''
    if hasattr(xi, '__iter__'):
        return np.vectorize(type3_CCF)(xi, alpha, beta, delta)
    return 0 if (xi - delta)/alpha < 0 else gammaincc(beta, (xi - delta)/alpha)

def type3_bounds(M, N, d, PFA=0.0013499):
    '''calculates the bounds of the type III pdf'''
    mu1, mu2, mu3, mu4 = gsk_moment(M, N, d)
    alpha, beta, delta = type3_params(mu1, mu2, mu3, mu4)
    lower = newton(lambda xi: type3_CF(xi, alpha, beta, delta) - PFA, x0=1)
    upper = newton(lambda xi: type3_CCF(xi, alpha, beta, delta) - PFA, x0=1)
    return lower, upper

def sk_estimator(S1, S2, M, N=1, d=1):
    '''calculates the GSK estimator'''
    return (M*N*d + 1)/(M - 1) * (M*S2 / S1**2 - 1)

def gsk_rfi_flag(power, PFA=0.0013499, return_all=False):
    '''flags RFI using the SK estimator'''
    S1 = np.sum(power, axis=0)
    S2 = np.sum(power**2, axis=0)
    M = power.shape[0]
    SKE = sk_estimator(S1, S2, power.shape[0])
    
    d = (M - np.median(SKE) + 1) / (M * np.median(SKE))
    SKE = sk_estimator(S1, S2, power.shape[0], d=d)
    
    lower, upper = type3_bounds(M, 1, d, PFA=PFA)
    flag = (SKE < lower) | (SKE > upper)
    if return_all:
        return SKE, S1, S2, M, d, lower, upper, flag
    else:
        return flag