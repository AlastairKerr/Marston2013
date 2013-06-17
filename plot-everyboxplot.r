pmc <- read.table('MutChip_p.bg-cenboxplot-2-50k', header=T)
pmi <- read.table('MutInput_p.bg-cenboxplot-2-50k', header=T)
pwi <- read.table('WTInput_p.bg-cenboxplot-2-50k', header=T)
pwc <- read.table('WTChip_p.bg-cenboxplot-2-50k', header=T)


rmc <- read.table('MutChip_r.bg-cenboxplot-2-50k', header=T)
rmi <- read.table('MutInput_r.bg-cenboxplot-2-50k', header=T)

rwi <- read.table('WTInput_r.bg-cenboxplot-2-50k', header=T)
rwc <- read.table('WTChip_r.bg-cenboxplot-2-50k', header=T)


for(i in c("CEN1","CEN2","CEN3","CEN4","CEN5","CEN6","CEN7","CEN8","CEN9","CEN10","CEN11","CEN12","CEN13","CEN14","CEN15","CEN16"))
{
  pdf(paste(i, "-dupout.pdf", sep=""))
  par(cex.lab=1.4)
  plot(xlim=c(-10000,10000), rwc$Position, log2(rwc[[i]]/rwi[[i]] ),   ylim=c(-3,9), pch='.', xlab="Position", ylab="log2(Sample/Input)")

  lines(rwc$Position, log2( rwc[[i]]  / rwi[[i]] ),  col="red",  lwd=6)
  lines(rwc$Position, log2( rmc[[i]]  / rmi[[i]] ),  col="blue", lwd=6)


  axis(1, lwd=2)
  axis(2, lwd=2)



  pdf(paste(i, "-dupin.pdf", sep=""))
  par(cex.lab=1.4)
  plot(xlim=c(-10000,10000), pwc$Position, log2(pwc[[i]]/pwi[[i]] ),   ylim=c(-3,9), pch='.', xlab="Position", ylab="log2(Sample/Input)")

  lines(pwc$Position, log2( pwc[[i]]  / pwi[[i]] ),  col="red",  lwd=6)
  lines(pwc$Position, log2( pmc[[i]]  / pmi[[i]] ),  col="blue", lwd=6)


                                        #Red = Chip/Input in WT
  #Blue = Chip/Input  in Mutant 
  axis(1, lwd=2)
  axis(2, lwd=2)
}         
    
