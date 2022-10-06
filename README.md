# Overview
Gala Groceries is a technology-led grocery store chain based in the USA. They rely heavily on new technologies, such as IoT to give them a competitive edge over other grocery stores. 

They pride themselves on providing the best quality, fresh produce from locally sourced suppliers. However, this comes with many challenges to consistently deliver on this objective year-round.

# Exploratory Data Analysis
Gala Groceries approached Cognizant to help them with a supply chain issue. Groceries are highly perishable items. If you overstock, you are wasting money on excessive storage and waste, but if you understock, then you risk losing customers. They want to know how to better stock the items that they sell.

# Model building
Based on my recommendations, they want to focus on the following problem statement:

“Can we accurately predict the stock levels of products based on sales data and sensor data on an hourly basis in order to more intelligently procure products from our suppliers?” 

The client has agreed to share more data in the form of sensor data. They use sensors to measure temperature storage facilities where products are stored in the warehouse, and they also use stock levels within the refrigerators and freezers in store. 

The client has provided 3 datasets, it is now my job to combine, transform and model these datasets in a suitable way to answer the problem statement that the business has requested.

# Machine Learning Production
Gala Groceries saw the results of the machine learning model as promising and believe that with more data and time, it can add real value to the business.

To build the foundation for this machine learning use case, they want to implement a first version of the algorithm into production. In the current state, as a Python notebook, this is not suitable to productionize a machine learning model. 

Therefore, as the Data Scientist that created this algorithm, I will prepare a Python module that contains code to train a model and output the performance metrics when the file is run. 
