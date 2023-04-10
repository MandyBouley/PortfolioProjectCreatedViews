Create view CountriesInfectionRateComparedToPopulation as
select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
group by Location, population
--order by PercentPopulationInfected desc


Create View CountriesWithHighestDeathCount as
select Location, MAX(Total_Deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by Location
--order by TotalDeathCount desc

Create View ContinentsWithHighestDeathCount as
select continent, MAX(Total_Deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent

Create View ContinentsWithHighestDeathCountPerPopulation as
select continent, MAX(Total_Deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
--order by TotalDeathCount desc

Create View GlobalNumbers as
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
--order by 1,2

Create View TotalPopulationVsVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
