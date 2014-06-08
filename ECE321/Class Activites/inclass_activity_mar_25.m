% In-Class Activity
% March 25, 2014
%
% Jenny Doan
% Brandyn Fastino
% Daniel Noyes
w = -10:0.1:10;
Hjw = 2*sin(w*2)./w;
Ht = exp(-8)*exp(-1i*2*w)./(4+1i*w);


figure(1);
subplot(2,1,1);
plot(w,abs(F_jw_1),'r');
xlabel('w rad/sec');
ylabel('|F(jw)|')
title('|X_1(jw)|')
grid on;
axis tight;

subplot(2,1,2);
plot(w,unwrap(angle(F_jw_1)),'r');
xlabel('w rad/sec');
ylabel('Angle(F(jw) Rad')
title('Angle(X_1(jw))')
grid on;
axis tight;    

figure(2);
subplot(2,1,1);
plot(w,abs(F_jw_2),'r');
xlabel('w rad/sec');
ylabel('|F(jw)|')
title('|X_2(jw)|')
grid on;
axis tight;

subplot(2,1,2);
plot(w,unwrap(angle(F_jw_2)),'r');
xlabel('w rad/sec');
ylabel('Angle(F(jw) Rad')
title('Angle(X_2(jw))')
grid on;
axis tight; 
