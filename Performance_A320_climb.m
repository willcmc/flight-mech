mpft = 0.3048;
mspftmin = 0.00508
mspkt = 0.514444

%heights = mpft*linspace(0, 39000, 40);
%[T, a, P, rho] = atmosisa(heights);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mins = 30 %mins
secs = mins*60 %secs
step = 5 %secs
nstep = round(secs/step)

time = linspace(2, secs, nstep-1)
M = 0.78
Mf = 0.79
IAS = [0]
RoC = [5000]
h = [0]
Mach = [0]
distance = [0]

for i = 2:nstep
    [T, a, P, rho] = atmosisa(h(i-1))
    if h(i-1) < 5000*mpft
        RoC(i) = 2500*mspftmin
        IAS(i) = 175*mspkt
    elseif h(i-1) < 15000*mpft
        RoC(i) = 2000*mspftmin
        IAS(i) = 290*mspkt
    elseif h(i-1) < 24000*mpft
        RoC(i) = 1400*mspftmin
        IAS(i) = 290*mspkt
    elseif h(i-1) < 35000*mpft
        RoC(i) = 1000*mspftmin
        IAS(i) = sqrt(rho/1.225)*M*a
    else
        RoC(i) = 0
        IAS(i) = sqrt(rho/1.225)*Mf*a
    end 
    
    h(i) = h(i-1) + RoC(i)*step
    distance(i) = distance(i-1) + sqrt(1.225/rho)*IAS(i)*step
    Mach(i) = sqrt(1.225/rho)*IAS(i)/a
end

time(nstep)= time(nstep-1)+step
plot(distance, h)
hold on
plot(distance, 10000*Mach)
