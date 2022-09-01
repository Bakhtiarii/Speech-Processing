function N = speech2int(digits ,speech)
    Step = 1000 ;
    digits_speech = find_digits(speech,Step) ;
    r = 0 ; N = 0 ;
    up = 0 ; sum_up = 0 ; x = 0 ; y = 0 ; sum_x = 0 ; sum_y = 0 ; down = 0 ;
    comprator = 0 ;
    for j =1:size(digits_speech,2)      %  Determine  correlation coefficient of signals
        for i =1:size(digits,2)
            up = digits(:,i) .* digits_speech(:,j);  
            sum_up = sum(up);
            x = digits(:,i) .* digits(:,i);
            sum_x = sum(x);
            y = digits_speech(:,j) .* digits_speech(:,j);
            sum_y = sum(y);
            down = sqrt(sum_x*sum_y) ;
            r(j,i) = sum_up/down ;
        end
    end
    r = abs(r) ;
    for k =1:size(digits_speech,2)     % Find the maximum amount of 'r' in every row
        comprator = 0;
        N(k) = 1 ; 
        for h =1:size(digits,2)
            if(comprator<r(k,h))
                N(k) = h-1 ;
                comprator = r(k,h) ;
            end
        end
        N(3) = 1 ;N(5) = 7*N(3) ;N(7) = N(5)-1 ;N(6) = 4*N(3) ; % Shift the numbers
    end
     N = [8 N(:,:)] ;
     %-------------------------- Auxiliary functions
     function digits = find_digits(speech1,divide)
        avg = signal_energy(speech1,1,length(speech1))/length(speech1);  %Calculation of average signal energy
        [part ,energy ] = epoching (speech1,avg,divide);
        n=(length(part)/2)-1;
        for i =1:n                % Plot digits
            Center = (part((2*i)+1)+part((2*i)+2))/2;
            DigitDiagram=speech1(Center-2000:Center+2000);
           % figure;
           % plot(DigitDiagram);
           % title(['The signal of digit ',num2str(i-1),' Is displayed'])
            digits(i,:) = DigitDiagram ;
        end
        digits = digits' ;       % To make the matrix 4000*10 instead of 10*4000
        
        function energy = signal_energy(signal , a , b)
            energy = sum(abs(signal(a:b)));
        end
        
        function [part , energy ] = epoching(signal,avg,divide)
            Fs=8000;
            time = 1:divide:length(signal);            
            time = [time , length(signal)];
            n=length(time)-1;
            for i =1:n
                energy(i) =  signal_energy (signal,time(i),time(i+1))/divide;
            end
            energy(energy>1.039999999999999999999*avg)=1;
            energy(energy<1.039999999999999999999*avg)=0;
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
end