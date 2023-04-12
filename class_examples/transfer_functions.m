clearvars
close all
clc

%% Transfer functions

% Define transfer function based on coefficients
P1 = tf(1,[1 3 3 1]);

% Define Laplace's variable
s = tf('s');
% s = tf([1 0],1); % equivalent

% Define transfer function using s
P2 = 1/(s+1)^3;

% Define transfer function from ss model
A = [0 1 0; 0 0 1; -1 -3 -3];
B = [1 0 0]';
C = [0 0 1];
D = 0;

sys = ss(A,B,C,D);
P3 = tf(sys);

% Define transfer function from matrices
P4 = C*((s*eye(3) - A)\B) + D;

%% Plots
figure
bode(P1), grid

figure
nyquist(P1), grid

figure
step(P1), grid

%% Feedback tf
F1 = feedback(P1,1);
F2 = P1/(1+P1);

figure
nyquist(F1)
hold on
nyquist(F2)

%% Stability margin
K = 1;
F3 = feedback(K*P1,1);

figure

subplot(121)
step(P1)
hold on
step(F3)
step(feedback(3*P1,1))
step(feedback(5*P1,1))
step(feedback(8*P1,1))
% step(feedback(8.01*P1,1))
% xlim([0, 1000])

subplot(122)
nyquist(P1)
hold on
nyquist(3*P1);
nyquist(5*P1);
nyquist(8*P1);


%% Other examples
L = 10*(1+s)/(2+s)/(s-10);

figure
subplot(121)
nyquist(20*L)

subplot(122)
step(feedback(20*L,1))
