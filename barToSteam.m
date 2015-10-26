function shit = barToSteam(heat, steamTemp)%current heat of bar, steam temp, non ode runnable
    transferCoefficient = 50; %this is shit
    specificHeatBar = 475 ; %specific heat in joules per kg kelvin
    densityBar = 7850;
    lengthBar = .05 ;%length of bar in meters
    diameterBar = .04 ;%length of side of bar in meters
    volumeBar = pi*(diameterBar/2)^2*lengthBar; %volume
    massBar = densityBar * volumeBar; %mass
%     steamThickness = .01; %thickness of steam, 1cm
%     initialRoomTemperature = 290; % room temp
     surfaceAreaBar = pi * diameterBar * lengthBar + pi * (diameterBar/2)^2;    
        deltaTemperature = energyToTemperature(heat, massBar, specificHeatBar) -steamTemp;
        
        conductionFlow = transferCoefficient * surfaceAreaBar * deltaTemperature;%flow of heat
        
        shit = conductionFlow;
end
    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    