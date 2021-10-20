"""
    prepare the dataset
"""

import numpy as np
import config
import torch.nn as nn
from torch.utils.data import Dataset, DataLoader


class NumDataset(Dataset):
    def __init__(self):
        self.data = np.random.randint(0, 10000, size=[500000])

    def __getitem__(self, index):
        return list(str(self.data[index]))

    def __len__(self):
        return self.data.shape[0]


train_data_loader = DataLoader(NumDataset(), batch_size=config.train_batch_size, shuffle=True)


if __name__ == '__main__':
    # num_dataset = NumDataset()
    # print(num_dataset.data[:10])
    # print(num_dataset[0])
    # print(len(num_dataset))

    for i in train_data_loader:
        print(i)
        break




