% Heuristica para asignar costo a las operaciones:
% Suma y resta / Condiciones y logica / Asignaciones -> costo 1
% Multiplicacion y division -> costo 2
% Llamada función -> costo 5
function [operaciones] = gramschOperaciones(A,b)
operaciones = 1;
[m,n] = size(A);
operaciones = operaciones + 7;
if m<n
    error('Las dimensiones de la matriz A son incorrectas');
    operaciones = operaciones + 3;
end
Q = A;
R = zeros(n);
operaciones = operaciones + 7;
for k=1:n
    for i=1:k-1
        R(i,k) = Q(:,i)'*Q(:,k);
        Q(:,k) = Q(:,k) - Q(:,i)*R(i,k);
        operaciones = operaciones + 8 + 4;
    end
    R(k,k) = norm(Q(:,k));
    Q(:,k) = Q(:,k)/R(k,k);
    operaciones = operaciones + 6 + 3;
end
X=inv(R) * Q' * b;
operaciones = operaciones + 15;
end