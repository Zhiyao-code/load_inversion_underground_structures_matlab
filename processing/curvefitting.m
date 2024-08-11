function y=curvefitting(n,z,x,coord)
ni=n;
xi=x(1:ni)';
zi=z(1:ni);
y=interp1(zi,xi,coord);
end