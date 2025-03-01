# Hospital-Mortality-Data-Analysis---SQL

**Technologies Utilized**: Excel, MySQL, Tableau

[Dataset Access](https://www.kaggle.com/datasets/mitishaagarwal/patient)

[SQL Analysis Code](https://github.com/SharifAthar/Hospital-Mortality-Prediction-SQL/blob/main/Hospital_Mortality_SQL_Analysis.sql)

[Tableau Dashboard for Hospital Mortality](https://public.tableau.com/app/profile/sharif.athar/viz/HospitalMortalityDashboard/Dashboard1)

# <p align="center">Hospital Mortality Analysis Initiative</p>

- **Problem Statement:** Healthcare practitioners are focused on pinpointing the primary factors leading to in-hospital mortality among patients. Gaining insights into these causes early on enables healthcare providers to formulate targeted interventions and apply evidence-based protocols to mitigate the elements contributing to patient deaths during hospitalization.

- **My Methodology for Addressing the Issue:** To address the challenge of identifying key factors associated with in-hospital mortality, I conducted a thorough analysis using SQL and Tableau. My process began with acquiring the dataset, followed by importing it into Excel for data cleaning. Subsequently, I transferred the cleaned data to MySQL, where I executed insightful queries to extract meaningful information. Through my SQL analysis, I examined various patient characteristics, including age, ethnicity, gender, weight, BMI, heart rate, and comorbidities. The queries revealed significant patterns, trends, and correlations within the dataset. To effectively communicate my findings, I created an interactive dashboard in Tableau that visually represented the key insights derived from my SQL analysis, highlighting trends related to in-hospital mortality.

- **Key Insights Obtained:** Below are the results from the SQL queries I performed, along with interpretations of the observed patterns and trends.

1: 

![Query1](https://i.ibb.co/SV4r1Rt/Screen-Shot-2023-06-29-at-4-52-19-PM.png)

Among the 10,000 patients admitted to the hospital, 634 patients succumbed, resulting in a mortality rate of 6.34%. This underscores the critical need to understand the factors contributing to in-hospital mortality to enhance patient care and minimize preventable fatalities.

2:

![Query2](https://i.ibb.co/XC5qXg8/Screen-Shot-2023-06-29-at-7-44-37-PM.png)

This output illustrates the number of patients who died versus those who survived across different age groups, categorized in 10-year intervals. A significantly higher number of patients were admitted in the 50-89 age range compared to those aged 0-49. Notably, patients aged 0-9 exhibited the highest mortality percentage, with a gradual increase in death rates observed in each subsequent 10-year age group within the 50-89 range. Alarmingly, nearly 1 in 6 patients aged 70-89 did not survive their hospital stay.

3:

![Query3](https://i.ibb.co/MnB3M5L/Screen-Shot-2023-06-29-at-7-56-52-PM.png)

This output further corroborates the trend that the likelihood of mortality increases with age.

4:

![Q4](https://i.ibb.co/54ZBMBH/Screen-Shot-2023-06-29-at-8-08-53-PM.png)

![Q5](https://i.ibb.co/mJB1cxY/Screen-Shot-2023-06-29-at-8-09-28-PM.png)

These two outputs provide additional insights into patient outcomes based on ICU admission sources and types. A significant majority of patients were admitted through the "Accident & Emergency" ICU source, which also recorded the highest number of deaths. However, the "Floor" ICU source had the highest mortality probability at 11.76%. The "Other ICU" category was excluded due to its minimal sample size.

In the second output, which details death outcomes by ICU type, a notable outlier is the Med-Surg ICU.

5: 

![Q6](https://i.ibb.co/5cCNgyW/Screen-Shot-2023-06-29-at-8-32-29-PM.png)

This output presents the average weight, BMI, and maximum heart rate of deceased patients. 

The average weight of 67.57 kg (149 lbs) indicates that, on average, patients who passed away had a moderate weight. The average BMI of 23.3 suggests that these patients generally fell within the normal BMI range. This implies that weight alone may not be a definitive factor in mortality, as individuals with normal BMI can still face significant health risks leading to hospital deaths. The average maximum heart rate of 115.1 points to potential cardiovascular issues among these patients. Elevated heart rates can signify underlying conditions, such as cardiac distress or organ failure, which may have contributed to the observed mortality rates ([source](https://www.mayoclinic.org/diseases-conditions/tachycardia/symptoms-causes/syc-20355127)).

6: 

![Q7](https://i.ibb.co/GHb3dnT/Screen-Shot-2023-06-29-at-8-48-21-PM.png)

The dataset included 8 comorbidities, with the three highlighted (Diabetes, Immunosuppression, and Solid Tumor) showing the highest mortality probabilities, particularly diabetes, which had the most significant impact. This emphasizes the necessity of effectively managing and monitoring diabetes during hospitalization.

7: 

![Q8](https://i.ibb.co/Tkc9RVr/Screen-Shot-2023-07-01-at-2-56-23-PM.png)

As indicated by this output, extended ICU stays correlate with increased mortality rates ([source](https://pubmed.ncbi.nlm.nih.gov/26571190/#:~:text=One%2Dyear%20mortality%20was%2026.6,the%20need%20for%20mechanical%20ventilation.)). Prolonged ICU stays can arise from various factors, including cardiovascular diseases, nervous system disorders, infections, and underlying health issues, which increase the risk of complications ([source](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5884409/#:~:text=Our%20study%20showed%20a%20significantly,the%20length%20of%20stay%20increases.)). The data suggests that patients who spent more than a day in the ICU had a higher mortality risk compared to those who were there for less than a day.

- **Conclusion:** Age emerged as a significant predictor of in-hospital mortality within this dataset. Consistently, older age has been linked to higher rates of medical conditions, complications, and mortality. The dataset revealed that nearly 20% of patients aged 70 and above experienced in-hospital mortality, highlighting the critical influence of age on mortality risk. Comorbidities also played a crucial role, with diabetes being the most significant, exhibiting a mortality rate of 24.45% among affected patients. Heart rate is another important indicator, reflecting cardiovascular health and overall stability. Abnormal heart rates, such as tachycardia or bradycardia, often signal underlying cardiovascular issues ([source](https://www.mayoclinic.org/diseases-conditions/tachycardia/symptoms-causes/syc-20355127)). The average maximum heart rate for deceased patients was 115.1, with a resting heart rate over 100 bpm considered high ([source](https://www.healthline.com/health/dangerous-heart-rate)). Additionally, the length of ICU stay was a vital mortality indicator, with shorter stays correlating with better survival rates.

- **Future Directions/Recommendations:** While the dataset provided valuable predictors for in-hospital mortality, it lacked several critical factors that could influence patient outcomes. For instance, it did not include specific treatment details, vital signs, medications, surgeries, or interventions that could significantly impact mortality. Socioeconomic factors, known to affect healthcare access and quality, were also absent. Furthermore, psychosocial elements, such as mental health conditions and social support, were not captured, despite their established links to mortality. Future research should aim to incorporate these additional variables to achieve a more comprehensive understanding of in-hospital mortality and the factors that influence patient outcomes.
