pmc <- t(read.table('MutChip_p2.bg-cenboxplot50k', fill=T))
pmi <- t(read.table('MutInput_p2.bg-cenboxplot50k', fill=T))

pm <- pmc/pmi

pwc <- t(read.table('WTChip_p2.bg-cenboxplot50k', fill=T))
pwi <- t(read.table('WTInput_p2.bg-cenboxplot50k', fill=T))
pw <- pwc/pwi

rmi <- t(read.table('MutInput_r2.bg-cenboxplot50k', fill=T))
rmc <- t(read.table('MutChip_r2.bg-cenboxplot50k', fill=T))
rm <- rmc/rmi


rwc <- t(read.table('WTChip_r2.bg-cenboxplot50k', fill=T))
rwi <- t(read.table('WTInput_r2.bg-cenboxplot50k', fill=T))
rw <- rwc/rwi





shinyServer(function(input, output) {

    make <- plot <- function(dataset1) {
      x <- get(dataset1)
      boxplot(log2(x), col='darkred', border='red',  pch='', ylab="log2(Fold Change from Input)", xaxt="n")

      
      if(input$IN){
        dataset2 = NULL
       
        if(input$dataset1 == "pw"){
          dataset2 = "pm"
        }
        if(input$dataset1 == "rw"){
          dataset2 = "rm"
        }
        y <- get(dataset2)
        boxplot(log2(y), col='darkblue', pch='.', add=T, xaxt="n", border='blue')
      }         
    }
    
    output$boxPlot1 <- reactivePlot(function() {
      make <- plot(input$dataset1)
    })
    output$boxPlot2 <- reactivePlot(function() {
      make <- plot(input$dataset2)
    })
    


  })
