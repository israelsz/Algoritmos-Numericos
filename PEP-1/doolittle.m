% Factorización LU por el método de Doolittle
function [L,U,X,tiempoDoolittle] = doolittle(A,b)
tic;
if nargin<1
    error('No ha introducido la matriz de entrada');
else
    [cols ,filas]=size(A);
    if cols~=filas
    error('La matriz no es cuadrada');
    else
        L=zeros(cols);
        U=zeros(cols);
        L(1,1)=1;
        U(1,1)=A(1,1);
        for i=2:cols
            L(i,i)=1;
            U(1,i)=A(1,i);
            L(i,1)=A(i,1)/U(1,1);
        end
        for j=2:cols
            for i=j:cols
                sumal=0;
                sumau=0;
                for k=1:j-1
                    if (U(k,i)~=0)&(L(j,k)~=0)
                        sumal=sumal+U(k,i)*L(j,k);
                    end
                    if (U(k,j)~=0)&(L(i,k)~=0)&(i~=j)
                        sumau=sumau+U(k,j)*L(i,k);
                    end
                end
                U(j,i)=A(j,i)-sumal;
                if (j<cols)&(i>j)
                    L(i,j)=(A(i,j)-sumau)/U(j,j);
                end
            end
        end
    end
    Y = inv(L)*b;
    X = inv(U)*Y;
    tiempoDoolittle = toc;
end