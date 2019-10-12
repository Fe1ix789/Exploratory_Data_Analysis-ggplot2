# Exploratory Data Analysis using ggplot2 #




----
## Assignment Details ##

Define specific use cases in which credit card transaction data can add real value. The goal is to discover different insights from the data through 5 - 8 data visualization (with GGPlot2) and then transform them into potential business outcomes. Insights are wanted, Design is secondary.

The dataset consists of 10,000 credit card transactions performed by tourists in the city of Madrid during a month.

## Final Report ##

#### INTRODUCTION ####

The analysis of tourists’ credit card transactions can provide a deeper understanding on travel spending, allowing to identify trends and highlights in consumption patterns from visitors. This report focuses on the analysis of credit card transactions performed by tourists in the city of Madrid, Spain, between March 2nd and 3rd, 2012. The data available includes information about the amount, country of origin, spending category and timing of a transaction.
Within the 48 hours of data available, we found 110 different nationalities to be present, 10.793 transactions and €1.173.584 in purchases. As will be elaborated later in the report, the countries with the highest spending were the United States, Great Britain, China, France and Japan. In addition, most expenses during the 48 hours were concentrated among three main categories: “Fashion & Shoes”, “Bars & Restaurants” and “Accommodation”.
The exploratory analysis of the dataset revealed interesting patterns of consumer behavior of different nationalities, which present distinct characteristics in terms of spending category, timing of purchase and average ticket value, which will be further explained below.
Lastly, some potential data monetization strategies are discussed in the final part of the report, which focuses on how the discovered insights and patterns can be used as input for search engine keywords pricing strategies. The genesis for this project was to determine how Citibank can better monetize its current transactional data and present a set of recommendations at Citibank’s annual convention. As a result of the data exploration, this report recommends a partnership and pilot program with Google using Citibank’s transactional data.

#### KEY FINDINGS ####

* Yankee Invasion: US tourists are the ones spending more money in Madrid. In the 48 hours covered by the dataset, they left more than €180.000 at the Spanish capital. ¡Muchas gracias!
* Thailand, South Africa and Indonesia – highest average tickets: visitors from those countries seem to be keen to making very expensive purchases. On average, each of their transactions is 4 times greater than the overall average.
* Cover Page – Fashion in the spotlight with highest share of tourists’ wallet: Tourists in Madrid seem to love its fashion retail stores: in two days, they spent almost half a million euros in clothing and shoes.
* Happy Hours – Bars & Restaurants cash in after sunset: as the day is over in the Spanish capital, tourists make sure to enjoy its delicious food and cañas: 200 thousand euros were spent in two days, mostly after 6pm and well into the night.

#### SPENDING BY COUNTRY OF ORIGIN ####

The number one country in terms of transactions made in the given period is the United States, with 1.686 purchases, 15.6% of the total, followed by France (11.4%) and Great Britain (7.8%). In fact, out of the 110 different nationalities in the dataset, the top 25 account for over 83% of all transactions and 81% of all the money spent. Considering the total money spent by tourists, the United States are again a clear winner, with almost 185 thousand Euros in transactions, or nearly 16% of the total. This is followed by Great Britain (7.6%), China (7.5%) and France (6.9%). Together, tourists from these four countries infused more than 440 thousand Euros to the Spanish capital’s economy in just 48 hours. Furthermore, the removal from the analysis of some transactions which may be considered outliers does not alter such conclusions. 
Interestingly, when we look at those transactions from an average ticket perspective, we see completely different countries topping the rankings. Considering only countries with at least 20 transactions made in the given period, we found out that tourists from Thailand spent on average €408 on each transaction. South African tourists, with an average of €395, Indians with around €358 and Malaysians with €332 per transaction, complete the top 5 in this category. 
This indicates that, although not present in large numbers in Madrid, tourists from these countries represent an important source of tourism revenue, accounting for the most valuable transactions made by tourists in the city.

<img src="https://github.com/Fe1ix789/MBD/blob/master/ggplot2-Project/Picture_1.png?raw=true" width=fill>





