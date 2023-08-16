#Visualizations



# Number of rides for users; overall with a percentage      
      
pie(pop_totals_df$n, 
  main = "Total Population of Riders: 120,000 Total Sample Size",
  labels = pop_totals_df$member_casual,
  col = rainbow(length(pop_totals_df$n)))
  legend("bottomright", legend = pop_totals_df$percentage,
             fill = rainbow(length(pop_totals_df$n)))
      
      # By day of the week              
      ggplot(data = bikeshare_totals_22) +
        geom_bar(mapping = aes(x = day_of_week, fill = member_casual)) +
        facet_wrap(~member_casual) +
        theme(axis.text.x = element_text(angle = 25)) +
        labs(title = "Number of Rides for User Types by Day of the Week", 
             x="Day of the Week",
             y="Ride Count")              
      
      # By month
      ggplot(data = bikeshare_totals_22) +
        geom_bar(mapping = aes(x = month, fill = member_casual)) +
        facet_wrap(~member_casual) +
        theme(axis.text.x = element_text(angle = 25)) +
        labs(title = "Number of Rides for User Types by Month", 
             x="Month",
             y="Ride Count")       
      
#Busiest Time/Rides Per Hour; Casual vs. Member
      
ggplot(data = bikeshare_totals_22) +
  geom_bar(mapping = aes(x = hour, fill = member_casual)) + 
  facet_wrap(~member_casual) +
  labs(title = "Busiest Time/Rides Per Hour; Casual vs. Member", 
       x= "Hour (Military)",
       y= "Ride Count")         
  
# Preferred Bike Types      

ggplot(data = bikeshare_totals_22) +
  geom_bar(mapping = aes(x = rideable_type, fill = member_casual)) + 
  facet_wrap(~member_casual) +
  labs(title = "Preferred Bike Types; Casual vs. Member", 
       x= "Type of Bike",
       y= "Ride Count")        
      
      