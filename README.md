Analyses
========


# `tSNE_analysis.m` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis)

This repository includes a set of scripts to perform a dimensionality reduction analysis using the *tSNE* method.

> [Visualizing High-Dimensional Data Using t-SNE](http://lvdmaaten.github.io/tsne/). *Journal of Machine Learning Research* (2008).

The script depends on the [MATLAB implementation](http://lvdmaaten.github.io/tsne/) of the tSNE (edit it to point to the full/relative path to the tSNE folder).

`tSNE_analysis.m` takes as an input an *Excel* or *csv* file with a header and the first and second columns corresponding to the observations ID and theirs known classes.

| NAMES   | CLASSES | gene001 | gene002 | gene003 | gene004 | gene005 |
|---------|---------|---------|---------|---------|---------|---------|
| cell001 | class01 | 1.03    | 2.39    | -2.36   | 1.02    | -0.56   |
| cell002 | class01 | 2.65    | -1.78   | -3.01   | 2.37    | 1.90    |
| cell003 | class02 | 0.54    | 2.66    | 5.12    | -2.45   | 4.32    |


*tSNE* is an stochastic method that will produce a different result every time. For repeatability of the results, the randomness is controlled by definying the random seed at the beginning.

To initialize the *tSNE* method, the script first computes the PCA and finds the number of components comprising a given level of variability. For convenience, PCA and tSNE are rotated using the varimax transformation.

> [Best Practices in Exploratory Factor Analysis](http://pareonline.net/pdf/v10n7.pdf). *Practical Assessment, Research & Evaluation* (2005).

`tSNE_analysis.m` will outputs a set of 2D and 3D plots with the PCA and the tSNE results. The 2D figure also includes the results of the QDA.

![2D and 3D tSNE plots](https://github.com/mscastillo/Analyses/blob/master/tSNE_analysis/tSNE.jpeg)

Additionally, it will output a set of *csv* files with the PCA, the 2D-tSNE and the 3D-tSNE coordinates.
