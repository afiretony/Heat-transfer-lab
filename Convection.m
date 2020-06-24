%PLOTTING PROGRAM FOR HEAT TRANSFER LAB
%CREATER-CHENHAO YANG 24/6/2020 HAIFA
close all;clear;clc;
disp('Load data...')
load('convection.mat');
figureh=figure(1);
axesh=axes();
disp('Waiting for your choice...')
prompt={'Enter the experiment number(1,2,3):','Enter h:',...
    'Enter plot mode: together or seperate?'};
name='';
numlines=1;
defaultanswer={'1','10','together'};
answer=inputdlg(prompt,name,numlines,defaultanswer);
 h=str2double(answer{2});
 
switch answer{1}
    case '1'
        L=0.1;fin=fin1;
         title(join({'Heat Sink Experiment- Short Bar h=',answer{2}}));
    case '2'
        L=0.2;fin=fin2;
         title(join({'Heat Sink Experiment- Middle Bar h=',answer{2}}));
    case '3'
        L=0.4;fin=fin3;
         title(join({'Heat Sink Experiment- Long Bar h=',answer{2}}));
end
y=linspace(0,L,length(fin));
hold on;
plot(y,fin,'linewidth',2);


xlabel('length from bottom [m]');
ylabel('Temperature [K]');
set(gcf,'color',[1 1  1]);
grid on;

T1=zeros(length(fin),1);
T2=zeros(length(fin),1);
T3=zeros(length(fin),1);
disp('Calculating.......................')
for i=1:length(fin)
    x=y(i);
    T1(i)=300+230*(cosh(3.85*sqrt(h)*(L-x))+sqrt(h)/69.3*sinh(3.85*sqrt(h)* (L-x)))/...
        (cosh(3.85*sqrt(h)* L)+sqrt(h)/69.3 *sinh(3.85*sqrt(h)* L) );%convection bc
    T2(i)=300+230*(cosh(3.85*sqrt(h)*(L-x)))/...
        (cosh(3.85*sqrt(h)* L));%adiabatic bc
    T3(i)=300+230*exp(-3.85*sqrt(h)*x);%infinite fin bc
end
disp('Ploting.........................')
switch answer{3}
    case 'seperate'
        figure(2)
        plot(y,T1,'red','linewidth',2);
         title(join({'Convection B.C,- Short Bar h=',answer{2}}));
         xlabel('length from bottom [m]');
        ylabel('Temperature [K]');
        set(gcf,'color',[1 1  1]);
        grid on;

        figure(3)
        plot(y,T2,'black','linewidth',2);
         title(join({'Adiabatic B.C,- Short Bar h=',answer{2}}));
        xlabel('length from bottom [m]');
        ylabel('Temperature [K]');
        set(gcf,'color',[1 1  1]);
        grid on;

        figure(4)
        plot(y,T3,'green','linewidth',2);
         title(join({'Infinite Fin B.C,- Short Bar h=',answer{2}}));
        xlabel('length from bottom [m]');
        ylabel('Temperature [K]');
        set(gcf,'color',[1 1  1]);
        grid on;
    case 'together'
        plot(y,T1,'red','linewidth',1);
        plot(y,T2,'yellow','linewidth',1);
         plot(y,T3,'green','linewidth',1);grid on;
         legend('Experimental','Convention B.C.','Adiabatic B.C.','Infinite Fin B.C.');
end

