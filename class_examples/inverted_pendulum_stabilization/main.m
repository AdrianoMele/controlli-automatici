%% Parameters
m = 1;
l = 0.5;
b = 0.1;
g = 9.81;

%% Simulation - open loop
x0 = [pi/6,0];
[t,y] = ode45(@(t,x)pendOdefun(t,x,m,l,g,b),0:1e-1:5,x0);

% figure
% for i = 1 : numel(t)
%   figure(1)
%   drawPendulum(y(i,1),l)
%   title("t = " + t(i) + " s")
%   pause(1e-2)
% end

%% Linearization
As = [0 1; -g/l, -b/m/l];
Bs = [0; 1/m/l^2];
disp("Autovalori intorno a \theta = 0")
disp(eig(As))

Au = [0 1; +g/l, -b/m/l];
Bu = [0; 1/m/l^2];
disp("Autovalori intorno a \theta = \pi")
disp(eig(Au))

sys_s = ss(As,Bs,eye(2),0);
xlin = lsim(sys_s,0*t,t,x0);

figure
plot(t,y,'b',t,xlin,'r')

%% State feedback
p = [-4 -5];
K = -place(Au,Bu,p);

%% Test

% Linearizzato
x0 = [-pi/6; 0];
sys_c = ss(Au+Bu*K,Bu,eye(2),0);
xclin = lsim(sys_c,0*t,t,x0);
xclin = xclin + repmat([pi 0],size(xclin,1),1);


% Non lineare
x0 = [pi-pi/6; 0];
[t,yc] = ode45(@(t,x)pendOdefun(t,x,m,l,g,b,K,[pi;0]),0:1e-1:5,x0);


figure
subplot(211)
plot(t,yc,'b',t,xclin,'r')
legend('NL','NL','lin','lin')
subplot(212)
plot(t,K*(yc-repmat([pi,0],numel(t),1))')
legend('u')

figure
for i = 1 : numel(t)
  drawPendulum(yc(i,1),l)
  title("t = " + t(i) + " s")
  pause(1e-2)
end
