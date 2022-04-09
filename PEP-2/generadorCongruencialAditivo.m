function [arregloGenerados,seed] = generadorCongruencialAditivo(seed,modulo,incremento,cantidadNumeros,min,max)
    arregloGenerados = [];
    
    for i=1:cantidadNumeros
        nRandom = mod((seed+incremento),modulo);
        numGenerado = min + (max-min)*(nRandom/(modulo-1));
        seed = nRandom;
        arregloGenerados = [arregloGenerados,numGenerado];
    end
    arregloGenerados = arregloGenerados';
end

