library(data.table)
library(ggplot2)
library(gridExtra)
library(cowplot)

transactions <- read.csv("Desktop/madrid_Credit_Card_transactions.csv")
data<-as.data.table(transactions)

#Number of transactions by nationality 
customer_per_country <- data[,.(n=.N),by="customer_country"][order(-n)]
customer_per_country$customer_country <- factor(customer_per_country$customer_country, levels=customer_per_country$customer_country[order(customer_per_country$n)])
p1 <- ggplot(customer_per_country[1:25], aes(x=customer_country, y=n)) + geom_bar(stat="identity", fill="light blue")+ coord_flip()+ xlab("Country") + ylab("Number of Transactions") + labs(title="Top 25 Nationalities by # of Transactions") + geom_text(aes(label=n),size=3) + theme_classic()


#Total Spending by Nationality
spending_by_nationality <- data[,.(total=as.integer(round(sum(amount)/1000,0))),by="customer_country"][order(-total)]
spending_by_nationality$customer_country <- factor(spending_by_nationality$customer_country, levels=spending_by_nationality$customer_country[order(spending_by_nationality$total)])
p2 <- ggplot(spending_by_nationality[1:25], aes(x=customer_country, y=total)) + geom_bar(stat="identity", fill="light green")+ coord_flip()+ xlab("") + ylab("Total Expenditure (thousand Euros") + labs(title="Top 25 Total Expenditure by Nationality") + geom_text(aes(label=total),size=3) + theme_classic()

#Nationality spending per transaction
nationality_spending_per_transaction <- data[,.(per_transaction = as.integer(round(mean(amount),0)), n=.N), by="customer_country"][n>20,][order(-per_transaction)]
nationality_spending_per_transaction$customer_country <- factor(nationality_spending_per_transaction$customer_country, levels=nationality_spending_per_transaction$customer_country[order(nationality_spending_per_transaction$per_transaction)])
p3 <- ggplot(nationality_spending_per_transaction[1:25], aes(x=customer_country, y=per_transaction))+ geom_bar(stat="identity", fill="light grey")+ coord_flip()+ xlab("") + ylab("Average value per transaction") + labs(title="Top 25 Nationalities by Value per Transaction",subtitle="Minimum 20 transactions") + geom_text(aes(label=per_transaction),size=3) + theme_classic()

plot_grid(p1, p2, p3,  ncol = 3, nrow = 1)

#Spending by category (total)
spending_per_category <- data[,.(total=as.integer(round((sum(amount)/1000),2))), by="category"][order(-total)]
spending_per_category$category <- factor(spending_per_category$category, levels=spending_per_category$category[order(spending_per_category$total)])
c1 <- ggplot(spending_per_category, aes(x=category, y=total)) + geom_bar(stat="identity", fill="light green")+ coord_flip()+ xlab("Category") + ylab("Total Expenditure (thousand Euros)") + labs(title="Total Expenditure by Category") + geom_text(aes(label=total),size=3) + theme_classic()

#Spending by category (average)
spending_per_category_avg <- data[,.(n=.N,avg=as.integer(round((mean(amount)),2))), by="category"][order(-avg)][n>20]
spending_per_category_avg$category <- factor(spending_per_category_avg$category, levels=spending_per_category_avg$category[order(spending_per_category_avg$avg)])
c2 <- ggplot(spending_per_category_avg, aes(x=category, y=avg)) + geom_bar(stat="identity", fill="light blue")+ coord_flip()+ xlab("") + ylab("Average value per transaction") + labs(title="Average Ticket by Category",subtitle="Minimum 20 transactions") + geom_text(aes(label=avg),size=3) + theme_classic()

plot_grid(c1, c2, ncol = 2, nrow = 1)


#Spending by country in each category
spe_country_cat <- data[,.(total=as.integer(round(sum(amount),2)),per_transaction=as.integer(round(mean(amount),2)),n=.N),keyby=c("category", "customer_country")]
#Categories of interest: Fashion, Accommodation, Bars, Culture
spe_country_fashion <- spe_country_cat[spe_country_cat$category == "Fashion & Shoes",][order(-per_transaction)][n>20]
spe_country_accom <- spe_country_cat[spe_country_cat$category == "Accommodation",][order(-per_transaction)][n>20]
spe_country_bars <- spe_country_cat[spe_country_cat$category == "Bars & restaurants",][order(-per_transaction)][n>20]
spe_country_cult <- spe_country_cat[spe_country_cat$category == "Culture & Leisure",][order(-per_transaction)]

spe_country_fashion$customer_country <- factor(spe_country_fashion$customer_country, levels=spe_country_fashion$customer_country[order(-spe_country_fashion$per_transaction)])
spe_country_accom$customer_country <- factor(spe_country_accom$customer_country, levels=spe_country_accom$customer_country[order(-spe_country_accom$per_transaction)])
spe_country_bars$customer_country <- factor(spe_country_bars$customer_country, levels=spe_country_bars$customer_country[order(-spe_country_bars$per_transaction)])
spe_country_cult$customer_country <- factor(spe_country_cult$customer_country, levels=spe_country_cult$customer_country[order(-spe_country_cult$per_transaction)])
rm(spe_country_cat)


dd <- unique(data$customer_country)
dd <- unique(dd)
color = grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]
dd.col <- sample(color,length(dd))
names(dd.col) <- dd

t1 <- ggplot(spe_country_fashion[1:20], aes(x=customer_country, y=per_transaction)) + geom_col(fill="light green") + theme(axis.text=element_text(size=8),axis.title=element_text(size=8,face="bold"), plot.title = element_text(size=8, face="bold")) + labs(title="Fashion and Shoes", x="Country", y="") + scale_fill_manual("Legend", values = dd.col)
t2 <- ggplot(spe_country_accom[1:20], aes(x=customer_country, y=per_transaction)) + geom_col(fill="light blue") + theme(axis.text=element_text(size=8),axis.title=element_text(size=8,face="bold"), plot.title = element_text(size=8, face="bold")) + labs(title="Accommodation", x="Country", y="") + scale_fill_manual("Legend", values = dd.col)
t3 <- ggplot(spe_country_bars[1:20], aes(x=customer_country, y=per_transaction)) + geom_col(fill="light grey")+ theme(axis.text=element_text(size=8),axis.title=element_text(size=8,face="bold"),  plot.title = element_text(size=8, face="bold")) + labs(title="Bars & Restaurants", x="Country", y="") + scale_fill_manual("Legend", values = dd.col)
title <- ggdraw() + draw_label("Average Ticket by country by category", fontface='bold')
p <- plot_grid(t1 + theme(legend.position="none"),
               t2 + theme(legend.position="none"),
               t3 + theme(legend.position="none"), 
               ncol = 3, nrow = 1)

p


spending_hour <- data[data$category %in% c("Fashion & Shoes","Bars & restaurants","Accommodation"),.(n=.N,total=mean(amount)), by=c("category", "hour", "weekday")][order(category, -weekday, hour)]
spending_hour
p6 <- ggplot(spending_hour, aes(x=hour, y=total, fill=weekday)) + geom_bar(stat="identity") + labs(subtitle="Spending throughout the day")
p5<- ggplot(spending_hour, aes(x=hour, y=total, fill=weekday)) + geom_bar(stat="identity") + facet_wrap(spending_hour$category,nrow = 3)
plot_grid(p6,p5,ncol=1)


#Fashion
spending_hour_fashion <- spending_hour[spending_hour$category=="Fashion & Shoes" & spending_hour$customer_country %in% c("ID","TW","AE","CN","SG","JP"),.(total=sum(total)), keyby=c("customer_country","hour")]
fash <- ggplot(spending_hour_fashion, aes(x=factor(hour), y=total)) + geom_bar(stat="identity", fill="light blue") + facet_wrap(spending_hour_fashion$customer_country, ncol=1) + theme_classic() + xlab("Hour")
title1 <- ggdraw() + draw_label("Tourism spending in Fashion by nationality throughout the day", fontface='bold')
plot_grid(title1, fash, ncol=1,rel_heights=c(0.1, 1))

#Bars
spending_hour_bars <- spending_hour[spending_hour$category=="Bars & restaurants" & spending_hour$customer_country %in% c("CN","JP","IT","RU","CH","AR","GB"),.(total=sum(total)), keyby=c("customer_country","hour")]
bars <- ggplot(spending_hour_bars, aes(x=factor(hour), y=total)) + geom_bar(stat="identity", fill="light green") + facet_wrap(spending_hour_bars$customer_country, ncol=1) + theme_classic() + xlab("Hour")
title2 <- ggdraw() + draw_label("Tourism spending in Bars and Restaurants by nationality throughout the day", fontface='bold', size=10)
plot_grid(title2, bars, ncol=1,rel_heights=c(0.1, 1))

