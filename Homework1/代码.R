##读入数据
library( readr );
mouse.tibble <- read_delim( file = "C:/Users/admin/Desktop/R-for-bioinformatics-master/data/talk04/mouse_genes_biomart_sep2018.txt",delim = "\t", quote = "" )
##选取常染色体基因
library(dplyr);
mouse.tibble.chr1_19 <-mouse.tibble %>% filter( `Chromosome/scaffold name` %in% as.character(c(1:19)) );
##按染色体序号排列,从1开始
library(ggplot2);
plot1 <-
  ggplot( data = mouse.tibble.chr1_19,
          aes( x = `Chromosome/scaffold name`,
               y = `Transcript length (including UTRs and CDS)` ) ) +
  geom_boxplot() + scale_x_discrete(limits=as.character(c(1:19))) +
  coord_flip() +
  ylim( 0, 2500 ) ;
##按基因长度中值排列，从短 -> 长 
plot2 <-
  ggplot( data = mouse.tibble.chr1_19,
          aes( x = reorder( `Chromosome/scaffold name`,
                            `Transcript length (including UTRs and CDS)`,
                            median ),
               y = `Transcript length (including UTRs and CDS)` ) ) +
  geom_boxplot() +
  coord_flip() +
  ylim( 0, 2500 ) ;
##导出pdf
ggsave(plot1,filename = "1.pdf",width = 12,height = 9)
ggsave(plot2,filename = "3.pdf",width = 12,height = 9)