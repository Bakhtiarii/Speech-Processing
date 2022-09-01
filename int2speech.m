    function speech = int2speech(digits , n)
        Fs = 8000 
        % Splitting   N
        number = num2str(n); 
        splitted_number = 0;
        for i = 1:size(number, 2)
        splitted_number(i) = str2num(number(i));
        end
        for j = 1:size(splitted_number,2)
            % Fill the speech with digits
            for Figures_filler = 1:(Fs/2)+1
                speech(1,((j-1)*((0.75*Fs)+1))+Figures_filler) = digits(Figures_filler,splitted_number(j)+1) ;
            end
            % 0.25 sec pause between digits
             for pause = 1:(Fs/4)
                speech(1,(j*((Fs/2)+1))+((j-1)*(Fs/4))+pause) = 0 ;
            end  
        end
        audiowrite('C:\Users\NP\speech2.wav', speech,Fs ,'BitsPerSample', 16) ;
    end
%     % -------------------------------------------------------------------------------  Adding Noise
%     noise = 1.*randn(1 , ((0.75*Fs)+1)*size(splitted_number,2)) ;
%     % This coefficient must be chosen experimentally to meet the condition of the problem
%     Coefficient = 0.01388658361414846901533690245211 ;   
%     noise = noise * Coefficient ;
%     absolute = abs(noise).^2 ;
%     noise_energy = 0 ;
%     for counter = 1:size(splitted_number,2)*((0.75*Fs)+1)   % Noise energy calculation
%         noise_energy = noise_energy + absolute(counter) ;
%     end
%     speech = speech + noise ; 
%     audiowrite('C:\Users\NP\speech3.wav', speech,Fs ,'BitsPerSample', 16) ;
%     % speech energy is 102.8972     ------> Divided into ten    10.28972