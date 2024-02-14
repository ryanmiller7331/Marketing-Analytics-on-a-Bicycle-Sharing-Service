<h2> Marketing Analytics on a Bicycle Sharing Service (via GDACC Capstone) </h2>

----------------------------------
Introduction: Ask & Prepare
----------------------------------

Scenario:

Cyclistic is an established bicycle sharing serive in the Chicago area with hundreds of daily riders. With looming competition, one of the key advantages is the offering of asitive transportation options for disabled riders, accounting for 8% of sales. It also offers flexible pricing options: single-ride passes, full-day passes, and annual memberships. It's been recently determined that annual memberships are significantly more profitable that casuals (single-ride/full-day passes)

Cyclistic's directer of marketing beleives maximizing annual membershiops is key to future growth, and she is developing a pitch to senior management in the hopes of redirecting resources to focus less on attracting all-new users, but converting casual riders into annual membership holders. She has apprached one of her analysts with the below in order to gain insight on potential marketing tactics for current riders: 

Uilize historical trip data, how do annual members and casual riders use Cyclistic bikes differently?

--------------

Initial Data Sources:

(Note: Cyclistic is a fictional company. The data has been made available by Motivate International Inc. under this license [https://www.divvybikes.com/data-license-agreement].)

(Disclaimer: .csv data was comsolidated to 10,000 rows per sheet in the interest of preserving compute in order to avoid crashes/overnight import times with tools used)

(Limitation: in the interest of data-privacy, prohibited from using riders’ personally identifiable information, meaning inability to connect pass purchases to credit card numbers, determining if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.)

Dataset location: https://divvy-tripdata.s3.amazonaws.com/index.html
Dataset description: Files utilizing last years' (2022) metrics loaded & prepared for analization
Metrics: ride_id , rideable_type , started_at , ended_at , start_station_name , start_station_id , end_station_name , end_station_id , start_lat , start_lng , end_lat , end_lng , member_casual

----------------------------------
Process & Analyze: Step by Step 
----------------------------------

----------
Excel 
----------

1. Download .csv from location (all 2022 files, seperated by month, 12 files.)

2. Import .csv's into Excel. 

3. Considering all column metrics are the same across each month, I began to combine each sheet into one for cleaning & manipulation purposes in Excel. (120,000 rows)

4. Once my sheets were combined, I began my cleaning process:
	4.1. I checked for duplicates in the "ride_id" column, as these ought to have unique values. 
	4.2. Next, I applied filters to "rideable_type", "member_casual" as these should have expected unique values in the single digits
	4.3. While checking for missing data, I noticed that quite a few rows had missing start stations, end stations, or a combination of the two. This might be useful in identifying riding habits of casual vs. annual membership riders (i.e., do annual members typically start & end at stations?).  

5. Next, I began manipulating this data to in order to analyze new metrics: 
	5.1. I added "ride_length" by subtracting "started_at" from "ended_at"
	5.2. Added "day_of_week" column
	5.3. Added "month" column
	5.4. Added "time_of_use" column
	5.5. Finally, calculated "distance_in_mi" using the Halversine formula:
		5.5.1. created "helper columns" to find the radians of each coordnite (=I2 * PI() / 180 , =K2 * PI() / 180 , =J2 * PI() / 180 , =L2 * PI() / 180)
		5.5.2. Next, used the Halversine formula to calculate distance in miles [=3958.8 * ACOS(COS(R2) * COS(S2) * COS(T2 - U2) + SIN(R2) * SIN(S2))]
		5.5.3. Then formated the distance to 2 decimal places. 
		5.5.4. Finally, I copied the final values only, and deleted the helper columns 
		--Disclaimer, I had around 8,000 produce zero, but after checking multiple values I decided to keep my formula but notate.

6. After cleaning & manipulation, data was exported to .csv:

	 --- 2022.Bikeshare.Data_totals.csv

----------
Posit (RStudio)
----------

After reviewing and brainstorming the original dataset, then manipulating to have actionable columns within Excel I began developing questions that I could answer with this dataset; How are Casual vs. Membership riders different?:



1. Number of rides for users overall; casual vs. member? 
	1.1. By day of the week?
	1.2. By month?

2. Busiest time/total rides per hour of use by user type?

3. What are the preffered bike types of each rider type?

4. What are the top 3 start stations by user?
	4.1. Top 3 end stations? 

5. Average ride length of each rider type?

6. Average distance by user type?

7. Average speed by user?


From here on out, check out the additional contents of this repository for the following:

	- R scripts for cleaning, manipulating & analyzation.

	- R scripts for visualizations used in the final presentation.

	- Final presentation, with summarized findings & action items. 



Thanks for reading!
 
	- Ryan
