Analyses
========


# `tSNE_analysis.m` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis)

This repository includes a set of scripts to perform a dimensionality reduction analysis using the *tSNE* method.

> [Visualizing High-Dimensional Data Using t-SNE](http://lvdmaaten.github.io/tsne/). *Journal of Machine Learning Research* (2008).

The script depends on the [MATLAB implementation](http://lvdmaaten.github.io/tsne/) of the tSNE (edit it to point to the full/relative path to the tSNE folder).

`tSNE_analysis.m` takes as an input an *Excel* or *csv* file with the next format:

- First column: the name of the class (cell-type, treatment, stage, etc)
- Second column: the name of the sample
- First row: a header with the name of the genes at each column. Notice that the first two cells of the header corresponds to the sample's class and samples's name
