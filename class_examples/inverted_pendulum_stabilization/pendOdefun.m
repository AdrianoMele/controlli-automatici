function xdot = pendOdefun(~,x,m,l,g,b,K,xeq)

if nargin < 7
  K = [0 0];
  xeq = [0; 0];
end

xdot(1,:) = x(2,:);
try
  xdot(2,:) = -g/l*sin(x(1,:)) - b/m/l * x(2,:) + 1/m/l^2 * K*(x-xeq);
catch
  keyboard
end

end