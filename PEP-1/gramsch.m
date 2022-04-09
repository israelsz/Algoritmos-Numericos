% Metodo de Gram-Schmidt para
% hacer la factorizacion QR reducida
% de una matriz A
function [Q, R, X, tiempoGramsch] = gramsch(A,b)
tic;
[m,n] = size(A);
if m<n
    error('Las dimensiones de la matriz A son incorrectas');
end
Q = A;
R = zeros(n);
for k=1:n
    for i=1:k-1
        R(i,k) = Q(:,i)'*Q(:,k);
        Q(:,k) = Q(:,k) - Q(:,i)*R(i,k);
    end
    R(k,k) = norm(Q(:,k));
    Q(:,k) = Q(:,k)/R(k,k);
end
X=inv(R) * Q' * b;
tiempoGramsch = toc;
end