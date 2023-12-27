# A Network Design Approach for Citizen Science-Satellite Monitoring of Surface Water Volume Changes in Bangladesh

## Abstract: 
In the face of globally prevalent water management issues, particularly in regions with water scarcity or inefficient management strategies, improved monitoring of water resources is critical. This study introduces a reproducible, integrated framework for gauge network design for tracking surface water availability in a citizen science framework. This framework is developed by drawing on an existing network of citizen-science and satellite-derived observations of water data in Bangladesh, a country with a substantial density of lake and wetland gauges monitored by citizen scientists. The primary goal of developing the framework is to identify the sensitivity of gauge density and their optimal location to most effectively capture surface water storage variations. The proposed approach incorporates hydro-physical variables such as temperature, precipitation, and terrain roughness, with the flexibility to include additional determinants like population density and socio-economic factors. To further improve waterbody representation, the study introduces two methods for fitting the Area-Volume Curve - the Robust Curve and Hydrologic Parameter Derived (HyPD) methods. For identifying optimal number and location of gauges, the framework uses Monte Carlo simulations. With randomized selection of gauges from the existing high-density network, the framework does not impose a single optimal solution but rather provides a range of optimal solutions, allowing water managers the freedom to select the number of gauges and locations in accordance with their specific needs. Strategic or optimal gauge installation sites are identified through a probabilistic plot, generated using random forest classification. Using the methodology, the study revealed how strategic placement of gauges can potentially improve the estimation of surface water storage variations. For example, the northeastern region of Bangladesh, given a highest density of water bodies, was found to require three times the gauge density that is optimum for the northwestern region having the lowest density of water bodies. The study findings can be used to enhance the validation of lake products derived from missions such as the Surface Water and Ocean Topography (SWOT). This research is expected to pave the way for more efficient global surface water tracking strategies, empowering water managers with enhanced decision making tools.

## Methodology:
![Flowchart](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/assets/87221496/3d590cf8-c050-439b-987a-2c6687a1fb30)

<!--![Flow Chart](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/assets/87221496/3639d305-f918-4bd8-a65d-491df176f2ed)-->

The framework incorporates the following necessary steps:  
**Step 1:** The identification of hydro-physical regimes is the first step. This is conducted based on climatology of precipitation and temperature, terrain roughness, and the density of water bodies present within a specific region.  
**Step 2:** Estimation of the volume of surface water that is stored in gauged water bodies using the ensemble technique.  
**Step 3:** Generation of Area-Volume Curve for each hydro-physical regime, which allows estimation of total water storage across all water bodies. This is achieved by using the highest density of gauges. A Regression Line is then fitted to the Area-Volume (A-V) Curves, using the Robust Curve Approach, Hydrological Parameters Derived Approach, and Hybrid of the two approaches.  
**Step 4:** Repetition of steps from 1 to 3, with systematically degraded gauge density based on randomized selection of gauges per the Monte-Carlo simulations. This step is a sensitivity study to understand how gauge density (adding or removing gauges) responds to the estimation of volume changes.  
**Step 5:** Development of the relationship between the gauge density and uncertainty (or percent error), treating the results from the highest density as the benchmark. This step provides the summary of the sensitivity of gauge density relative to the maximum density that is available.  
**Step 6:** Development of criterion for the strategic placement of gauges. This is derived from a ‘degraded’ density and expected uncertainty as a function of hydro-physical similarity in surface water variability. 

## How To Use The Codes:  
Implement the scripts in the following order, and please cite the paper **"A Network Design Approach for Citizen Science-Satellite Monitoring of Surface Water Volume Changes in Bangladesh"** if you have used any part of the code. If there are any typos please let me know.   
  
**Downloading and Processing the ERA 5 Reanalysis Data:** Use the script [_Download_Precipitation_Data.ipynb_](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/Download_Precipitation_Data.ipynb) to download the ERA5 Reanalysis Precipitation Data. The script was built to download the past 30 years of data from 2022. However, with slight modifications on the _years_ list, the user can download any number of years of data available on the ERA 5 platform. Similarly, by using [_Download_Temperature_Data.ipynb_](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/Download_Temperature_Data.ipynb), users can download the ERA 5 Temperature Data.  

**Estimating Water Surface Area Using the Imagery:** To estimate the water surface area of all the waterbodies present in the regions, we have used the Sentinel 1 Satellite. To distinguish the lakes and wetlands from rivers, count the water bodies, and estimate their areas, the Connected Component Analysis of Haors is implemented [(Ahmed et al.)](https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2020WR027989). The code of this approach can be found in [_Process_Water_Bodies_Imagery.m_](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/Process_Water_Bodies_Imagery.m) MATLAB script.    

**Estimating Water Surface Area of the Gauged Bodies:** To estimate the water surface area of all the gauged bodies, we have implemented an ensemble approach as mentioned in [Khan et al.](https://doi.org/10.1109/JSTARS.2023.3250354). The code for estimating the water surface area through multiple techniques can be found in [Estimating_Water_Surface_Area.ipynb](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/Estimating_Water_Surface_Area.ipynb).  

**Estimating Volume of Water Storage and Creating Ensemble of Volume:** To estimate the storage change and create the ensemble of volume stored, use [Estimating_Volume_Part1.ipynb](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/Estimating_Volume_Part1.ipynb) and [Estimating_Volume_Part2.ipynb](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/Estimating_Volume_Part2.ipynb). In ensemble, users can drop any particular volume estimates obtained by a particular water classification technique.  

**Area - Volume Curve Fitting:** To fit the Area - Volume Curve, we have developed two methods, namely - [Robust Curve Approach](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/Robust_AV_Curve.ipynb) and [Hydrological Parameter Derived Curve Approach (HyPD)](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/HyPD_Curve_Fitting.ipynb). The assumptions made in the model are described in detail in the paper.  

**Hybrid Curve Fitting and Monte Carlo Simulations:** [Hybrid_Curve_and_Monte_Carlo_Simulations.ipynb](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/Hybrid_Curve_and_Monte_Carlo_Simulations.ipynb) incorporates the Hybrid Curve Fitting and performs Monte Carlo Simulations on all the gauges.  

**Generating Monte-Carlo Plots:** To generate the Monte-Carlo plots, please use the [Monte_Carlo_Plots.ipynb](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/Monte_Carlo_Plots.ipynb) script. The Monte-Carlo simulations are capped at 20000 simulations with each gauge, so if a user has _'N'_ gauges there will be _20000xN_ simulations. To understand the capping, please read the section 4.4 of the paper.  

**Doing Sensitivity Analysis:** To perform the sensitivity analysis, please use the script [Sensitivity_Analysis.ipynb](https://github.com/shahzaib1007/Network-Sampling-of-Gauges/blob/main/Sensitivity_Analysis.ipynb). The sensitivity analysis gives the list of the most impactful gauges. Clubbing the impactful and non-impactful gauge locations with the hydrological parameters (precipitation, temperature, and terrain roughness) gives us an idea of the impactful and non-impactful locations.  










## Key Lessons:  
_**Lesson 1:**_	We designed a scalable, integrated optimum gauge network framework that can adequately represent a region, utilizing both citizen-science and satellite-derived datasets. The framework can accommodate any form of water elevation data, not limited to those recorded by citizen scientists. Bangladesh was selected as the test case for applying this framework due to high density of gauge networks.  

_**Lesson 2:**_	Temperature, precipitation, and terrain roughness, were incorporated to estimate the optimal number of gauges for adequate regional representation. The approach remains flexible, and can be extended to consider other factors like snowmelt, streamflow, population density, infrastructure development, and other physical and socio-economic determinants. Regimes were created using the hydro-physical factors, and the understanding of regime can be extended to new regions planning to install gauges.  

**Lesson 3:**	Based on the relation area-volume, we applied two approaches, the Robust Curve and Hydrologic Parameter Derived (HyPD) methods, for fitting the Area-Volume Curve. The hydrologic community can select either curve or both based on their judgement of the region to fit Area-Volume data points.  

_**Lesson 4:**_	The benchmark volume in each regime was estimated, which allows water managers worldwide to use this framework for understanding the total volume of surface water stored in their respective countries - a crucial aspect of water management and resource placement.  

_**Lesson 5:**_	The framework of optimum number of gauges does not provide a single solution but a range of optimal solutions, leaving the ultimate decision on network adequacy to water managers.  

_**Lesson 6:**_	The probabilistic plot identifies numerous locations where gauge installation would yield the maximum return on investment. Water managers can couple this plot with other factors such as population density maps to choose gauge installation sites that maximize return on investment and foster local understanding of lake and wetland behavior. This could initiate data collection through citizen science in the region.  

_**Lesson 7:**_	The techniques and results developed in this study, such as the area-volume curve fitting and benchmark volume estimation, can be potentially utilized to assess the SWOT lake products regionally. While SWOT provides water surface area and elevation data, integrating it with proposed curve fitting techniques and volume estimation using citizen science-based gauges can allow for higher frequency volume storage estimations for small lakes and wetlands.  

