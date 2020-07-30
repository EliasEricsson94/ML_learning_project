close all
clear all

load ECG_1_AVR;
load ECG_1_II;
load ECG_1_II_missing;
load ECG_1_V;

load ECG_2_AVR;
load ECG_2_II;
load ECG_2_II_missing;
load ECG_2_V;

load ECG_3_AVR;
load ECG_3_II;
load ECG_3_II_missing;
load ECG_3_V;

load ECG_4_AVR;
load ECG_4_II;
load ECG_4_II_missing;
load ECG_4_V;

load ECG_5_AVR;
load ECG_5_II;
load ECG_5_II_missing;
load ECG_5_V;

load ECG_6_AVR;
load ECG_6_II;
load ECG_6_II_missing;
load ECG_6_V;

load ECG_7_AVR;
load ECG_7_II;
load ECG_7_II_missing;
load ECG_7_V;

load ECG_8_AVR;
load ECG_8_II;
load ECG_8_II_missing;
load ECG_8_V;

xTreal1 = ECG_1_II_missing;
x1 = ECG_1_AVR - mean(ECG_1_AVR);
y1 = ECG_1_V - mean(ECG_1_V);
xT1 = ECG_1_II - mean(ECG_1_II);
xTmean1 = mean(ECG_1_II);

xTreal2 = ECG_2_II_missing;
x2 = ECG_2_AVR - mean(ECG_2_AVR);
y2 = ECG_2_V - mean(ECG_2_V);
xT2 = ECG_2_II - mean(ECG_2_II);
xTmean2 = mean(ECG_2_II);

xTreal3 = ECG_3_II_missing;
x3 = ECG_3_AVR - mean(ECG_3_AVR);
y3 = ECG_3_V - mean(ECG_3_V);
xT3 = ECG_3_II - mean(ECG_3_II);
xTmean3 = mean(ECG_3_II);


xTreal4 = ECG_4_II_missing;
x4 = ECG_4_AVR - mean(ECG_4_AVR);
y4 = ECG_4_V - mean(ECG_4_V);
xT4 = ECG_4_II - mean(ECG_4_II);
xTmean4 = mean(ECG_4_II);


xTreal5 = ECG_5_II_missing;
x5 = ECG_5_AVR - mean(ECG_5_AVR);
y5 = ECG_5_V - mean(ECG_5_V);
xT5 = ECG_5_II - mean(ECG_5_II);
xTmean5 = mean(ECG_5_II);


xTreal6 = ECG_6_II_missing;
x6 = ECG_6_AVR - mean(ECG_6_AVR);
y6 = ECG_6_V - mean(ECG_6_V);
xT6 = ECG_6_II - mean(ECG_6_II);
xTmean6 = mean(ECG_6_II);


xTreal7 = ECG_7_II_missing;
x7 = ECG_7_AVR - mean(ECG_7_AVR);
y7 = ECG_7_V - mean(ECG_7_V);
xT7 = ECG_7_II - mean(ECG_7_II);
xTmean7 = mean(ECG_7_II);


xTreal8 = ECG_8_II_missing;
x8 = ECG_8_AVR - mean(ECG_8_AVR);
y8 = ECG_8_V - mean(ECG_8_V);
xT8 = ECG_8_II - mean(ECG_8_II);
xTmean8 = mean(ECG_8_II);


% START OF ACTUAL CODE

% Change the number on the right side of the equation to swap between
% patience.
x = x1;
y = y1; 
xT = xT1;
xTmean = xTmean1;
xTreal = xTreal1;


% Iteration lengths
Ndata = length(xT); 
Nfull = length(x);
Nrec = Nfull-Ndata;

% number of unknowns, length of theta vector
N=25;
M=25;
p=M+N+1+1;    % Current value for each a and b plus the current value


% Initilizations
mylambda=0.9992;            % Tested and found to be a good value
mytheta=0.2*ones(p,1);      
P=10000*eye(p);             % set as high.

% Vectors for storing values.
eA=zeros(Ndata,1);
thetaA(:,1)=mytheta;
thetaA2 = zeros(p,1);
xPredict= zeros(Nrec,1);       


tic
for i=max(N,M)+1:Ndata
    % Creating a row vector for H
    h=[x(i:-1:i-N) ;y(i:-1:i-M)];  
    
    % error (this is prediction error, not the ls error )
    e = xT(i) - h' * mytheta; 
    
    % update kalman gain
    K= P * h/(mylambda^i + h' * P * h); 
   
    % update theta 
    mytheta = mytheta + K * e; 

    % update P
    P = (eye(p)- K * h') * P;
      
    % store the values to plot later
    thetaA(:,i+1)=mytheta;
    eA(i,1)=e;  
end

for i=Ndata+1:Nfull
   h=[x(i:-1:i-N) ;y(i:-1:i-M)]; 
   xPredict(i-Ndata) = h' * mytheta;
end

xPredict = xPredict + xTmean;
toc

hf1=figure;
h12=plot(xTreal,'r');
legend('real value')
hold on

h11=plot(xPredict,'b');
legend('prediction value')
hold on

xlim([800,1150]);
hxlabel=xlabel('Time');
hylabel=ylabel('Value');

% %Look at the error 
etot = sum(eA)./(Nrec);
% figure

% plot(eA.^2)
eAT=zeros(Nrec,1);
for i=1:Nrec
    eAT(i,1) = eA(i) * eA(i);
end

% hf2=figure;
% h11=plot(eAT);
% hold on

eA2=zeros(Nrec,1);
for i=1:Nrec
    eA2(i,1) = (xTreal(i)-xPredict(i))^2;
end




Q1 = 1 - (mean(eA2) / var(xTreal));
Q2matrix = cov(xTreal,xPredict) / sqrt(  var(xTreal) * var(xPredict) ); 
Q2 = Q2matrix(2);
if Q2 < 0
    Q2 = 0;
end
if Q1 < 0
    Q1 = 0;
end


Q1
Q2% % Below code is written for p=2
mse = immse(xTreal, xPredict)
hf1=figure;
% Plot RLS filter coefficients, i.e. theta_1 and theta_2
h11=plot(thetaA(1,:)',':','Linewidth',2);
hold on
h12=plot(thetaA(2,:)',':','Linewidth',2);
hold on
% % Plot the parameters of the process
% h21=plot(ones(Nsim+1,1)* a1, '-k','Linewidth',2);
% h22=plot(ones(Nsim+1,1)* a2, '--k','Linewidth',2);
xlim([1,Ndata+1]);
hxlabel=xlabel('Iteration');
hylabel=ylabel('Filter Coefficients');
legend([h11 h12 ], 'a-Estimate', 'b-Estimate');
title('RLS estimation')
grid on;
set(gca,'FontSize',16);
set(hxlabel,'FontSize', 18);
set(hylabel,'FontSize', 18);
set(gca,'FontSize',16);
epsName=sprintf('figAR2_RLS.eps');
set(hf1, 'PaperPositionMode', 'auto');


