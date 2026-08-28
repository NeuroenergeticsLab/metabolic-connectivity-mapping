from dataclasses import dataclass

import numpy as np
import scipy as sp
import joblib
import pandas as pd
from sklearn.linear_model import HuberRegressor
from sklearn.multioutput import MultiOutputRegressor


@dataclass
class Filenames:
    pass


subject = 31
filenames = joblib.load("/RAID1/jupytertmp/mcm/data/filenames.joblib")
participants = pd.read_csv("/RAID1/jupytertmp/mcm/data/participants.csv")
pet_params = joblib.load(filenames.pet_params.format(sid=subject))

frame_duration = pet_params["frame_duration"]
idcs = np.cumsum(frame_duration) > 10

weights = frame_duration[idcs]
patlak_x = pet_params["patlak_x"][idcs, np.newaxis]
patlak_y = pet_params["patlak_y"][idcs, :]

multihuber = MultiOutputRegressor(HuberRegressor()).fit(
    patlak_x, patlak_y, sample_weight=weights
)
joblib.dump(
    multihuber, f"/RAID1/jupytertmp/mcm/data/sub-{subject:03}/quant/multihuber.joblib"
)
