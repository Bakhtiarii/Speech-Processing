    function digits = find_digits(speech1)
        avg = signal_energy(speech1,1,length(speech1))/length(speech1);  %Calculation of average signal energy
        [part ,energy ] = epoching (speech1,avg);
        n=(length(part)/2)-1;
        for i =1:n                % Plot digits
            Center = (part((2*i)+1)+part((2*i)+2))/2;
            DigitDiagram=speech1(Center-2000:Center+2000);
            figure;
            plot(DigitDiagram);
            title(['The signal of digit ',num2str(i-1),' Is displayed'])
            digits(i,:) = DigitDiagram ;
        end
        digits = digits' ;       % To make the matrix 4000*10 instead of 10*4000
        
        %-------------------------- Auxiliary functions
        function energy = signal_energy(signal , a , b)
            energy = sum(abs(signal(a:b)));
        end

        function [part , energy ] = epoching(signal,avg)
            Fs=8000;
            time = 1:160:length(signal);             % 160 Is the number of samples per 0.02 seconds
            time = [time , length(signal)];
            n=length(time)-1;
            for i =1:n
                energy(i) =  signal_energy (signal,time(i),time(i+1))/160;
            end
            energy(energy>avg)=1;
            energy(energy<avg)=0;
            part=0;
            j=1;
            for i=1:n-1
                if(energy(i)~= energy(i+1))
                part(j)=time(i+1);
                j=j+1;
                end
            end
        end

    end