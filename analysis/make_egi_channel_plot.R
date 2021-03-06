make_egi_channel_plot <- function(data_path, figs_path){
  # Directories
  figs_path <- 'figs/'
  data_path <- 'data/'
  
  # File names
  egi_fn <- "egi.csv"
  topo_fn <- "topoplot.png"
  
  # Full paths
  egi_path <- paste(data_path, egi_fn, sep="")
  topoplot_fullpath <- paste(figs_path, topo_fn, sep="")
  
  # Libraries
  library(ggplot2)
  library(dplyr)
  library(png)
  library(gridExtra)
  
  # Load EGI position data
  df_egi <- read.csv(egi_path)
  
  # Load topo ears & nose from file
  img <- readPNG(paste(figs_path, "topoplot.png", sep="/"))
  
  # Add a raster
  topo_ears_nose <- rasterGrob(img, interpolate=TRUE)
  
  pl_egi <- ggplot(data=df_egi, aes(x=xpos, y=ypos, label=chan)) +
    geom_text(size=4) +
    coord_fixed() + # 1:1 aspect ratio
    scale_y_continuous("", breaks=NULL) + # omit y axis
    scale_x_continuous("", breaks=NULL) + # omit x axis
    theme( panel.background = element_rect(fill=NA),
           legend.position = "none") + # blank background and no legend
    annotation_custom(topo_ears_nose, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)
  pl_egi
}
