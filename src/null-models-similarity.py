import argparse
from pymcm.array import vectorize_matrix
import numpy as np
from scipy.stats import pearsonr

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('-e', type=str, required=True, help='Path to the empirical matrix (text file)')
    parser.add_argument('-n', type=str, required=True, help='Path to the null model (npz file)')
    parser.add_argument('--directed', action='store_true')
    args = parser.parse_args()

    with np.load(args.e) as f:
        arr = f['arr_0']
        a1_vec = vectorize_matrix(arr, directed=args.directed)
    with np.load(args.n) as f:
        arr = f['arr_0']
        a2_vec = vectorize_matrix(arr, directed=args.directed)

    non0_mask = (a1_vec > 0) & (a2_vec > 0)

    result = pearsonr(a1_vec[non0_mask], a2_vec[non0_mask])
    print(result.statistic)
    