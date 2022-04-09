% Heuristica para asignar costo a las operaciones:
% Suma y resta / Condiciones y logica / Asignaciones -> costo 1
% Multiplicacion y division -> costo 2
% Llamada función -> costo 5
function [operaciones]=jacobiOperaciones(A,b,x0,iter,tol)
operaciones = 1;
if nargin<4
    'Faltan argumentos de entrada'
    operaciones = operaciones + 2;
    return;
else
    [cols,filas]=size(A);
    operaciones = operaciones + 5 + 2;
    if cols~=filas
        'La matriz no es cuadrada'
        operaciones = operaciones + 2 + 3;
        return;
    else
        if (cols~=size(x0))|(cols~=size(b))
            error('El sistema no es valido');
            operaciones = operaciones + 6;
        else
    % Generamos las matrices D, L y R
            for k=1:cols
                for j=k+1:cols
                    if k~=j
                        D(j,k)=0;
                        D(k,j)=0;
                        L(j,k)=A(j,k);
                        L(k,j)=0;
                        R(k,j)=A(k,j);
                        R(j,k)=0;
                        operaciones = operaciones + 7;
                    end
                end
                D(k,k)=A(k,k);
                L(k,k)=0;
                R(k,k)=0;
                operaciones = operaciones + 3;
            end
            fin=0;
            paso=1;
            x(1,:)=x0';
            operaciones = operaciones + 8;
% La condicion de parada adicional
% es que se llegue a la solución exacta
            while (fin==0)&(paso<=iter)
                operaciones = operaciones + 4;
                for componente=1:cols
                    vectant=0;
                    vectsig=0;
                    operaciones = operaciones + 2;
                    for k=1:componente-1
                        vectant=vectant+A(componente,k)*x(paso,k);
                        operaciones = operaciones + 4;
                    end

                    for k=componente+1:cols
                        vectsig=vectsig+A(componente,k)*x(paso,k);
                        operaciones = operaciones + 4;
                    end
                    x(paso+1,componente) = (b(componente)-vectant - vectsig)/A(componente,componente);
                    operaciones = operaciones + 6;
                end
% Si la solucion es igual a la anterior, salimos del bucle
                if x(paso,:)==x(paso+1,:)
                    fin=1;
                    operaciones = operaciones + 3;
                end

                % Condicion de parada por tolerancia, para si es menor a
                % tol
                if (norm(x(paso+1,:)-x(paso,:)) < tol)
                    fin=1;
                    operaciones = operaciones + 3;
                end 

                paso=paso+1;
                operaciones = operaciones + 2;
            end
% Metemos la última solución en un vector
            X=x(paso,:);
            operaciones = operaciones + 1;
        end
    end
end

