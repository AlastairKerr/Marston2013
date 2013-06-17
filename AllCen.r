pmc <- t(read.table('MutChip_p.bg-cenboxplot50k', fill=T))
pmi <- t(read.table('MutInput_p.bg-cenboxplot50k', fill=T))

pm <- pmc/pmi

pwc <- t(read.table('WTChip_p.bg-cenboxplot50k', fill=T))
pwi <- t(read.table('WTInput_p.bg-cenboxplot50k', fill=T))
pw <- pwc/pwi

rmi <- t(read.table('MutInput_r.bg-cenboxplot50k', fill=T))
rmc <- t(read.table('MutChip_r.bg-cenboxplot50k', fill=T))
rm <- rmc/rmi


rwc <- t(read.table('WTChip_r.bg-cenboxplot50k', fill=T))
rwi <- t(read.table('WTInput_r.bg-cenboxplot50k', fill=T))
rw <- rwc/rwi


png("fig2a-dup.png")
boxplot(log2(rw), col='darkred', border='red',  pch='', ylab="log2(Fold Change from Input)", xaxt="n")
boxplot(log2(rm), col='darkblue', pch='.', add=T, xaxt="n", border='blue')

png("fig2a+dup.png")
boxplot(log2(pw), col='darkred', border='red',  pch='', ylab="log2(Fold Change from Input)", xaxt="n")
boxplot(log2(pm), col='darkblue', pch='.', add=T, xaxt="n", border='blue')
