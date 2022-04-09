% Heuristica para asignar costo a las operaciones:
% Suma y resta / Condiciones y logica / Asignaciones -> costo 1
% Multiplicacion y division -> costo 2
% Llamada función -> costo 5
function [operaciones] = doolittleOperaciones(A,b)
operaciones = 1;
if nargin<1
    error('No ha introducido la matriz de entrada');
    operaciones = operaciones + 3;
else
    [cols ,filas]=size(A);
    operaciones = operaciones + 7;
    if cols~=filas
    error('La matriz no es cuadrada');
    operaciones = operaciones + 3;
    else
        L=zeros(cols);
        U=zeros(cols);
        L(1,1)=1;
        U(1,1)=A(1,1);
        operaciones = operaciones + 14;
        for i=2:cols
            L(i,i)=1;
            U(1,i)=A(1,i);
            L(i,1)=A(i,1)/U(1,1);
            operaciones = operaciones + 5;
        end
        for j=2:cols
            for i=j:cols
                sumal=0;
                sumau=0;
                operaciones = operaciones + 2;
                for k=1:j-1
                    if (U(k,i)~=0)&(L(j,k)~=0)
                        sumal=sumal+U(k,i)*L(j,k);
                        operaciones = operaciones + 4 + 4;
                    end
                    if (U(k,j)~=0)&(L(i,k)~=0)&(i~=j)
                        sumau=sumau+U(k,j)*L(i,k);
                        operaciones = operaciones + 6 + 4;
                    end
                end
                U(j,i)=A(j,i)-sumal;
                operaciones = operaciones + 3;
                if (j<cols)&(i>j)
                    L(i,j)=(A(i,j)-sumau)/U(j,j);
                    operaciones = operaciones + 4 + 4;
                end
            end
        end
    end
    Y = inv(L)*b;
    X = inv(U)*Y;
    operaciones = operaciones + 16;
end

