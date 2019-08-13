% function [ p ] = Circle_Fitting( XZ )
function [ p ] = Circle_Fitting(x,y)

% N >= 3
% x^2 + y^2 + ax + by + c = 0
% (x - p(1))^2 + (y - p(2))^2 = (p(3))^2

% N = size(XZ,1);
% x = XZ(:,1);
% z = XZ(:,2);
N = size(x,2);
x = x;
z = y;
sum_X_Raw = 0;
sum_Z_Raw = 0;
sum_XSquare_Raw = 0;
sum_ZSquare_Raw = 0;
sum_XCube_Raw = 0;
sum_ZCube_Raw = 0;
sum_XZZ_Raw = 0;
sum_XZ_Raw = 0;
sum_XXZ_Raw = 0;

for i=1:N
    sum_X_Raw = sum_X_Raw+x(i);
    sum_Z_Raw = sum_Z_Raw+z(i);
    sum_XSquare_Raw = sum_XSquare_Raw+x(i)*x(i);
    sum_ZSquare_Raw = sum_ZSquare_Raw+z(i)*z(i);
    sum_XCube_Raw = sum_XCube_Raw+x(i)*x(i)*x(i);
    sum_ZCube_Raw = sum_ZCube_Raw+z(i)*z(i)*z(i);
    sum_XZ_Raw = sum_XZ_Raw+x(i)*z(i);
    sum_XZZ_Raw = sum_XZZ_Raw+x(i)*z(i)*z(i);
    sum_XXZ_Raw = sum_XXZ_Raw+x(i)*x(i)*z(i);
end
D = N*sum_XZ_Raw-sum_X_Raw*sum_Z_Raw;
C = N*sum_XSquare_Raw-sum_X_Raw*sum_X_Raw;
E = N*sum_XCube_Raw+N*sum_XZZ_Raw-(sum_XSquare_Raw+sum_ZSquare_Raw)*sum_X_Raw;
G = N*sum_ZSquare_Raw-sum_Z_Raw*sum_Z_Raw;
H = N*sum_ZCube_Raw+N*sum_XXZ_Raw-(sum_XSquare_Raw+sum_ZSquare_Raw)*sum_Z_Raw;

a = (H*D-E*G)/(C*G-D*D);
b = (H*C-E*D)/(D*D-G*C);
c = -((sum_XSquare_Raw+sum_ZSquare_Raw)+a*sum_X_Raw+b*sum_Z_Raw)/N;

p(1) = -0.5*a;
p(2) = -0.5*b;
p(3) = 0.5*sqrt(a*a+b*b-4*c);
end