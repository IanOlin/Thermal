function res = barToSteam(~, y)
        deltaTemperature = energyToTemperature(y, massOfBar, specificHeatOfCoffee) -environmentalTemperature;
        
        conductionFlow = thermalConductivityOfCupWalls * areaOfConduction / thicknessOfCupWalls * deltaTemperature;
        
        res = -conductionFlow;
    end