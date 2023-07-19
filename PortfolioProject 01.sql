Select *
from PortfolioProject..CovidDeaths
Where continent is not NULL
order by 3,4

--Select *
--from PortfolioProject..CovidVaccinations
--order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
Where continent is not NULL
order by 1,2

--Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentaga
from PortfolioProject..CovidDeaths
Where location like '%Ukraine%'
order by 1,2

--Looking at Total Cases vs Population
--Shows what percentage of population got covid

Select Location, date, population, total_cases, (total_cases/population)*100 as PopulationPercentagaInfected
from PortfolioProject..CovidDeaths
Where location like '%Ukraine%'
order by 1,2

--Loooking at Counties with Higest Infection Rate compared to Population

Select Location, population, MAX(total_cases) as HigestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc

--Showing Countiest with Highest Death Count per Population

Select Location, MAX(CAST(total_deaths as int)) as TotalDeathsCount
from PortfolioProject..CovidDeaths
Where continent is not NULL
Group by Location
order by TotalDeathsCount  desc

--LET'S BREAK THINGS DOWN BY CONTINENT

Select continent, MAX(CAST(total_deaths as int)) as TotalDeathsCount
from PortfolioProject..CovidDeaths
Where continent is not  NULL
Group by continent
order by TotalDeathsCount  desc

--location but, continent

Select location, MAX(CAST(total_deaths as int)) as TotalDeathsCount
from PortfolioProject..CovidDeaths
Where continent is  NULL
Group by location
order by TotalDeathsCount  desc

--Showing continents with the highest death count per population

Select continent, MAX(CAST(total_deaths as int)) as TotalDeathsCount
from PortfolioProject..CovidDeaths
Where continent is not  NULL
Group by continent
order by TotalDeathsCount  desc

-- Global Numbers

Select   SUM(new_cases)as totalCases, SUM(CAST(new_deaths as int)) as totalDeaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as DeathPercentaga
from PortfolioProject..CovidDeaths
--Where location like '%Ukraine%'
Where continent is not NULL
--Group by date
order by 1,2




--Looking at toyal Population vs Vaccinations



Select dea.continent, dea.date, dea.location, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by  dea.Location order by dea.location, 
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not NULL
	order by 2,3

--USE CTE

with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
	(
	Select dea.continent, dea.date, dea.location, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by  dea.Location order by dea.location, 
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not NULL
	--order by 2,3
)
Select *, (RollingPeopleVaccinated/population)*100
From PopvsVac

--TEMP TABLE

Drop Table if exists #PercentPopulationVaccinated
Create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccination numeric,
RollingPeopleVaccinated numeric
)


Insert into #PercentPopulationVaccinated
Select dea.continent,  dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by  dea.Location order by dea.location, 
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not NULL
	--order by 2,3

	Select *, (RollingPeopleVaccinated/population)*100
From #PercentPopulationVaccinated



--Crating View to store data for visualisations 

Create View PercentPopulationVaccinated as 
Select dea.continent,  dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by  dea.Location order by dea.location, 
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not NULL
	--order by 2,3

	Select * From PercentPopulationVaccinated