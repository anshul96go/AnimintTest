# Interactivity with Legends and other new Features for Animint

Kevin Ferris

## Background

[Animint]([https://github.com/tdhock/animint]) is an R package for making interactive animated data
visualizations on the web, using ggplot syntax and 2 new aesthetics:

- **showSelected=variable** means that only the subset of the data that
  corresponds to the selected value of **variable** will be shown.
- **clickSelects=variable** means that clicking a plot element will
  change the currently selected value of **variable**.

Toby Dylan Hocking initiated the project in 2013, and Susan VanderPlas
(2013) and Carson Sievert (2014) have provided important contributions
during previous GSOC projects.

## Related work

Standard R graphics are based on the pen and paper model, which makes
animations and interactivity difficult to accomplish. Some existing
packages that provide interactivity and/or animation are

- Non-interactive animations can be accomplished with the [animation](http://yihui.name/animation/)
  package (animint provides interactions other than moving
  forward/back in time).
- Some interactions with non-animated linked plots can be done with
  the [qtbase, qtpaint, and cranvas packages](https://github.com/ggobi/cranvas/wiki) (animint provides
  animation and showSelected).
- Linked plots in the web are possible using [SVGAnnotation](http://www.omegahat.org/SVGAnnotation/SVGAnnotationPaper/SVGAnnotationPaper.html) or [gridSVG](http://sjp.co.nz/projects/gridsvg/), but using these to create such a visualization requires knowledge of Javascript (animint designers write only R/ggplot2 code). 
- The [svgmaps](https://r-forge.r-project.org/scm/viewvc.php/pkg/?root=svgmaps) package defines interactivity (hrefs, tooltips) in R code using igeoms, and exports SVG plots using gridSVG, but does not
  support showing/hiding data subsets (animint does). 
- The [ggvis](https://github.com/rstudio/ggvis) package defines a grammar of interactive graphics that is
  limited to a single plot (animint does several linked plots).
- [Vega](https://github.com/trifacta/vega) can be used for describing plots in Javascript, but does not
  implement clickSelects/showSelected (animint does).
- [RIGHT](http://cran.r-project.org/web/packages/RIGHT/) and [DC](http://dc-js.github.io/dc.js/) implement interactive plots for some specific plot types (animint uses the multi-layered grammar of graphics so is not
  limited to pre-defined plot types).

For even more related work see the [Graphics](http://cran.r-project.org/web/views/Graphics.html) and [Web technologies](http://cran.r-project.org/web/views/WebTechnologies.html) task views on CRAN, and [Visualization design resources from the UBC InfoVis Group](http://www.cs.ubc.ca/group/infovis/resources.shtml).

## Project Goals

This project aims to implement several new ways for the user to interact the plot, adding fragment identifiers to the visualization, allow the user to dynamically rescale plots, and provide some minor updates to the documentation.

### Interactivity with Legends

* Currently in Animint, legends are static.  This project will attempt to allow the user to use legends to subset the data that is being plotted.
* Legends could also be extended by reacting to the user's actions.  For example, in [this Highcharts visualization](http://www.highcharts.com/maps/demo/map-drilldown/dark-unica) the legend reacts to wherever the user's mouse is loated.

### Fragment Identifiers

Animations in Animint allow visualizations to be displayed across time.  Adding fragment identifiers allows the user to go directly to a specific point in time.

### Rescaling Plots

Once the visualization has been generated, the user should be able to resize the plots in the web browser.

### Updating Documentation

* Right now, `animint2gist` has an argument called `plot.list`.  The help file says "plot.list	a named list of ggplots and option lists."  The possible options could be specified.
* The Details section in each help file could provide additional explanation of the underlying process implemented by each function.
* Incorporate existing examples into vignettes in package.

## Implementation

* Rescaling Plots: Start by adding buttons for height and width of plot.  If these are successful, then work on allowing user to click and drag to change plot size.
* Updating Documentation: Documentation can be added directly to the files in the `R/` directory.  Vignettes can be made with gifs embedded to allow for demonstration of Animint's animations and interactivity.  Alternatively, they could be made like the [ggvis](https://github.com/rstudio/ggvis) vignettes which note that the R code needs to be run to see the interactivity.

## Timeline

* Familiarize myself with the Animint package.  Specifically, this project will provide improvements to the [renderer](https://github.com/tdhock/animint/wiki/Renderer-details) so I will work on this in detail.  Begin to implement methods to rescale plots (End of April)
* Add new method to subset data through the legend (Middle of May)
* Documentation and testing of new method (Memorial Day)
* Add to Documentation of current functions and familiarize myself with fragment identifiers for Animint (Beginning of June)
* Add fragment identifies to Animint plots (Middle of June)
* Documentation and testing of fragment identifiers (Late June)
* Add methods to link user's hovering to legend (Mid-Late July)
* Documentation and testing of legend hovering (Beginning of August)
* Additional documentation and final touch-ups as needed (End of August)

## About Me

I am currently a grad student in Statistics at Montana State University.  I started working with R and ggplot2 as an undergraduate at Montana State in 2010.  I am developing an [R package](https://github.com/greenwood-stat/catstats) for the intermediate statistics class at Montana State.  Last year I built an R package for the Philadelphia Phillies while working as an intern.

Email: <kevin.ferris10@gmail.com>

GitHub: <https://github.com/kferris10>

