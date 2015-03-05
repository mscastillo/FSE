Feature Selection and Extraction (FSE)
======================================

This repository includes different analyses to explore high dimensional data using different Machine Learning approaches:

 * [Principal Component Analysis (PCA)](#pca_analysis-octocat)
 * [t-distributed Stochastic Neighbor Embedding (tSNE)](#tsne_analysis-octocat)
 * [Gaussian Mixture Model (GMM)](#gmm_analysis-octocat)
 * [Decision trees](#tsne_analysis-octocat)

All the analyses takes the same input: a data table with observations at rows and variables at columns. The input table could be provided in any of the next two formats: *[Excel](https://github.com/mscastillo/Analyses/tree/master/Examples/data.xls)* or *[csv](https://github.com/mscastillo/Analyses/tree/master/Examples/data.csv)*. Tables should include a header with the names of the variables. In addition, the first and second columns should have the sample class and a unique sample identifier respectively.


# `PCA_analysis` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/pca_analysis)

This repository includes a MATLAB script to perform a dimensionality reduction analysis using the *Principal Components* method.

> [Principal component analysis for clustering gene expression data](http://bioinformatics.oxfordjournals.org/content/17/9/763.abstract). *Bioinformatics* (2001).

### Input

Data is read from a table in *CSV* or *Excel* file with the format described before.

### Output

The script computes PCA using the singular value decomposition method by using function `pca` from MATLAB's statistichal toolbox. Next are listed the figures and output files:

1. **2D-PCA**. A scatter-plot overlapping the classification resulting from the Quadratic Discriminant Analysis (QDA).
2. ** 3D-PCA**. A scatter-plot with the three first components. Before plotting them, the components are rotate using the *varimax* transformation to find the optimum orientation.
3. A report showing the information content of each componenent (and up to which the 95% of the variance is explained). Data are denoised by substracting the information of the components over the level.
4. A *CSV* filewill be saved in the same folder of the input data, with the same name and prefix *__PCA*, incluiding the PCA coordinates.

At the end of the script, the program ask if you want to identify a subset of data points in the 2D plot. If you click yes, a new windowwill be opened. Yo can click on each single point one by one and drag over the region you are interested in. Once your selection is done, press <kbd>Enter</kbd> to finish and an additional text file with the names of the data-points will be output. It will be savedwith the name of the input file, in the same folder and the prefix *__superclass*.

# `tSNE_analysis` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis)

This repository includes a set of scripts to perform a dimensionality reduction analysis using the *t-Distributed Stochastic Neighbor Embedding* (tSNE) method.

> [Visualizing High-Dimensional Data Using t-SNE](http://lvdmaaten.github.io/tsne/). *Journal of Machine Learning Research* (2008).

The main script, `tSNE_analysis.m`, depends on the [MATLAB implementation](http://lvdmaaten.github.io/tsne/) of the tSNE method. The original code from the tSNE algorithm can be found in [Simple_tSNE/](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis/Simple_tSNE). Check that the path to it is added correctly at the begining of the main script. The method preprocesses the data using PCA and choosing a given number of initial dimensions to compute an initial solution. Instead of choosing an arbitrary number of components, the main script performs PCA and chooses the number of components comprising a given level of variability. By default, this level is set to keep the 95% of the variance. To skip the preprocessing step, set this variable to 100%. 

tSNE is an stochastic method that will produce a different result every time. For repeatability, the randomness is controlled by fixing the seed of the random generator. For convenience, PCA and tSNE results are rotated using the varimax transformation.
 
> [Best Practices in Exploratory Factor Analysis](http://pareonline.net/pdf/v10n7.pdf). *Practical Assessment, Research & Evaluation* (2005).

`tSNE_analysis.m` will outputs a set of 2D and 3D plots with the PCA and the tSNE results. The 2D figure also includes a classification using the Quadratic Discriminant Analysis (QDA).

![2D and 3D tSNE plots](https://github.com/mscastillo/FSE/blob/master/Examples/tSNE.jpg)

Finally, the script will output a set of *[csv](https://github.com/mscastillo/FSE/blob/master/Examples)* files with (*i*) the PCA, (*ii*) the 2D-tSNE and (*iii*) the 3D-tSNE coordinates. Before plooting the 3D analysis, users may interact with the 2D plot to manually pick a subset of samples. After choosing the super-subset (by doing click or draging) an additional *txt* file with the selected samples ID will be generated.


# `BDT_analysis` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/tSNE_analysis)

This repository performs a emsembled classificator using a *Bagger Decision Tree* (BDT).
