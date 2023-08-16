## Hello! Check out my R script for Cyclistic below. 
 

# Loaded libraries
      library(tidyverse)

      
      
# Loaded data and previewed 
      bikeshare_totals_22  <- read_csv("2022.Bikeshare.Data_totals.csv")
      head(bikeshare_totals_22)
      colnames(bikeshare_totals_22)

      
      
# Further cleaning, run each line independently 
      
      # Hourly Summary
            bikeshare_totals_22$time_of_use <- as.POSIXct(bikeshare_totals_22$time_of_use)
            #
            bikeshare_totals_22$hour <- format(bikeshare_totals_22$time_of_use, "%H")
            
      # Assign orders for weekday
            weekday_order <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
            #
            bikeshare_totals_22$day_of_week <- factor(bikeshare_totals_22$day_of_week, levels = weekday_order, ordered = TRUE)
            
      # Assign orders for month
            month_order <- c("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC")
            #
            bikeshare_totals_22$month <- factor(bikeshare_totals_22$month, levels = month_order, ordered = TRUE)
            
      #Set numeric for time_of_use & distance_in_mi
            bikeshare_totals_22$ride_length <- as.numeric(bikeshare_totals_22$ride_length)
            #
            bikeshare_totals_22$distance_in_mi <- as.numeric(bikeshare_totals_22$distance_in_mi)
 
            
                 
# Build independent data frames; casual vs. member
      
      casual <- bikeshare_totals_22 %>% 
        filter(member_casual == 'casual') 
      
      member <- bikeshare_totals_22 %>% 
        filter(member_casual == 'member') 

      
      
# Number of rides for users; overall with a percentage

      total_count <- n_distinct(bikeshare_totals_22$ride_id)
            
      pop_totals_df <- bikeshare_totals_22 %>%
        group_by(member_casual) %>% 
        count(member_casual)  %>% 
        mutate(percentage = round((n / total_count) * 100, digits = 2)) 

      # By day of the week
      
            # For Casuals
            weekday_totals_c <- casual %>% 
              group_by(day_of_week) %>% 
              count(member_casual)
            
            # For Members
            weekday_totals_m <- member %>% 
              group_by(day_of_week) %>% 
              count(member_casual)
            
      # By month 
            
            # For Casuals
            month_totals_c <- casual %>% 
              group_by(month) %>% 
              count(member_casual)
            
            # For Members
            month_totals_m <- member %>%
              group_by(month) %>% 
              count(member_casual)

      
            
# Busiest time/Rides Per Hour
            
      # For Casuals
      hourly_summary_c <- aggregate(time_of_use ~ hour, casual, FUN = length)
      
      # For Members
      hourly_summary_m <- aggregate(time_of_use ~ hour, member, FUN = length)

      
          
# Preferred Bike Types
      
      # For Casuals
      bike_types_casual <- casual %>% 
        count(casual$rideable_type)
      
      # For Members
      bike_types_member <- member %>% 
        count(member$rideable_type)      

        
            
# Most popular stations
      
      #Total Stations
      total_stations <- n_distinct(bikeshare_totals_22$end_station_id)
      
      # Top 10 start stations
            # For Casuals
            top10_start_stations_c <- casual %>% 
              count(casual$start_station_name) %>% 
              arrange(desc(n)) %>% 
              slice_head(n = 6)
            
            # For Members
            top10_start_stations_m <- member %>% 
              count(member$start_station_name) %>% 
              arrange(desc(n)) %>% 
              slice_head(n = 6)
      
      # Top 10 end stations
            # For Casuals
            top10_end_stations_c <- casual %>% 
              count(casual$end_station_name) %>% 
              arrange(desc(n)) %>% 
              slice_head(n = 6)
            
            # For Members
            top10_end_stations_m <- member %>% 
              count(member$end_station_name) %>% 
              arrange(desc(n)) %>% 
              slice_head(n = 6)
            
            
            
#Average Ride Lengths: 
            
            # For Casuals
            avg_length_casuals_df <- casual %>% 
              filter(ride_length >= 45)
            average_length_c <- mean(avg_length_casuals_df$ride_length) / 60
            
            # For Members
            avg_length_members_df <- member %>% 
              filter(ride_length >= 45)
            average_length_m <- mean(avg_length_members_df$ride_length) / 60
            
            
            
# Average Distance      
            
            # For Casuals 
            distance_c <- casual %>% 
              select(distance_in_mi) %>% 
              filter(distance_in_mi >= 0.1)
            mean(distance_c$distance_in_mi)
            
            # For Members
            distance_m <- member %>% 
              select(distance_in_mi) %>% 
              filter(distance_in_mi >= 0.1)
            mean(distance_m$distance_in_mi)
            
            
            
# Average Speed
            
            # For Casuals   
            speed_c <- casual %>% 
              select(distance_in_mi, ride_length) %>% 
              filter(distance_in_mi >= 0.1) %>% 
              filter(ride_length > 0) %>% 
              mutate(speed = ((distance_in_mi / ride_length) * 3600))
            
            casual_speed_mph <- mean(speed_c$speed)
            
            # For Members       
            speed_m <- member %>% 
              select(distance_in_mi, ride_length) %>% 
              filter(distance_in_mi >= 0.1) %>% 
              filter(ride_length > 0) %>% 
              mutate(speed = ((distance_in_mi / ride_length) * 3600))
            
            member_speed_mph <- mean(speed_m$speed) 
 