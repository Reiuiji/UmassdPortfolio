function Assign_7_37
fprintf('Enter the following to generate the bandpass\n');
R = input('Resistor: ');
C = input('Capacitor: ');
L = input('inductance of the coil: ');
w=0:10000:10E7;
band_pass(R,C,L,w);
semilogx(w,band_pass(R,C,L,w))
xlabel('w log scale');
ylabel('RV');

    function RV=band_pass(R,C,L,w)
    RV=(w.*R.*C)./sqrt((1-w.^2.*L.*C).^2 + (w.*R.*C).^2);
    end
end
