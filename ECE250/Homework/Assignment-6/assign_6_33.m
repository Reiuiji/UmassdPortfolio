clear
quiz=input('quiz grades ex[1 2] : ');
mid=input('Midterm grades ex[1 2] : ');
final=input('Final grade: ');

avg_quiz=(sum(quiz)-min(quiz))/4;
avg_mid=sum(mid)/3;
quiz_grade=0.25*avg_quiz*10;
if avg_mid>final
    mid_grade=0.35*avg_mid;
end
if avg_mid<=final
    mid_grade=0.35*((sum(mid)-min(mid))/2);
end
final_grade=0.4*final;

grade=quiz_grade+mid_grade+final_grade;
fprintf('Grade: ');
if grade>=90
    fprintf('A');
elseif grade >=80
    fprintf('B');
elseif grade >=70
    fprintf('C');
elseif grade >=60
    fprintf('D');
else
    fprintf('E');
end
fprintf('\n');