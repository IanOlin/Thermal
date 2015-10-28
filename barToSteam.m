function res = barToSteam(~, params)%current heat of bar, steam temp, non ode runnable
    params = params.';
    transferCoefficient = params(13); %this is shit
    specificHeatBar = params(7) ; %specific heat in joules per kg kelvin
    specificHeatSteam = params(6);%%specific heat in joules per kg kelvin
    massBar = params(14); %mass
    surfaceAreaBar = params(4);   
    heatBar = params(21);
    steamEnergy = params(17);
    massSteam = params(16);
    deltaTemperature = energyToTemperature(heatBar, massBar, specificHeatBar) -energyToTemperature(steamEnergy, massSteam, specificHeatSteam);
    conductionFlow = transferCoefficient * surfaceAreaBar * deltaTemperature;%flow of heat
    newParams = zeros(1, length(params));
    newParams(21) = -conductionFlow;
    newParams(17) = conductionFlow;
    res = newParams.';
end
    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    