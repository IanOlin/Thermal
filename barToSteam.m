function res = barToSteam(heat, steamEnergy, massSteam, params)%current heat of bar, steam temp, non ode runnable
    transferCoefficient = parmas(13); %this is shit
    specificHeatBar = params(7) ; %specific heat in joules per kg kelvin
    specificHeatSteam = params(6);%%specific heat in joules per kg kelvin
    massBar = params(14); %mass
    surfaceAreaBar = params(4);    
        deltaTemperature = energyToTemperature(heat, massBar, specificHeatBar) -energyToTemperature(steamEnergy, massSteam, specificHeatSteam);
        
        conductionFlow = transferCoefficient * surfaceAreaBar * deltaTemperature;%flow of heat
        
        res = conductionFlow;
end
    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    