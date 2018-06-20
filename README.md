# sigmajs

[![Travis-CI Build Status](https://travis-ci.org/JohnCoene/sigmajs.svg?branch=master)](https://travis-ci.org/JohnCoene/sigmajs) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JohnCoene/sigmajs?branch=master&svg=true)](https://ci.appveyor.com/project/JohnCoene/sigmajs) [![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable) [![bitbucket](https://img.shields.io/bitbucket/pipelines/JohnCoene/sigmajs.svg)](https://bitbucket.org/JohnCoene/sigmajs) [![CRAN status](https://www.r-pkg.org/badges/version/sigmajs)](https://cran.r-project.org/package=sigmajs) 
[![CircleCI](https://img.shields.io/circleci/project/github/JohnCoene/sigmajs.svg)](https://github.com/JohnCoene/sigmajs)

![sigmajs](/man/figures/logo.png)


[sigmajs](http://sigmajs.org/) for R.

With the rise in popularity of networks, it is important for R users to have access to a package that allows visualising the aforementioned networks in a highly configurable, interactive and dynamic manner.
`sigmajs` is [Shiny](https://shiny.rstudio.com/)-centric in order to best leverage the [original library](http://sigmajs.org/)'s great many methods.

All graphs must be initialised with the `sigmajs()` function, all the functions of the :package: start with `sg_` and its proxies end in `_p`, functions are pipe-friendly (`%>%`). All [events](https://github.com/jacomyal/sigma.js/wiki/Events-API) can be captured in Shiny.

*Note that the graphs may not work in RStudio viewer, open them in your browser of choice*

# Install

```r
# install.packages("devtools")
devtools::install_github("JohnCoene/sigmajs") # github
devtools::install_bitbucket("sigmajs", "JohnCoene") # bitbucket
```

# Examples

Most functions have corresponding `demo()`, see [documentation](http://sigmajs.john-coene.com/) and [shiny demo](http://shiny.john-coene.com/sigmajs/)

```r
library(sigmajs)

# generate data
nodes <- sg_make_nodes()
edges <- sg_make_edges(nodes)

# visualise
sigmajs() %>%
	sg_nodes(nodes, id, label, size, color) %>%
	sg_edges(edges, id, source, target)

# from igraph 
data("lesmis_igraph")
 
layout <- igraph::layout_with_fr(lesmis_igraph)

sigmajs() %>%
	sg_from_igraph(lesmis_igraph, layout)

# from GEXF
gexf <- system.file("examples/arctic.gexf", package = "sigmajs")

sigmajs() %>% 
	sg_from_gexf(gexf) 

# proxies demos
demo(package = "sigmajs")
```
![](pkgdown/delay.gif)
