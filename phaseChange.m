function res = phaseChange(netHeat, params)%Out of date, did not up date, please use real variables. TT
        %q=m*heatofvaporization
        energyTransfer = params(5) * waterMass * energyToTemperature(netHeat, netHeat/(params(5) * 373), params(5));%transfer from water to steam, dQ = c*m*dt where c is specific heat, because water is at boiling point mass is energy/(c*373K)
        massTransfer = -energyTransfer/params(15);
        res = [energyTransfer, massTransfer];
        
        
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