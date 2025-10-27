# Using 911 Data to Understand Police Deployment

By [Alex Chohlas-Wood](alexchohlaswood.com) and [John Hall](https://x.com/jjhall_77)

This January, in response to [widespread concerns](https://www.vitalcitynyc.org/articles/what-to-do-about-subway-safety-nyc-policy-recommendations) about safety on the New York City subway, the New York City Police Department (NYPD) [made a new promise](https://ny1.com/nyc/all-boroughs/news/2025/01/16/nypd-to-deploy-1-050-more-officers-into-subway-stations--hochul-says): the city would add hundreds of officers to patrol the city's subways, including two officers for each of the city's 150 late-night subway trains that run between 9pm and 5am.

How can we know if the city kept its promise? 
You might think that we'd need to file a public records request with the NYPD, e.g., to get data on every officer that worked a late-night shift in a transit precinct. 
But it turns out that the NYPD already publishes the data we need to understand highly granular patrol activity. 
It's the city's "Calls for Service"—i.e., 911—dataset.

It might seem counterintuitive that a 911 dataset would include information on where officers are deployed. 
But when you dial 911, the call is typically routed to a calltaker, who takes your information and then passes it off to a dispatcher. 
Dispatchers have a tough job: they have to keep track of the current location for dozens of officers, so that they can find nearby officers for a new call—especially if it's urgent. 
To help dispatchers keep track of where they are, officers will routinely and proactively check-in with their dispatcher via their radio with their location and an update on their current status. 
Alongside 911 calls from the public, 
these check-ins are recorded as "calls" in the city's calls for service (CFS) database,
and are the key to understanding and analyzing officer deployment.

### About NYC's CFS data

CFS data is available to download from the New York City Open Data portal. 
The data is posted in two parts. 
The first is a dataset of [historic CFS](https://data.cityofnewyork.us/Public-Safety/NYPD-Calls-for-Service-Historic-/d6zx-ckhd/about_data) from 2018 to the end of last year. 
The second dataset contains [year-to-date CFS](https://data.cityofnewyork.us/Public-Safety/NYPD-Calls-for-Service-Year-to-Date-/n2zq-pubd/about_data), updated roughly every quarter. 
As of this blog post, the year-to-date data contains records up through the end of June 2025. 
Altogether, there are over 51 million records in the combined data, underscoring the potential to use these datasets for precise statistical analysis.

NYPD's CFS dataset includes a wealth of information: 
location information, including the precinct, borough, patrol borough, and the latitude/longitude where the call took place; 
timestamp information, including the time and date of the underlying incident (e.g., in the event of a call from the public), as well as timestamps for when the call was added to the database, when an officer was dispatched, when they arrived at the scene, and when they closed out the call;
and information on the type of call, including 
the "radio code"—a 2–3 character code that officers say on the radio to indicate what they're doing; 
and a corresponding description for the radio code. These codes can be quite cryptic—e.g., "75M" means that officers are initiating patrol of a subway train—so we found a training guide for new officers that includes detailed descriptions of the codes, and [posted it](https://github.com/chohlasa/asa-911-blog-post/blob/main/docs/NYPD%20Police%20Student%20Guide%20(December%202020-February%202021).pdf) in our GitHub repository.

### Assessing deployment changes on the subway

To understand whether the city really did add officers to patrol trains overnight, we examined the number of calls where officers checked in between 9pm and 5am with radio code "75M". 
We compared the number of late-night "75M" check-ins before and after the policy announcement in January of 2025 (Figure 1).

<img src="src/train_patrols.png"
data-fig-alt="A line graph showing the number of 75M late-night subway train patrol check-ins, by month, from September 2019 through June 2025. A vertical dashed line indicates the policy announcement, which occurred in January 2025. A red horizontal line represents the average number of late-night subway train patrol check-ins per month from September 2019 through January 2025, and again from February 2025 through June 2025, with a 95% CI around the average monthly call volume in gray. The post-announcement average is over 15,000 75M check-ins per month, where the pre-announcement average is a little under 7,500 75M check-ins per month, suggesting the policy change was implemented as promised. " />
**Figure 1.** *Number of 75M late-night subway train patrol check-ins, by month, from September 2019 through June 2025. The vertical dashed line indicates the city's announcement that they would ensure two police officers on every overnight train. The red horizontal line represents the average number of late-night subway train patrol check-ins per month from September 2019 through January 2025, and again from February 2025 through June 2025, with a 95% CI around the average monthly call volume in gray.*

Between Feburary 2025 and June 2025, there were over 15,000 75M check-ins per month—more than twice as many 75M check-ins per month as the average from September 2019 through January 2025.
This change suggests the policy change was implemented as promised,
bringing some degree of comfort to late-night subway riders.


### Takeaways

We've barely scratched the surface of what one could analyze with CFS data.
For example, researchers could make use of the detailed latitude and longitude information in CFS data
to understand how police-initiated patrols differ across neighborhoods in New York City.
Many major American cities, including 
[Austin](https://data.austintexas.gov/Public-Safety/APD-911-Calls-for-Service-2019-2024/e687-fx2y/about_data),
[Baltimore](https://data.baltimorecity.gov/datasets/baltimore::911-calls-for-services-2025),
[Detroit](https://data.detroitmi.gov/datasets/5868975fa1e7444cae8ca5240fc77c5b_0),
[Los Angeles](https://data.lacity.org/Public-Safety/LAPD-Calls-for-Service-2024-to-Present/xjgu-z4ju/about_data),
[Miami](https://www.miami-police.org/Records-Calls-For-Service.html),
[New Orleans](https://data.nola.gov/Public-Safety-and-Preparedness/Calls-for-Service-2025/4xwx-sfte/about_data), 
[Phoenix](https://www.phoenixopendata.com/dataset/calls-for-service),
[Pittsburgh](https://data.wprdc.org/dataset/allegheny-county-911-dispatches-ems-and-fire),
[San Antonio](https://webapp3.sanantonio.gov/policecalls/Default.aspx),
[San Diego](https://data.sandiego.gov/datasets/police-calls-for-service),
[San Francisco](https://data.sfgov.org/Public-Safety/Law-Enforcement-Dispatched-Calls-for-Service-Real-/gnap-fj3t/about_data), 
[Seattle](https://data.seattle.gov/Public-Safety/Call-Data/33kz-ixgy/about_data), 
and
[Tempe, AZ](https://data.tempe.gov/maps/tempegov::police-transparency-calls-for-service-all-data-dataset/about), 
make their own version of CFS data available online.
These datasets provide a valuable resource for researchers, journalists, and the public to analyze police deployment patterns and better understand the behavior of their local law enforcement agency. 
By examining these datasets, we can gain insights into how police resources are allocated and whether public safety initiatives are being effectively implemented.