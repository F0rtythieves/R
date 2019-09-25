library(tidyverse)
q1 <- mouse.tibble %>%
  arrange( `Chromosome/scaffold name`, -`Transcript length (including UTRs and CDS)` ) %>%
  group_by(`Chromosome/scaffold name`) %>%
  summarise( avg_length = mean(`Transcript length (including UTRs and CDS)` ), gene_count = n(),longest=first(`Transcript length (including UTRs and CDS)`),
                                                                                                                                 longest_name=first(`Gene stable ID`),shortest=last(`Transcript length (including UTRs and CDS)`),
             shortest_name=last(`Gene stable ID`)) %>%
  arrange( -avg_length );
q2 <- q1  %>%
filter( gene_count >= 500  ) %>%
  arrange(-gene_count)
##保存至文本文件
write.table(q1,"q1.txt",quote = FALSE,row.names = FALSE,
            col.names = FALSE)
write.table(q2,"q2.txt",quote = FALSE,row.names = FALSE,
            col.names = FALSE)
  
