#Import libraries
library(tidyverse)
library(lubridate)
library(fastDummies)
library(randomForest)

#Import the datsets
sales <- read.csv("sales.csv")
sensor_storage_temperature <- read.csv("sensor_storage_temperature.csv")
sensor_stock_levels <- read.csv("sensor_stock_levels.csv")

sales$X <- NULL
sensor_storage_temperature$X <- NULL
sensor_stock_levels$X <- NULL

# Change timestamp into a datetime variable including only the date and the hour
sales$timestamp <- as.POSIXct(sales$timestamp, format="%Y-%m-%d %H")
sensor_storage_temperature$timestamp <- as.POSIXct(sensor_storage_temperature$timestamp, format="%Y-%m-%d %H")
sensor_stock_levels$timestamp <- as.POSIXct(sensor_stock_levels$timestamp, format="%Y-%m-%d %H")

# Total quantity of each product sold per hour
sales_agg <- sales %>%
  group_by(timestamp, product_id) %>%
  summarise(quantity = sum(quantity))

# Average hourly temperature of the storage facility
temperature_agg <- sensor_storage_temperature %>%
  group_by(timestamp) %>%
  summarise(temperature = mean(temperature))

#Average stock percentage of each product per hour
stock_agg <- sensor_stock_levels %>%
  group_by(timestamp, product_id) %>%
  summarise(estimated_stock_pct = mean(estimated_stock_pct))

# Merge data
stock_sales <- left_join(stock_agg, sales_agg, by = c("timestamp", "product_id"))
sales_stock_temp <- left_join(stock_sales, temperature_agg, by = "timestamp")

# Fill all NA values with 0 because it represents that there were 0 sales of this product within the hour
sales_stock_temp$quantity[is.na(sales_stock_temp$quantity)] = 0

#Combining more features from sales to sales_stock_temp
#category
product_categories <- sales %>%
  group_by(product_id, category) %>%
  summarise()

#unit_price
product_price <- sales %>%
  group_by(product_id, unit_price) %>%
  summarise()

#Merge data
sales_stock_temp <- left_join(sales_stock_temp, product_categories, by = "product_id")
sales_stock_temp <- left_join(sales_stock_temp, product_price, by = "product_id")

#Add new columns from timestamp such as day, weekday and hour
sales_stock_temp <- sales_stock_temp %>%
  mutate(timestamp_day_of_month = day(timestamp),
         timestamp_day_of_week = wday(timestamp),
         timestamp_hour = hour(timestamp))

#Remove timestamp
sales_stock_temp$timestamp <- NULL

#Convert category to dummy variables
sales_stock_temp <- dummy_cols(sales_stock_temp, select_columns = "category", remove_selected_column = TRUE)

#Remove product_id since it will add no value by including it in the predictive model
sales_stock_temp$product_id <- NULL

write.csv(sales_stock_temp, "sales_stock_temp.csv")