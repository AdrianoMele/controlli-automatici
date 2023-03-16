function drawPendulum(theta,l,hf)
% drawPendulum(theta,l,[hf])
%   Draws a pendulum at angle theta

if nargin == 3
  figure(hf)
end

plot([0 l*cos(theta-pi/2)], [0 l*sin(theta-pi/2)], 'b', 'linewidth', 2)
hold on
plot(l*cos(theta-pi/2), l*sin(theta-pi/2), 'ob', 'markersize', 20, 'linewidth', 2)
hold off
axis([-l l -l l]*1.1)

end