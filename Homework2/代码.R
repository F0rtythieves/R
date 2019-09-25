##创建tibble
library(tidyverse);
grades <- tibble( "Name" = c("Weihua Chen", "Mm Hu", "John Doe", "Jane Doe",
                             "Warren Buffet", "Elon Musk", "Jack Ma"),
                  "Occupation" = c("Teacher", "Student", "Teacher", "Student",
                                   rep( "Entrepreneur", 3 ) ),
                  "English" = sample( 60:100, 7 ),
                  "ComputerScience" = sample(80:90, 7),
                  "Biology" = sample( 50:100, 7),
                  "Bioinformatics" = sample( 40:90, 7)
);

##将宽数据变为长数据
grades.melted <- grades %>%
  gather( course, grade, -Name, -Occupation, na.rm = T );
##每个人最差的学科和成绩
worst <- grades.melted %>%
  arrange( Name, grade ) %>%
  group_by(Name) %>%
  summarise( avg_grades = mean( grade ), worst_course = first( course ),
             worst_grade = first( grade ) ) %>%
  arrange( avg_grades );
write.table(worst,"t1.tsv",row.names=FALSE,col.names=TRUE,sep="\t")
##哪个职业的平均成绩最好
Occupation.mean <- grades.melted %>%
  arrange( Occupation, -grade ) %>%
  group_by(Occupation) %>%
  summarise( avg_grades = mean( grade )) %>%
  arrange( -avg_grades );
write.table(Occupation.mean,"t2.tsv",row.names=FALSE,col.names=TRUE,sep="\t")
##每个职业的最佳学科分别是什么（按平均分排序）
Occupation.best <- grades.melted %>%
  arrange( Occupation, -grade ) %>%
  group_by(Occupation) %>%
  summarise( avg_grades = mean( grade ), best_course = first( course ),
                                  best_grade = first( grade ) ) %>%
  arrange( -avg_grades );
write.table(Occupation.best,"t3.tsv",row.names=FALSE,col.names=TRUE,sep="\t")



