function [arregloGenerados,seed] = generadorCongruencialLineal(seed,modulo,multiplicador,incremento,cantidadNumeros,min,max)
    arregloGenerados = [];
    
    for i=1:cantidadNumeros
        valor = (seed*multiplicador)+incremento;
        nRandom = mod(valor,modulo);
        seed = nRandom;
        numGenerado = min + (max-min)*(nRandom/(modulo-1));

        arregloGenerados = [arregloGenerados,numGenerado];
    end
    arregloGenerados = arregloGenerados';
end
