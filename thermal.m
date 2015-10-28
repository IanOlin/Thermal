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
    lengthBar = 5/100 ;%length of bar in meters
    diameterBar = 4/100 ;%length of side of bar in meters
    volumeBar = pi*(diameterBar/2)^2*lengthBar; %volume
    surfaceAreaBar = pi * diameterBar * lengthBar + pi * (diameterBar/2)^2;
    massOfBar = densityBar * volumeBar;
    
        %% size of mug
    diameterCider = 8/100; %meters
    heatOfVaporization = 2256*10^3; %J/kG
    heightCider = 10/100; 
    thicknessMug = 0.7/100;
    
    thermalConductivitySteam = .00185;
    
    %steam surface area
    thicknessSteam = 1/100;
    steamSA = (lengthBar + thicknessSteam) * (pi * (diameterBar + 2 * thicknessSteam)) + 2 * pi * (diameterBar/2 + thicknessSteam)^2;
    %steam heat transfer coefficient
%     steamHeatTransfer = stuff;
    thermalConductivityMug =1.5; %W/(m*K)
    steamLiquidCoefficient = 2800;%W/(mK), is bullshit
    specificHeatSteam = 1865;%%specific heat in joules per kg kelvin
    specificHeatLiquid = 4186;%specific heat in joules per kg kelvin
    densityOfSteam = 0.590; %kg/m^3
    volumeSteam = steamSA * thicknessSteam;
    massOfSteam = volumeSteam * densityOfSteam;
    
       barSteamTransferCoefficient = 50; %this is shit

        
        %initial teamp values (K)
        barTemp = 1500;
        steamTemp = 380;
        liquidDensity = 1000;
        liquidTemp = 290;
        liquidVolume = (pi * (diameterCider/2)^2) * heightCider - (volumeBar + volumeSteam);
        liquidMass = liquidVolume * liquidDensity;
        %% temperature
        initialRoomTemperature = 290;
        initialBarTemperature = 1500;
        
        barEnergy = temperatureToEnergy(barTemp, massOfBar, specificHeatBar);
        steamEnergy = temperatureToEnergy(steamTemp, massOfSteam, specificHeatSteam);
        liquidEnergy = temperatureToEnergy(liquidTemp, liquidMass, specificHeatLiquid);
        %% time settings
        
        initialTime = 1;
        finalTime = 1000;
        emissivityCoefficient = .25; %lol magic space rays
        
        %% params
        params(1) = lengthBar;
        params(2) = diameterBar;
        params(3) = volumeBar;
        params(4) = surfaceAreaBar;
        params(5) = specificHeatLiquid;
        params(6) = specificHeatSteam;
        params(7) = specificHeatBar;
        params(8) = thermalConductivityMug;
        params(9) = thicknessMug;
        params(10) = densityBar;
        params(11) = steamSA;
        params(12) = steamLiquidCoefficient;
        params(13) = barSteamTransferCoefficient;
        params(14) = massOfBar;
        params(15) = heatOfVaporization;
        params(16) = massOfSteam;
        params(17) = steamEnergy;
        params(18) = liquidEnergy;
        params(19) = liquidMass;
        params(20) = 0;% was liquidVolume
        params(21) = barEnergy;
        params(22) = thermalConductivitySteam;
        params(23) = thicknessSteam;
        params(24) = emissivityCoefficient;
        
        

        %% main
        
            [T, Y] = ode45(@barToLiquid, [initialTime, 10000], params.');
            T = T.';
            Y = Y.';
            blah = zeros(1, length(T));
            for n = 1:length(T)
                blah(n) = Y(21, n);
            end
            plot(T, energyToTemperature(blah, massOfBar, specificHeatBar), 'b');
%             plot(T, blah, 'b');
            hold on;
            blah2 = zeros(1, length(T));
            for n = 1:length(T)
                blah2(n) = Y(18, n);
            end
            plot(T, energyToTemperature(blah2, liquidMass, specificHeatLiquid), 'b');

%             [T, Y] = ode45(@steamToLiquid, [initialTime, 10], params.'); %works perfectly
%             T = T.';
%             Y = Y.';
%             blah = zeros(1, length(T));
%             for n = 1:length(T)
%                 blah(n) = Y(18, n);
%             end
%             plot(T, blah, 'b');


%             [T, Y] = ode45(@barToSteam, [initialTime, 10], params.');
%             T = T.';
%             Y = Y.';
%             blah = zeros(1, length(T));
%             for n = 1:length(T)
%                 blah(n) = Y(21, n);
%             end
%             plot(T, energyToTemperature(blah, massOfBar, specificHeatBar), 'b');
% %             plot(T, blah, 'b');
%             hold on;
%             blah2 = zeros(1, length(T));
%             for n = 1:length(T)
%                 blah2(n) = Y(17, n);
%             end
%             plot(T, energyToTemperature(blah2, massOfSteam, specificHeatSteam), 'b');
%             
%             hold on;
            
%             [T, Y] = ode45(@liquidHeatLoss, [initialTime, 10], params.');
%             T = T.';
%             Y = Y.';
%             blah = zeros(1, length(T));
%             for n = 1:length(T)
%                 blah(n) = Y(18, n);
%             end
%             plot(T, blah, 'b');


    %%fuk u matlab, it works

%         liquidEnergies = zeros(1, 100);
%         for n = 1:100
%             tempParams = barToSteam(1, params);
%             liquidEnergies(n) = params(17) + tempParams(17)/100;
%             params(17) = liquidEnergies(n);
%         end
%         plot(energyToTemperature(liquidEnergies, liquidMass, 4186));
%         display(params(18));
        
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
    
    