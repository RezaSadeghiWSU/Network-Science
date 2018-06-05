# Author: Reza Sadeghi
# Email: reza@knoesis.org; sadeghi.2@wright.edu
# Description: The basic commands of R for representation of data using igraph library
# Date: 2/01/2018

install.packages("igraph")
library(igraph)
??igraph#provides all information and pakages
?igraph#if you are completly now the name

.libPaths()# The path of libraries in the local machine

rm(list=ls())  # clean all variables
unclass(A) # shows everything in the memory

# vectors in R
x <- c(1,2,3,4,5,6,7,8,9,10)
# return a subset of the vector
x[c(1,3,7)]
# a vector of characters
x <- c("a","b","c")
# return the index of a
which(x=="a")
#logical indexing
x[which(x=="a")]

x=1:10
y=rep(5,10)#repitation for ten times

# Plotting
#pch: the shap of charcters
plot(x=1:10,y=rep(5,10),pch=19,col="red",xlim = c(2,5),ylim = c(4,6),xlab = "derek",ylab = "derek2")

## color palettes _> for continues amount
my_colors <- colorRampPalette(c("blue","red"))
plot(x=1:20,y=1:20,pch=19, col=my_color(20))

# color for discrit RV
install.packages('RColorBrewer')
library(RColorBrewer)
display.brewer.all()
plot(x=1:20,y=1:20,pch=19, col=brewer.pal(20,"Pastel1"))

## network visualization
getwd()
setwd("C:\\Users\\Reza Sadeghi\\Desktop")
nodes <- read.csv("media-nodes.csv",header = T,as.is = T)
edges <- read.csv(file="media-edges.csv",header = T, as.is = T)
nodes[1,1]#the cell
edges$type [1]
edges[1,"type"]

net <- graph_from_data_frame(d=edges, vertices = nodes, directed = T)
net
#DNW - directed network weighted biypartet
# c means as characters attribut
# n means as number
E(net)
V(net)
V(net)$media
V(net)[media=="BBC"]# what node in this net is BBC
E(net)[type=="hyperlink"]#what edges in this network is hyperlink

# plot the network
plot(net)
plot(net,edge.arrow.size=0.4, vertex.label=NA)#using options to plot the graphs
?igraph.plotting#the document of this library
plot(net,edge.arrow.size=0.4, vertex.label=NA, edges.curved=0.3)#the curve optimization
plot(net,edge.arrow.size=0.4, vertex.label=V(net)$media, edges.curved=0.3)#add custom label
# the prefered graph setting
plot(net, edge.arrow.size=.2, edge.color="black", edge.curved=0.3, vertex.color="green", vertex.label=V(net)$media, vertex.label.color="red")

# set edge or vertex parameters to automatically set plot settings
# then automatically the plot use it without setting that
#***************
E(net)$color<-"black"
plot(net)

nede_color <- c("red","green","blue")
E(net)$color <- nede_color[V(net)$media.type]
V(net)$label <- V(net)$media
E(net)$arrow.size <-.2
E(net)$curved <-0.3
plot(net,edge.arrow.size=0.2)

# adding legends
legend(x=-2,y=-1,#position
       c("Newspaper","Television","Online"),
       pch=16,# the shape of legend
       pt.bg=node_colors,
       pt.cex = 3,#size of gloves in r
       ncol=1)
## layouts
net2 <- sample_pa(80)
V(net2)$size <- 7
V(net2)$color <-"red"
V(net2)$label <-""
E(net2)$arrow.mode <-0
plot(net2)

# random layout 
l <- layout.random(net2)
plot(net2)
# same layout
plot(net2,layout=1)
plot(net2, layout=l*2, rescale=F)# zomming

# different layout
# define layout with function layout
# normaliz with norm_coords
l <- layout.circle(net2)
plot(net2, layout=l*1.6, rescale=F)

l <- layout.fruchterman.reingold(net2)# dens connection in the middle
l <- norm_coords(l, ymin = -1, ymax=1, xmin=-1, xmax = 1) 
plot(net2,layout=l,rescale=F)
