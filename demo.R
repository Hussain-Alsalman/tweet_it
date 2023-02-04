library("tasi")

# In the past you used to get industry data by calling a function .. 
# that starts with get_.....
# now you can just create that function by using industry_func(industry_name)

get_banks <- industry_func("banks")

# Now we have a function called get_banks 

get_banks(start_date = "2020-01-01", end_date = "2022-12-31")

# Similarly 
get_capitals <- industry_func("capitals") 
get_energy <- industry_func("energy")

# use `list_industries()" to see all available industries
list_industries()

