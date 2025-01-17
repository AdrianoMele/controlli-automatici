clearvars
close all
clc

%% Mass-spring-damper system (Bolzern - example 3.1)

% Time vector
t = 0:1e-3:2;

% Friction coefficient
% ka = 25; % Real, distinct poles
% ka = 20; % Real, coinciding poles
% ka = 10; % Complex conjugate poles
ka = 0.1; % Stability magin

% State-space matrices
A = [   0   1
     -100 -ka];
B = [0
     1];
C = [1 0];
D = 0;

% Initial state
x0 = [1
      0];
  
% Input
u = 0*t;

%% Free evolution - analytical
x_free = zeros(numel(x0),numel(t));
for i = 1 : numel(t)
  x_free(:,i) = expm(A*t(i))*x0;
end

figure
plot(t,x_free)
title('Evoluzione libera - analitica')
xlabel('t')
ylabel('x')

%% Free evolution - lsim
sys = ss(A,B,eye(2),0);
x_free = lsim(sys,u,t,x0);

% figure
hold on
plot(t,x_free)
title('Evoluzione libera - numerica')
xlabel('t')
ylabel('x')

%% Forced response - analytical

% Step input
dt = t(2)-t(1);
u = 0*t + 1;
x0 = [0;0];

x_forced = zeros(numel(x0),numel(t));
for i = 1 : numel(t) % current time index
  temp = zeros(numel(x0),i);
  for j = 1 : i % integration variable index
    temp(:,j) = expm(A*(t(i)-t(j)))*B*u(j)*dt;
  end
  x_forced(:,i) = sum(temp,2);
end

figure
plot(t,x_forced)
title('Risposta forzata')
legend('x','v')

%% Forced response - lsim
sys = ss(A,B,eye(2),0);
u = 0*t + 10;
x_forced = lsim(sys,u,t,x0);

figure
% hold on
plot(t,x_forced)
title('Evoluzione forzata - numerica')
xlabel('t')
ylabel('x')
legend('x','v')