Analyses
========

This repository includes different analyses to (*i*) reduce the dimensionality of a dataset and (*ii*) to classify the results.

Most of takes the same kind of input data in the same format:

 1. *Dimensionality reduction analyses* take an *Excel* or *csv* file with a header, with observations at rows and variables at columns. For instances, in expression data, each row is the expression profile of a single cell. The table must have a header with the names of the variables (genes names). In addition, the first and second columns must correspond to the observations ID and theirs known classes (see next exaple). 

 |  NAMES  |  CLASSES | gene001 | gene002 | gene003 | gene004 | gene005 | gene006 |
 |:-------:|:--------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|
 | cell001 |  class01 |   1.03  |   2.39  |  -2.36  |   1.02  |   4.21  |  -0.56  |
 | cell002 |  class01 |   2.65  |  -1.78  |  -3.01  |   2.37  |   2.23  |   1.90  |
 | cell003 |  class02 |   0.54  |   2.66  |   5.12  |  -2.45  |   3.56  |   4.32  |
 | cell004 |  class02 |  -5.02  |  -3.56  |   0.23  |   0.12  |   1.52  |   2.35  |

 2. *Classification analyses* take an *csv* file with a header, with the coordinates of the data at columns. The table must have a header with the names of the variables (name of the coordinate to plot) and the first and second columns must correspond to the observations ID and theirs known classes (see next exaple). 

 |  NAMES  |  CLASSES | PCA01 | PCA02 | PCA03 |
 |:-------:|:--------:|:-----:|:-----:|:-----:|
 | cell001 |  class01 | 1.03  | 2.39  | -2.36 |
 | cell002 |  class01 | 2.65  | -1.78 | -3.01 |
 | cell003 |  class02 | 0.54  | 2.66  | 5.12  |
 | cell004 |  class02 | -5.02 | -3.56 | 0.23  |


# `tSNE_analysis` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis)

This repository includes a set of scripts to perform a dimensionality reduction analysis using the *t-Distributed Stochastic Neighbor Embedding* (tSNE) method.

> [Visualizing High-Dimensional Data Using t-SNE](http://lvdmaaten.github.io/tsne/). *Journal of Machine Learning Research* (2008).

The main script, `tSNE_analysis.m`, depends on the [MATLAB implementation](http://lvdmaaten.github.io/tsne/) of the tSNE method. Edit the parameters on the header to point to the full/relative path of the tSNE folder. The script takes an input *Excel* or *csv* file as described above.

tSNE is an stochastic method that will produce a different result every time. For repeatability, the randomness is controlled by fixing the random seed. To initialize the tSNE solution, the script first computes the PCA and finds the number of components comprising a given level of variability. For convenience, PCA and tSNE results are rotated using the varimax transformation.

> [Best Practices in Exploratory Factor Analysis](http://pareonline.net/pdf/v10n7.pdf). *Practical Assessment, Research & Evaluation* (2005).

`tSNE_analysis.m` will outputs a set of 2D and 3D plots with the PCA and the tSNE results. The 2D figure also includes a classification using a Quadratic Discriminant Analysis (QDA).

![2D and 3D tSNE plots](https://github.com/mscastillo/Analyses/blob/master/tSNE_analysis/tSNE.jpeg)

Additionally, it will output a set of *csv* files with the PCA, the 2D-tSNE and the 3D-tSNE coordinates.
