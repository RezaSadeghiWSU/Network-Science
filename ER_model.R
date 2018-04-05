# Author: Reza Sadeghi
# Email: reza@knoesis.org; sadeghi.2@wright.edu
# Date: 4/3/2018
# Description: ER-model characterization
library(igraph)
n=100
p=0.3
g=NULL
g <- erdos.renyi.game(n, p, type = "gnp", directed=T, loops = FALSE)
#vertex.label= NA
plot(g, edge.arrow.size=.2, edge.color="black", edge.curved=0.3, vertex.color="green",  xlab = "Random Network: G(N,p) model")

n=20
experiment=100
p=seq(0,1,0.001)
test=rep(0,length(p))
AvgCCS=rep(0,length(p))
AvgLCCS=rep(0,length(p))
for (Np in 1:length(p)){
  cycle=rep(0,experiment)
  AvgCC=rep(0,experiment)
  LCC=rep(0,experiment)
  for (ex in 1:experiment){
    g <- erdos.renyi.game(n, p[Np], type = "gnp", directed=T)
    cycle[ex]<-1-is_dag(g)
    output<-clusters(g)
    AvgCC[ex]<-mean(output$csize)
    LCC[ex]<-max(output$csize)
  }
  test[Np]=sum(cycle)/experiment
  AvgCCS[Np]=mean(AvgCC)
  AvgLCCS[Np]=mean(LCC)
}
plot(test ,xaxt="n",bty="n", xlab = "The probability", ylab = " The proportion of graphs with at least on cycle")
#axis(1, at=1:1001, labels=p, lwd = 3)
axis(1, at=seq(1,1001,100), labels=seq(0,1,0.1), lwd = 3)
axis(side=2,at=seq(0,1,0.2),lwd=3)
abline(v = which(p==1/n), col = "blue", lwd = 2)

plot(AvgCCS ,xaxt="n",bty="n", xlab = "The probability", ylab = "The average connected component size")
#axis(1, at=1:1001, labels=p, lwd = 3)
axis(1, at=seq(1,1001,100), labels=seq(0,1,0.1), lwd = 3)
axis(side=2,at=seq(0,20,5),lwd=3)
abline(v=c(which(p==1/n),which(p==(1-.2)/n)), col=c("blue", "red"), lty=c(1,2), lwd=c(1, 3))

plot(AvgLCCS ,xaxt="n",bty="n", xlab = "The probability", ylab = "The average size of the largest connected component")
#axis(1, at=1:1001, labels=p, lwd = 3)
axis(1, at=seq(1,1001,100), labels=seq(0,1,0.1), lwd = 3)
axis(side=2,at=seq(0,20,5),lwd=3)
abline(v=c(which(p==1/n),which(p==(1+.2)/n)), col=c("blue", "red"), lty=c(1,2), lwd=c(1, 3))
