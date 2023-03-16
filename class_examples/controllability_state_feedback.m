clear all
clc

%% Sistema
A = [0 1 0; 0 -1 1; 0 0 -5];
B = [0 0 5]';

%% Test di controllabilità
% C = [B A*B A^2*B];
C = ctrb(A,B);
disp("Rango di C: " + rank(C))

%% Pole placement

% Poli desiderati a ciclo chiuso
p = [-1+2*1i,-1-2*1i,-10];

% gamma = [0 0 1]*inv(C);
gamma = [0 0 1]/C;

% Coefficienti polinomio caratteristico desiderato
coef = conv([1,-p(3)],conv([1 -p(1)],[1 -p(2)]));

% Polinomio caratteristico valutato in A
pA = coef(1)*A^3 + coef(2)*A^2 + coef(3)*A + coef(4)*eye(size(A,1));

% Guadagno del controllore
K = -gamma*pA;

% Verifica
disp("Autovalori a ciclo chiuso " + eig(A+B*K))

%% Metodi alternativi

K1 = -acker(A,B,p);

K2 = -place(A,B,p);

%% Simulazione
x0 = [1 2 3]';
sys = ss(A+B*K,B,eye(3),0);
t = 0:0.1:5;
u = 0*t;

x = lsim(sys,u,t,x0);

figure
plot(t,x)




