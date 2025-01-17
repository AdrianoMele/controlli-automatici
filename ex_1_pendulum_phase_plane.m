% pendulum equations
% -g/l * sin(theta) - b/ml * dtheta/dt = d2theta/dt2

% linearized pendulum
% +/- g/l theta - b/ml * dtheta/dt = d2theta/dt2

clearvars
close all
clc

%% Model parameters
m = 2;
g = 9.81;
l = 1;
b = 10;
% w_nat = sqrt(g/l);

%% Phase plane
x1 = -5*pi:0.3:5*pi;
x2 = x1;

[X1,X2] = meshgrid(x1,x2);
xx = [X1(:),X2(:)]';
xdot = f(0,xx,m,g,l,b);

figure
quiver(X1(:),X2(:),xdot(1,:)',xdot(2,:)',1.5)
axis tight

%% Trajectories

% x0 = [pi/3;pi/3];
x01 = linspace(min(x1)/2,max(x1)/2,5);
x02 = linspace(min(x2)/2,max(x2)/2,5);
[X01,X02] = meshgrid(x01,x02);
X0 = [X01(:),X02(:)]';

for i = 1 : size(X0,2)
  x0 = X0(:,i);
  [t,x] = ode45(@(t,x)f(t,x,m,g,l,b),[0,10],x0);

  hold on
  plot(x(:,1),x(:,2),'linewidth',2)
  plot(x0(1),x0(2),'o','linewidth',2)
end

%% Local functions
function xdot = f(t,x,m,g,l,b)
xdot(1,:) = x(2,:);
xdot(2,:) = -g/l * sin(x(1,:)) - b/(m*l)*x(2,:);
end
