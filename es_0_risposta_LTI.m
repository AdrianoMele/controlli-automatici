clearvars
close all
clc

%% Esempio 3.1 - evoluzione libera

% Massa-molla-smorzatore

% Vettore tempo
t = 0:1e-3:2;

% Coefficiente di attrito
% ka = 25; % Poli reali distinti
% ka = 20; % Poli reali coincidenti
% ka = 10; % Poli complessi coniugati
ka = 0.1; % Oscillazioni (quasi) persistenti

% Matrici A, B, C, D
A = [   0   1
     -100 -ka];
 
B = [0
     1];
 
C = [1 0];

D = 0;

% Stato iniziale
x0 = [1
      0];
  
% Ingresso
u = 0*t;

%% Calcolo evoluzione libera - analitico
x_free = zeros(numel(x0),numel(t));
for i = 1 : numel(t)
  x_free(:,i) = expm(A*t(i))*x0;
end

figure
plot(t,x_free)
title('Evoluzione libera - analitica')
xlabel('t')
ylabel('x')

%% Calcolo evoluzione libera - lsim

sys = ss(A,B,eye(2),0);
x_free = lsim(sys,u,t,x0);

% figure
hold on
plot(t,x_free)
title('Evoluzione libera - numerica')
xlabel('t')
ylabel('x')


%% Calcolo risposta forzata - analitico

% Ingresso a gradino
dt = t(2)-t(1);
u = 0*t + 1;
x0 = [0;0];


x_forced = zeros(numel(x0),numel(t));
for i = 1 : numel(t) % indice istante attuale
  temp = zeros(numel(x0),i);
  for j = 1 : i % indice variabile di integrazione
    temp(:,j) = expm(A*(t(i)-t(j)))*B*u(j)*dt;
  end
  x_forced(:,i) = sum(temp,2);
end

figure
plot(t,x_forced)
title('Risposta forzata')
legend('x','v')

%% Calcolo risposta forzata - lsim

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