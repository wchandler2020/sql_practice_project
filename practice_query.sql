--SELECT *
--FROM [PortfolioProject].[dbo].[CovidDeaths]
--WHERE continent is not null
--ORDER BY 3, 4;

--SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths AS int))/SUM(new_cases) * 100 as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--WHERE continent IS NOT NULL
--ORDER BY 1, 2;

-- select the data we are going to be using

--SELECT location, date, total_cases, new_cases, total_deaths, population
--FROM PortfolioProject..CovidDeaths
--ORDER BY 1, 2;

-- looking at total cases vs total deaths

--SELECT location, date, total_deaths, total_cases, CONVERT(float, total_deaths)/NULLIF(CONVERT(float, total_cases),0) as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--WHERE location = 'United States'
--ORDER BY 2, 1;

-- looking at total cases vs population
--SELECT location, date, total_deaths, total_cases, population, CONVERT(float, total_cases)/NULLIF(CONVERT(float, population),0) as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--WHERE location = 'United States'
--ORDER BY date DESC;

-- LOOKING AT COUNTRIES WITH THE HIGHEST INFECTION RATE COMPARED TO THE POPULATION.

--SELECT location, MAX(total_deaths) AS HighestFinfectionRate, MAX(CONVERT(float, total_cases)/NULLIF(CONVERT(float, population),0)) as PercentagePopulationInfected
--FROM PortfolioProject..CovidDeaths
--GROUP BY location, population
--ORDER BY PercentagePopulationInfected;

--Showing countries with the highest death count per population
--SELECT location, MAX(total_deaths) AS TotalDeathCount
--FROM PortfolioProject..CovidDeaths
--WHERE continent is not null
--GROUP BY location
--ORDER BY TotalDeathCount desc;

--BREAKING IT DOWN BY CONTINENT
--SELECT location, MAX(total_deaths) AS TotalDeathCount
--FROM PortfolioProject..CovidDeaths
--WHERE continent is null
--GROUP BY location
--ORDER BY TotalDeathCount desc;

--GLOBAL DATA
--SELECT SUM(new_cases) as TotalCases, SUM(convert(float, new_deaths)) as TotalDeaths, SUM(convert(float, new_deaths))/SUM(new_cases) * 100 as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--WHERE continent is not null
--ORDER BY 1, 2;

-- Total Population vs Vaccinations
--SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
--SUM(CONVERT(INT, cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY 
--cd.location, cd.date) as RollingPeopleVaccinated
--FROM PortfolioProject..CovidDeaths as cd
--JOIN PortfolioProject..CovidVaccinations as cv
--ON cd.location = cv.location and cd.date = cv.date
--WHERE cd.continent is not null 
--ORDER BY 2, 3

--USE CTE

--WITH PopVSVac(continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
--as (
	--SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
	--SUM(CONVERT(float, cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY 
	--cd.location, cd.date) as RollingPeopleVaccinated
	--FROM PortfolioProject..CovidDeaths as cd
	--JOIN PortfolioProject..CovidVaccinations as cv
	--ON cd.location = cv.location and cd.date = cv.date
	--WHERE cd.continent is not null 
	--ORDER BY 2, 3
--)

--select *, (RollingPeopleVaccinated/population) * 100
--from PopVSVac;

-- CREATE VIEW TO STORE DATA FOR LATER VISUALATIONS.

--CREATE VIEW PercentPopulationVaccinated AS
--SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
	--SUM(CONVERT(float, cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY 
	--cd.location, cd.date) as RollingPeopleVaccinated
	--FROM PortfolioProject..CovidDeaths as cd
	--JOIN PortfolioProject..CovidVaccinations as cv
	--ON cd.location = cv.location and cd.date = cv.date
	--WHERE cd.continent is not null 
	--ORDER BY 2, 3

--SELECT * FROM PercentPopulationVaccinated;

--SELECT * 
--FROM PortfolioProject..CovidDeaths as cd
--JOIN PortfolioProject..CovidVaccinations as cv
--ON cd.location = cv.location 
--AND
--cd.date = cv.date;
