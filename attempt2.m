function shit = attempt2



    finalTime = 5000;
    
    T = zeros(1, finalTime);
    liquidTemps = zeros(1, finalTime);
    barTemps = zeros(1, finalTime);
    liquidMasses = zeros(1, finalTime);
    
    %%mug
    diameterCider = 8/100; %meters
    heatOfVaporization = 2256*10^3; %J/kG
    heightCider = 10/100; 
    mugThickness = 7/100;
    thermalConductivityMug =1.5;
    
    
    %%bar
    specificHeatBar = 475 ; %specific heat in joules per kg kelvin
    densityBar = 7850; %density in kg per meter cubed
    lengthBar = 5/100 ;%length of bar in meters
    diameterBar = 4/100 ;%length of side of bar in meters
    volumeBar = pi*(diameterBar/2)^2*lengthBar; %volume
    surfaceAreaBar = pi * diameterBar * lengthBar + pi * (diameterBar/2)^2;
    barMass = densityBar * volumeBar;
    barTemp = 1500;
    barEnergy = temperatureToEnergy(barTemp, barMass, specificHeatBar);
    
    %%steam
    thicknessSteam = 1/100;
    steamSA = (lengthBar + thicknessSteam) * (pi * (diameterBar + 2 * thicknessSteam)) + 2 * pi * (diameterBar/2 + thicknessSteam)^2;
    densityOfSteam = 0.590; %kg/m^3
    volumeSteam = steamSA * thicknessSteam;
    
    %%liquid
    liquidDensity = 1000;
    specificHeatLiquid = 4186;
    liquidTemp = 290;
    liquidVolume = (pi * (diameterCider/2)^2) * heightCider - (volumeBar + volumeSteam);
    liquidMass = liquidVolume * liquidDensity;
    liquidEnergy = temperatureToEnergy(liquidTemp, liquidMass, specificHeatLiquid);
    
    
    
    %%radiation, bar to liquid
    emissivityCoefficient = .25; %lol magic space rays
    thermalConductivitySteam = .00185;
    
    airSA = (.04^2 * pi) - (.02^2 * pi);
    mugSA = .08 * pi + (pi * .04^2);
    
    barTemp = 0;
    liquidTemp = 0;
    
    for n = 1:finalTime
        barTemp = energyToTemperature(barEnergy, barMass, specificHeatBar);
        liquidTemp = energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
        
        thermalHeatCoefficient = 10;
        conductionLHL = thermalConductivityMug * mugSA * (liquidTemp - 290) / mugThickness;
        convectionLHL = thermalHeatCoefficient * airSA * (liquidTemp - 290);
        
        deltaT = barTemp - liquidTemp;
        conductionBTL = thermalConductivitySteam * steamSA * deltaT / thicknessSteam;

        deltaRT = barTemp^4 - liquidTemp^4;
        radiation = emissivityCoefficient * 5.67 * 10^(-8) * deltaRT * steamSA * .9;
        
        deltaEnergy = liquidEnergy - temperatureToEnergy(373, liquidMass, specificHeatLiquid);
        massEnergy = 0;
        massChange = 0;
        if(deltaEnergy > 0)
            massEnergy = deltaEnergy;
            massChange = deltaEnergy / heatOfVaporization;
        end
        
        conductionLHL = 0;%fuck this
        energyFlowLiquid = conductionBTL + radiation - conductionLHL - convectionLHL - massEnergy;
        energyFlowBar = conductionBTL + radiation / .9;
        

        liquidEnergy = liquidEnergy + energyFlowLiquid;
        barEnergy = barEnergy - energyFlowBar;
        liquidMass = liquidMass - massChange;
        
        T(n) = n;
        liquidTemps(n) = energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
        barTemps(n) = energyToTemperature(barEnergy, barMass, specificHeatBar);
        liquidMasses(n) = liquidMass;
        
%         if(barTemp < 480)
%             break;
%         end
        
%         display(massEnergy);
    end
    
    hold on;
    plot(T, liquidTemps);
    plot(T, barTemps);
    title('Temperature Over Time');
    xlabel('Time(seconds)');
    ylabel('Temperature(K)');
    legend('Cider', 'Iron Bar');
    figure
    plot(T, liquidMasses);
    title('Cider Mass Over Time');
    xlabel('Time(seconds)');
    ylabel('Mass(kg)');
end
function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end

    function res = temperatureToEnergy( T, m, c)
        res = T * heatCapacity(m,c);
    end

    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end