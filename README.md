Feature Selection and Extraction (FSE)
======================================

This repository includes different analyses to explore high dimensional data using different Machine Learning approaches:

- [PCA and tSNE](#tsne_analysis-octocat)
- [Decision trees](#tsne_analysis-octocat)

All the analyses have the same input: an *Excel* or *csv* file with observations at rows and variables at columns. For instances, in single-cell expression data, each row would be the expression profile of a single experiment. The table must include a header with the names of the variables (the genes names). In addition, the first and second columns must correspond to an unique observation ID and their known class (see next example).

|  NAMES  |  CLASSES | gene001 | gene002 | gene003 | gene004 | gene005 | gene006 |
|:-------:|:--------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|
| cell01  |  class01 |   1.03  |   2.39  |  -2.36  |   1.02  |   4.21  |  -0.56  |
| cell02  |  class01 |   2.65  |  -1.78  |  -3.01  |   2.37  |   2.23  |   1.90  |
| cell03  |  class02 |   0.54  |   2.66  |   5.12  |  -2.45  |   3.56  |   4.32  |
| cell04  |  class02 |  -5.02  |  -3.56  |   0.23  |   0.12  |   1.52  |   2.35  |


# `tSNE_analysis` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis)

This repository includes a set of scripts to perform a dimensionality reduction analysis using the *t-Distributed Stochastic Neighbor Embedding* (tSNE) method.

> [Visualizing High-Dimensional Data Using t-SNE](http://lvdmaaten.github.io/tsne/). *Journal of Machine Learning Research* (2008).

The main script, `tSNE_analysis.m`, depends on the [MATLAB implementation](http://lvdmaaten.github.io/tsne/) of the tSNE method. The original code from the tSNE algorithm can be found in [Simple_tSNE/](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis/Simple_tSNE). Check that the path to it is correctly added at the begining of the main script.

tSNE is an stochastic method that will produce a different result every time. For repeatability, the randomness is controlled by fixing the seed of the random generator. To initialize the tSNE solution, the script first computes the PCA and finds the number of components comprising a given level of variability.

> [Best Practices in Exploratory Factor Analysis](http://pareonline.net/pdf/v10n7.pdf). *Practical Assessment, Research & Evaluation* (2005).

`tSNE_analysis.m` will outputs a set of 2D and 3D plots with the PCA and the tSNE results. For convenience, PCA and tSNE results are rotated using the varimax transformation. The 2D figure also includes a classification using the Quadratic Discriminant Analysis (QDA).

![2D and 3D tSNE plots](https://github.com/mscastillo/Analyses/blob/master/tSNE_analysis/tSNE.jpeg)

Finally, the script it will output a set of *csv* files with the PCA, the 2D-tSNE and the 3D-tSNE coordinates.


# `BDT_analysis` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis)

This repository performs a emsembled classificator using a *Bagger Decision Tree* (BDT).
