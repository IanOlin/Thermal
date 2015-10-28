function res = liquidHeatLoss(liquidEnergy, liquidMass, liquidVolume)%needs temp, mass, volume of cider
        airSA = (.04^2 * pi) - (.02^2 * pi); %surface area in contact with air
        mugSA = (.04^2 * pi) + (liquidVolume * 2 / .04);%contact area with mug
        mugThickness = .007;
        thermalConductivity = 1.5;
        specificHeat = 4186;
        thermalHeatCoefficient = 10;%shitshitshitshitshitshitshitshitshitshitshitshit
        conduction = thermalConductivity * mugSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeat) - 290) / mugThickness;
        convection = thermalHeatCoefficient * airSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeat) - 290);
        
        res = conduction + convection;
end
     function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    