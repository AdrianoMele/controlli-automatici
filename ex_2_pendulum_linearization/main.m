% pendulum equations
% -g/l sin(theta) + u/(m*l^2) = d2theta/dt2

% linearized equations
% +/- g/l theta + u/(m*l^2) = d2theta/dt2
clearvars
close all
clc

%% Init

% Parameters
m = 2;
g = 9.81;
l = 1;
w_nat = sqrt(g/l);

% Initial state
theta0 = 0.05*pi;
% theta0 = 0.1*pi;
% theta0 = 0.9*pi;
w0 = 0;

% Input
t = (1:1e-1:10)';
u = 0*t; % no input
% u = .5*ones(size(t)); % constant input
% w = 1; u = .5*square(2*w*t); % square wave
% w = 1; u = .5*sin(2*w*t); % sine wave

%% Simulation
disp(['x0 = ' num2str(theta0) ' rad']);
disp(['w_nat = ' num2str(w_nat) ' rad/s']);
sim('pendulum')

%% Plot
% Theta NL vs L
figure('Position', [200, 200, 500, 400])
subplot(2,1,1)
plot(simx.time, simx.signals.values), grid on
legend('NL', 'L')
xlabel('t')
ylabel('\theta [rad]')

% Input
subplot(2,1,2)
plot(t,u), grid on
legend('u')
xlabel('t')
ylabel('Coppia [Nm]')

%% Animation
fa = figure('Position', [700, 200, 400, 400]);
N = length(t);
theta = interp1(simx.time, simx.signals.values, t);
dt = t(2) - t(1);

% Test Time
tic;
figure(fa)
plot([0 l*sin(theta(1,1))], [0 -l*cos(theta(1,1))], '-ob', 'LineWidth', 2) % Nonlinear
hold on
plot([0 l*sin(theta(1,2))], [0 -l*cos(theta(1,2))], '-or', 'LineWidth', 2), grid on % Linear
hold off
legend('NL', 'L')
axis([-1.1*l, 1.1*l, -1.1*l, 1.1*l])
elapsedTime = toc;
tpause = max(dt-elapsedTime, 1e-3);

% Plot
for i = 1 : N
  figure(fa)
  plot([0 l*sin(theta(i,1))], [0 -l*cos(theta(i,1))], '-ob', 'LineWidth', 2) % Nonlinear
  hold on
  plot([0 l*sin(theta(i,2))], [0 -l*cos(theta(i,2))], '-or', 'LineWidth', 2), grid on % Linear
  hold off
  legend('NL', 'L')
  axis([-1.1*l, 1.1*l, -1.1*l, 1.1*l])
  text(.6, .6, ['t = ' num2str(t(i)) ' s'])
  pause(tpause)
end
