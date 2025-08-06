close all;
clear;
clc;

syms x(t);
dx = diff(x);

diffEq = diff(x, t, 2) + 3*diff(x, t) + 2*x == 5*heaviside(t);

initCond1 = x(0) == 1;
initCond2 = dx(0) == 1;

initConditions = [initCond1, initCond2];

solution(t) = dsolve(diffEq, initConditions);

simplifiedSolution = simplify(solution);

fprintf("The solution to the given differential equation:\n%s\nis:\nx(t) = %s\n", diffEq, simplifiedSolution);

fplot(simplifiedSolution, [0, 10]);
grid on; 
title('Solution of the Differential Equation');
xlabel('Time (t)');
ylabel('x(t)');
