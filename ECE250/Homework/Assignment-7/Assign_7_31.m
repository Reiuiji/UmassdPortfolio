function Assign_7_31
R = input('Enter the Student Grade in array ([9 9 etc.]): ');

fprintf('final grade: %5.3f \n', fgrade(R))

    function g = fgrade(R)
        %calculate the homework and drops the lowest homework
        rem=1;
        hwtot=0;
        for i=1:1:6
            if R(rem) > R(i)
                rem = i;
            end
            hwtot=hwtot+R(i);
        end
        hwtot=hwtot-R(rem);
        HW=hwtot/5*10*.15;
        
        %calculate the midterms
        Mid=(R(7)+R(8)+R(9))/3*0.45;
        %calculate the final exam
        Fin=R(10)*0.4;
        %sum all together
        g=HW+Mid+Fin;
        
    end
end