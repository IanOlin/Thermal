function res = liquidHeatLoss(liquidEnergy, liquidMass, liquidVolume, params)%needs temp, mass, volume of cider
        airSA = (.04^2 * pi) - (.02^2 * pi); %surface area in contact with air
        mugSA = (.04^2 * pi) + (liquidVolume * 2 / .04);%contact area with mug
        mugThickness = params(9);
        thermalConductivity = params(8);
        specificHeatLiquid = params(5);
        thermalHeatCoefficient = 10;%shitshitshitshitshitshitshitshitshitshitshitshit
        conduction = thermalConductivity * mugSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid) - 290) / mugThickness;
        convection = thermalHeatCoefficient * airSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid) - 290);
        
        res = conduction + convection;
end

     function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
     end
    
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    