library(tidyverse)
library(ggthemes)
library(lubridate)

gala_groceries_sales <- read.csv("sample_sales_data.csv")
gala_groceries_sales$X <- NULL

summary(gala_groceries_sales)
str(gala_groceries_sales)

gala_groceries_sales$timestamp <- as.POSIXct(gala_groceries_sales$timestamp, format="%Y-%m-%d %H:%M:%S")

gala_groceries_sales$category <- as.factor(gala_groceries_sales$category)
gala_groceries_sales$customer_type <- as.factor(gala_groceries_sales$customer_type)
gala_groceries_sales$payment_type <- as.factor(gala_groceries_sales$payment_type)

#Number of Transactions by Category
transactions_by_category <- gala_groceries_sales %>%
  group_by(category)%>%
  count() %>%
  rename("number_of_products" = n) %>%
  arrange(desc(number_of_products)) %>%
  ungroup() %>%
  mutate(percentt = number_of_products/sum(number_of_products)*100)

ggplot(transactions_by_category, aes(x = category, y = number_of_products)) +
  geom_bar(stat = "identity") +
  theme_economist() +
  theme(axis.text.x = element_text(angle = 90, size = 15, vjust = 0.5), 
        axis.text.y = element_text(size = 15, hjust = 1), 
        axis.title = element_text(size = 20, vjust = 2)) +
  scale_y_continuous(breaks = seq(0, 1000, by = 100)) +
  labs(x = "Product Category",
       y = "Number of Transactions") +
  coord_flip()


#Number of Transactions by Customer Type
transactions_by_customer_type <- gala_groceries_sales %>%
  group_by(customer_type)%>%
  count() %>%
  rename("number_of_transactions" = n) %>%
  arrange(desc(number_of_transactions)) %>%
  ungroup() %>%
  mutate(percent = number_of_transactions/sum(number_of_transactions)*100)

#Number of Transactions by Quantity
transactions_by_quantity <- gala_groceries_sales %>%
  group_by(quantity)%>%
  count() %>%
  rename("number_of_transactions" = n) %>%
  arrange(desc(number_of_transactions)) %>%
  ungroup() %>%
  mutate(percent = number_of_transactions/sum(number_of_transactions)*100)

#Number of Transactions by Payment Type
transactions_by_payment_type <- gala_groceries_sales %>%
  group_by(payment_type)%>%
  count() %>%
  rename("number_of_transactions" = n) %>%
  arrange(desc(number_of_transactions)) %>%
  ungroup() %>%
  mutate(percent = number_of_transactions/sum(number_of_transactions)*100)

#Number of Transactions by Product ID
transactions_by_payment_product_id <- gala_groceries_sales %>%
  group_by(product_id) %>%
  count() %>%
  rename("number_of_transactions" = n) %>%
  arrange(desc(number_of_products))

#Total Amount of Products Sold by Category
total_amount_of_products_sold_by_category <- gala_groceries_sales %>%
  group_by(category)%>%
  summarise(total_amount = sum(total)) %>%
  arrange(desc(total_amount))

ggplot(total_amount_of_products_sold_by_category, aes(x = category, y = total_amount)) +
  geom_bar(stat = "identity") +
  theme_economist() +
  theme(axis.text.x = element_text(angle = 90, size = 15, vjust = 0.5), 
        axis.text.y = element_text(size = 15, hjust = 1), 
        plot.title = element_text(size = 20, hjust = 0.5), 
        axis.title = element_text(size = 20, vjust = 2)) +
  scale_y_continuous(breaks = seq(0, 15000, by = 1000)) +
  labs(x = "Product Category",
       y = "Total Amount of Products Sold by Category") +
  coord_flip()

#Total Amount of Products Sold by Customer Type
total_amount_of_products_sold_by_customer_type <- gala_groceries_sales %>%
  group_by(customer_type)%>%
  summarise(total_amount = sum(total)) %>%
  arrange(desc(total_amount)) %>%
  mutate(percentt = total_amount/sum(total_amount)*100)

#Total Amount of Products Sold by Quantity Bought
total_amount_of_products_sold_by_quantity <- gala_groceries_sales %>%
  group_by(quantity)%>%
  summarise(total_amount = sum(total)) %>%
  arrange(desc(total_amount)) %>%
  mutate(percentt = total_amount/sum(total_amount)*100)

#Total Amount of Products Sold by Payment Type
total_amount_of_products_sold_by_payment_type <- gala_groceries_sales %>%
  group_by(payment_type)%>%
  summarise(total_amount = sum(total)) %>%
  arrange(desc(total_amount)) %>%
  mutate(percentt = total_amount/sum(total_amount)*100)

#Number of Products Sold by Category
products_sold_by_category <- gala_groceries_sales %>%
  group_by(category)%>%
  summarise(number_of_products = sum(quantity)) %>%
  arrange(desc(number_of_products)) %>%
  ungroup() %>%
  mutate(percentt = number_of_products/sum(number_of_products)*100)

ggplot(products_sold_by_category, aes(x = category, y = number_of_products)) +
  geom_bar(stat = "identity") +
  theme_economist() +
  theme(axis.text.x = element_text(angle = 90, size = 15, vjust = 0.5), 
        axis.text.y = element_text(size = 15, hjust = 1), 
        plot.title = element_text(size = 20, hjust = 0.5), 
        axis.title = element_text(size = 20, vjust = 2)) +
  scale_y_continuous(breaks = seq(0, 3000, by = 500)) +
  labs(x = "Product Category",
       y = "Number of Products Sold by Category") +
  coord_flip()

#Number of Products Sold by Customer Type
products_sold_by_customer_type <- gala_groceries_sales %>%
  group_by(customer_type)%>%
  summarise(number_of_products = sum(quantity)) %>%
  arrange(desc(number_of_products)) %>%
  mutate(percent = number_of_products/sum(number_of_products)*100)

#Number of Products Sold by Quantity
products_sold_by_quantity <- gala_groceries_sales %>%
  group_by(quantity)%>%
  summarise(number_of_products = sum(quantity)) %>%
  arrange(desc(number_of_products)) %>%
  mutate(percent = number_of_products/sum(number_of_products)*100)

#Number of Products Sold by payment Type
products_sold_by_payment_type <- gala_groceries_sales %>%
  group_by(payment_type)%>%
  summarise(number_of_products = sum(quantity)) %>%
  arrange(desc(number_of_products))

#Number of Transactions Per Day
transactions_per_day <- gala_groceries_sales %>%
  group_by(day = lubridate::day(timestamp)) %>%
  summarise(number_of_transactions=n())

#Number of Products Sold Per Day
products_sold_per_day <- gala_groceries_sales %>%
  group_by(day = lubridate::day(timestamp)) %>%
  summarise(number_of_products = sum(quantity))

#Average quantity of Products Sold per day
avg_products_quantity_sold_per_day <- gala_groceries_sales %>%
  group_by(day = lubridate::day(timestamp)) %>%
  summarise(number_of_products = mean(quantity))

#Total Amount of Products Sold Per Day
amount_of_products_sold_per_day <- gala_groceries_sales %>%
  group_by(day = lubridate::day(timestamp)) %>%
  summarise(number_of_products = sum(total))

#Average Amount of Products Sold Per Day
avg_amount_of_products_sold_per_day <- gala_groceries_sales %>%
  group_by(day = lubridate::day(timestamp)) %>%
  summarise(number_of_products = mean(total))


#Number of Transactions by Time
transactions_by_time <- gala_groceries_sales %>%
  group_by(hour = lubridate::hour(timestamp)) %>%
  summarise(number_of_transactions=n())

#Number of Products Sold by Time
products_sold_by_time <- gala_groceries_sales %>%
  group_by(hour = lubridate::hour(timestamp)) %>%
  summarise(number_of_products = sum(quantity))

#Average quantity of Products Sold by Time
avg_products_quantity_sold_by_time <- gala_groceries_sales %>%
  group_by(hour = lubridate::hour(timestamp)) %>%
  summarise(average_number_of_products = mean(quantity))

#Total Amount of Products Sold by Time
amount_of_products_sold_by_time <- gala_groceries_sales %>%
  group_by(hour = lubridate::hour(timestamp)) %>%
  summarise(amount = sum(total))

#Average Amount of Products Sold by Time
avg_amount_of_products_sold_by_time <- gala_groceries_sales %>%
  group_by(hour = lubridate::hour(timestamp)) %>%
  summarise(amount = mean(total))
                     