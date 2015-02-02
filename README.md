Feature Selection and Extraction (FSE)
======================================

This repository includes different analyses to explore high dimensional data using different Machine Learning approaches:

- [PCA and tSNE](#tsne_analysis-octocat)
- [Decision trees](#tsne_analysis-octocat)

All the analyses takes the same input: a data table with observations at rows and variables at columns. The table must include a header with the names of the variables. In addition, the first and second columns must correspond to an unique sample identifier and their known class. The input table could be provided in two formats: *Excel* and *csv*. Find next some toy examples:

- [data.xls](https://github.com/mscastillo/Analyses/tree/master/Examples/data.xls)
- [data.csv](https://github.com/mscastillo/Analyses/tree/master/Examples/data.csv)


# `tSNE_analysis` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis)

This repository includes a set of scripts to perform a dimensionality reduction analysis using the *t-Distributed Stochastic Neighbor Embedding* (tSNE) method.

> [Visualizing High-Dimensional Data Using t-SNE](http://lvdmaaten.github.io/tsne/). *Journal of Machine Learning Research* (2008).

The main script, `tSNE_analysis.m`, depends on the [MATLAB implementation](http://lvdmaaten.github.io/tsne/) of the tSNE method. The original code from the tSNE algorithm can be found in [Simple_tSNE/](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis/Simple_tSNE). Check that the path to it is added correctly at the begining of the main script.

tSNE is an stochastic method that will produce a different result every time. For repeatability, the randomness is controlled by fixing the seed of the random generator. To initialize the tSNE solution, the script first computes the PCA and finds the number of components comprising a given level of variability.

> [Best Practices in Exploratory Factor Analysis](http://pareonline.net/pdf/v10n7.pdf). *Practical Assessment, Research & Evaluation* (2005).

`tSNE_analysis.m` will outputs a set of 2D and 3D plots with the PCA and the tSNE results. For convenience, PCA and tSNE results are rotated using the varimax transformation. The 2D figure also includes a classification using the Quadratic Discriminant Analysis (QDA).

![2D and 3D tSNE plots](https://github.com/mscastillo/Analyses/blob/master/tSNE_analysis/tSNE.jpeg)

Finally, the script will output a set of *csv* files with the PCA, the 2D-tSNE and the 3D-tSNE coordinates.


# `BDT_analysis` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis)

This repository performs a emsembled classificator using a *Bagger Decision Tree* (BDT).
