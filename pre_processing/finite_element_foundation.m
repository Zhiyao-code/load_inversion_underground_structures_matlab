function kf=finite_element_foundation(k1,k2,L)
kf=[(L*(10*k1 + 3*k2))/35,(L^2*(15*k1 + 7*k2))/420,(9*L*(k1 + k2))/140,-(L^2*(7*k1 + 6*k2))/420;...
(L^2*(15*k1 + 7*k2))/420,(L^3*(5*k1 + 3*k2))/840,(L^2*(6*k1 + 7*k2))/420,-(L^3*(k1 + k2))/280;...
(9*L*(k1 + k2))/140,(L^2*(6*k1 + 7*k2))/420, (L*(3*k1 + 10*k2))/35, -(L^2*(7*k1 + 15*k2))/420;...
-(L^2*(7*k1 + 6*k2))/420,-(L^3*(k1 + k2))/280,-(L^2*(7*k1 + 15*k2))/420, (L^3*(3*k1 + 5*k2))/840];
end
