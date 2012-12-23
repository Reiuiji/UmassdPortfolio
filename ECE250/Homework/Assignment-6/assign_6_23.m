Time=input('what time the call was made [day, evening, or night]: ','s');
Dur=input('Duration of the call in min: ');
Dur=ceil(Dur);
if length(Time)==3
    
    if Dur<10
        cost=Dur*0.1;
    elseif Dur>10 && Dur<30
        cost=(Dur-10)*0.08+1;
    elseif Dur>30
        cost=(Dur-30)*0.06+2.6;
    end
    
elseif length(Time)==7
    
    if Dur<10
        cost=Dur*0.07;
    elseif Dur>10 && Dur<30
        cost=(Dur-10)*0.05+0.7;
    elseif Dur>30
        cost=(Dur-30)*0.04+1.7;
    end
    
elseif length(Time)==5
    
    if Dur<10
        cost=Dur*0.04;
    elseif Dur>10 && Dur<30
        cost=(Dur-10)*0.03+0.4;
    elseif Dur>30
        cost=(Dur-30)*0.02+1;
    end
    
end
fprintf('Cost = $%f\n',cost);