%Reto de la Avenida de Ciencias Aplicadas: Escenario doomsday.
%Autores: Vivas Rodríguez Emiliano, Mendoza Muraira Franco.
%Fecha: 2020/01/19
%Version 1.0

%Unidades y magnitudes de acuerdo con el Sistema Internacional.
clc;
close all;
clear;
warning("off");
global tierra;
global cometa;
tierra = zeros(1,7);
cometa = zeros(1,7);
lapso = zeros(2);
tierra(4) = 0.0167; %Excentricidad (e) de la Tierra.
cometa(4) = 0.777;  %Excentricidad (e) del cometa.
AU = 1.496*10.^11;  %Equivalencia de la unidad astronómica en metros.
G = 6.67*10.^-11;   %Constante universal de gravitación.
M = 1.99*10.^30;    %Masa solar.
tierra(1) = AU;     %Longitud del eje mayor (a) terrestre.
cometa(3) = 2.19114./(cometa(4)+1)*AU;  %Longitud del eje focal (c) del cometa.
cometa(1) = cometa(3)./cometa(4);   %Longitud del eje mayor (a) del cometa.
cometa(2) = sqrt(cometa(1).^2-cometa(3).^2);  %Longitud del eje menor (b) del cometa.
tierra(3) = tierra(1).*tierra(4);   %Longitud del eje focal (c) terrestre.
tierra(2) = sqrt(tierra(1).^2-tierra(3).^2);  %Longitud del eje menor (b) terrestre.
tierra(5) = sqrt(G*M/tierra(1));    %Velocidad orbital de la Tierra.
cometa(5) = sqrt(G*M/cometa(1));    %Velocidad orbital del cometa.
cometa(6) = 2*pi*cometa(1)/cometa(5);   %Periocidad del cometa en segundos.
cometa(7) = cometa(6)/(60*60*24);   %Periocidad del cometa en días.
tierra(6) = 2*pi*tierra(1)/tierra(5);   %Periocidad terrestre en segundos.
tierra(7) = tierra(6)/(60*60*24);   %Periocidad terrestre en días.
auxiliar = -tierra(1)^-2;
raiz = roots([auxiliar+cometa(1)^-2 auxiliar*-2*cometa(3) auxiliar*cometa(3)^2]);   %Resultado de las raíces de la igualación entre las ecuaciones de las órbitas de ambos cuerpos celestes.
interseccion = [modelarOrbitaCometa(raiz(2)) modelarOrbitaTierra(raiz(2))]; %Intersecciones formadas por la raíz adecuada en cada ecuación.
fprintf("Datos de la órbita del cometa:\n\n\t• a = %f m\n\tEje mayor (2a) = %f m\n\n\t• b = %f m\n\tEje menor (2b) = %f m\n\n\t• c = %f m\n\tEje focal (2c) = %f m\n\n\t• Excentricidad (e) = %f\n\n\t• Ecuación canónica:\n\tx^2 / %f^2 + y^2 / %f^2 = 1\n\n\t• Velocidad orbital = %f m/s\n\n\t• Focos: ( %f, 0 ) , ( %f, 0 )\n\n\t• Periodo orbital = %f s ( %f días ).\n\n\n", cometa(1), 2*cometa(1), cometa(2), 2*cometa(2), cometa(3), 2*cometa(3), cometa(4), cometa(1), cometa(2), cometa(5), -cometa(3), cometa(3), cometa(6), cometa(7));
fprintf("Datos de la órbita de la Tierra:\n\n\t• a = %f m\n\tEje mayor (2a) = %f m\n\n\t• b = %f m\n\tEje menor (2b) = %f m\n\n\t• c = %f m\n\tEje focal (2c) = %f m\n\n\t• Excentricidad (e) = %f\n\n\t• Ecuación canónica:\n\t(x - %f)^2 / %f^2 + y^2 / %f^2 = 1\n\n\t• Velocidad orbital = %f m/s\n\n\t• Focos: ( %f, 0 ) , ( %f, 0 )\n\n\t• Periodo orbital = %f s ( %f días ).\n\n\n", tierra(1), 2*tierra(1), tierra(2), 2*tierra(2), tierra(3), 2*tierra(3), tierra(4), cometa(3), tierra(1), tierra(2), tierra(5), cometa(3), cometa(3)+tierra(3), tierra(6), tierra(7));
fprintf("Intersección entre ambas órbitas.\n\n\tx^2 / %f^2 + y^2 / %f^2 = (x - %f)^2 / %f^2 + y^2 / %f^2\n\n\tx^2 / %f^2 - (x - %f)^2 / %f^2 = 0\n\n\tRaíces de la ecuación:\tx = { %f ; %f }\n\n\tColisión con muy baja posibilidad a los %f m en el eje de las abscisas.\n\n\n\t\t1° coordenada de intersección para el cometa: ( %f, %f )\n\n\t\t1° coordenada de intersección para la Tierra: ( %f, %f )\n\n\t\t2° coordenada de intersección para el cometa: ( %f, %f )\n\n\t\t2° coordenada de intersección para la Tierra: ( %f, %f )\n\n\n\t", cometa(1), cometa(2), cometa(3), tierra(1), tierra(2), cometa(1), cometa(3), tierra(1), raiz(1), raiz(2), raiz(2), raiz(2), interseccion(1), raiz(2), interseccion(2), raiz(2), -interseccion(1), raiz(2), -interseccion(2));
interseccion = mean(interseccion);
fprintf("Promedio de puntos de intersección:\n\t\t1° intersección ( %f, %f )\n\t\t2° intersección ( %f, %f )\n\n\n", raiz(2), interseccion, raiz(2), -interseccion);
%Simplificación de los resultados mediante el factor común 10.^11 m.
for indice=1:3
    tierra(indice) = tierra(indice)./10.^11;
    cometa(indice) = cometa(indice)./10.^11;
end
raiz = raiz/10.^11;
abscisa=-3:10^-5:4;
interseccion = interseccion/10.^11;
hold on;
title("Órbitas del cometa y de la Tierra.");
xlabel("• 10^1^1 m.");
ylabel("• 10^1^1 m.");
plot(abscisa,modelarOrbitaCometa(abscisa),"g--");
plot(abscisa,-modelarOrbitaCometa(abscisa),"g--");
plot(cometa(3),0,"g+");
plot(-cometa(3),0,"g+");
plot(0,0,"g.");
plot(abscisa,modelarOrbitaTierra(abscisa),"b--");
plot(abscisa,-modelarOrbitaTierra(abscisa),"b--");
plot(cometa(3),0,"b+");
plot(cometa(3)+2*tierra(3),0,"b+");
plot(cometa(3)+tierra(3),0,"b.");
plot(raiz(2),interseccion,'*');
plot(raiz(2),-interseccion,'*');
%Ubicación predefinida de los cuerpos celestes.
abscisa = [-cometa(1) cometa(3)+tierra(3)+tierra(1)];
plot(cometa(3),0,"ro");
plot(abscisa(1), modelarOrbitaCometa(abscisa(1)),"go");
plot(abscisa(2), modelarOrbitaTierra(abscisa(2)),"bo");
%Cálculo del tiempo requerido para que los cuerpos celestes se posicionen.
lapso(1,1) = (90+atand(hypot(cometa(3)+tierra(3)-raiz(2),tierra(1)-interseccion)/tierra(1)))/360;
lapso(2,1) = (180+atand(interseccion/raiz(2)))*cometa(7)/360;
lapso(1,2) = (180+asind(interseccion/tierra(1)))/360;
lapso(2,2) = (180-atand(interseccion/raiz(2)))*cometa(7)/360;
legend("1° sección de la órbita del cometa.", "2° sección de la órbita del cometa.", "1° foco de la órbita del cometa.", "2° foco de la órbita del cometa.", "Centro de la órbita del cometa.", "1° sección de la órbita de la Tierra.", "2° sección de la órbita de la Tierra.", "1° foco de la órbita de la Tierra.", "2° foco de la órbita de la Tierra.", "Centro de la órbita de la Tierra.", "1° intersección de órbitas.", "2° intersección de órbitas.", "Sol.", "Cometa.", "Tierra.");
axis equal;
grid off;
fprintf("Tiempo necesario para cursar por las intersecciones.\n\n\tUbicaciones iniciales:\n\t\tTierra ( %f, 0 )\n\t\tCometa ( %f, 0 )\n\n\t1° punto de intersección:\n\t", abscisa(2)*10.^11, abscisa(1)*10.^11);
fprintf("La Tierra estará en esta ubicación en %f días ( %f años terrestres ).\n\tEl cometa estará en esta ubicación en %f días ( %f años terrestres ).\n\n\t2° punto de intersección:\n\tLa Tierra estará en esta ubicación en %f días ( %f años terrestres ).\n\tEl cometa estará en esta ubicación en %f días ( %f años terrestres ).\n\n\n", lapso(1,1)*tierra(7), lapso(1,1), lapso(2,1), lapso(2,1)/tierra(7), lapso(1,2)*tierra(7), lapso(1,2), lapso(2,2), lapso(2,2)/tierra(7));
disp("Conclusión: Posibilidad nula de colisión entre ambos cuerpos celestes.");
function interseccion = modelarOrbitaCometa(abscisa)
global cometa;
interseccion = sqrt((1-(abscisa.^2/cometa(1).^2)).*cometa(2).^2);
end
function interseccion = modelarOrbitaTierra(abscisa)
global cometa;
global tierra;
interseccion = sqrt((1-((abscisa-cometa(3)-tierra(3)).^2/tierra(1).^2)).*tierra(2).^2);
end