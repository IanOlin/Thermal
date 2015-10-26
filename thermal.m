function thermal()  
        %shitload of variables for bar
    %type of iron is 5160 medium carbon steel (.55-.65% carbon)
    %http://www.matweb.com/search/datasheet.aspx?MatGUID=972ec49b746d47c2a31db406e9213247
    %http://www.wolframalpha.com/input/?i=5160+steel
    %TI = 2200
        %% iron bar
    specificHeatBar = 475 ; %specific heat in joules per kg kelvin
    densityBar = 7850; %density in kg per meter cubed
    %thermalConductivityBar = 46.6;% Thermal conductivity watts/meter kelvin
    
        %% size in contact with liquid
    lengthBar = .05 ;%length of bar in meters
    diameterBar = .04 ;%length of side of bar in meters
    volumeBar = pi*(diameterBar/2)^2*lengthBar; %volume
    
        %% size of mug
    diameterCider = 8/100; %meters
    heatOfVaporization = 2257000 %J/kG
    heightCider = 10/100; 
    thicknessMug = 0.7/100;
    
    %steam surface area
    steamThickness = .01;
    steamSA = (lengthBar + 2 * steamThickness) * (pi * (diamaterBar + 2 * steamThickness)) + 2 * pi * (diamaterBar/2 + steamThickness)^2;
    %steam heat transfer coefficient
    steamHeatTransfer = stuff;
    thermalConductivityMug =1.5; %W/(m*K)
        
        %initial teamp values (K)
        barTemp = 1500;
        steamTemp = 400;
        liquidTemp = 290;
        %% temperature
        initialRoomTemperature = 290;
        initialBarTemperature = 1500;
        
        %% time settings
        
        initialTime = 1;
        finalTime = 1000;
        
        %% main
        for n = initialTime:finalTime
            barToSteam(barTemp, steamTemp, steamMass);
            steamToLiquid(steamTemp, liquidTemp, steamMass, liquidMass);
            liquidHeatLoss(liquidTemp, liquidMass);
            
            
            
            
        end
        
end

%% helpers
    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end

    function res = temperatureToEnergy( T, m, c)
        res = T * heatCapacity(m,c);
    end

    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    function res = barToSteam(~, y)
        deltaTemperature = energyToTemperature(y, massOfBar, specificHeatOfCoffee) -environmentalTemperature;
        
        conductionFlow = thermalConductivityOfCupWalls * areaOfConduction / thicknessOfCupWalls * deltaTemperature;
        
        res = -conductionFlow;
    end
    function res = phaseChange(~,y)
        %q=m*heatofvaporization
        phaseFlow = massOfWater * heatOfVaporization;
    
    end
    function steamToLiquid(steamTemp, liquidTemp, steamMass, liquidMass)
        shit = 0;
    end
    function liquidHeatLoss(liquidTemp, liquidMass)
        shit = 0;
    end
        