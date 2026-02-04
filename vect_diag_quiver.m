%           Ввод измеренных параметров
I1 = 9.27;     % Полный ток статора
U1 = 200;      % Напряжение на статоре
fi1 = 49;      % Угол между током и напряжением статора (в градусах)
w = 48.5;      % Скорость в рад/с
f = 25;        % Частота напряжения статора
Ip = 4.4;      % Ток ротора, А

%         Ввод неизменяемых параметров
r1 = 1.8;      % Невыключаемое активное сопротивление статора, Ом
x1 = 2.33;     % Невыключаемое индуктивное сопротивление статора, Ом
r2 = 0.5;      % Невыключаемое активное сопротивление ротора, Ом
x2 = 0.6;      % Невыключаемое индуктивное сопротивление ротора, Ом
xu = 0.35;          
Kr = 3.92;
r2p = r2 * Kr;
x2p = x2 * Kr;

%         Необходимые расчеты
W0n = 2 * pi * 50 / 3;   % Синхронная скорость, рад/с
al = f / 50;
W0 = al * W0n;
Ke = sqrt(Kr);           % Коэффициент трансформации по ЭДС
s = (W0 - w) / W0;       % Вычисление скольжения
deg = pi / 180;

% Вектор U1
fu1 = 90 * deg;
u1 = U1 * exp(fu1 * 1i);
quiver(0, 0, 0, U1, 0, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)
hold on

% Вектор I1
fii1 = (90 - fi1) * deg;
i1 = I1 * exp(fii1 * 1i);
quiver(0, 0, real(i1), imag(i1), 0, 'b', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)

% Вектор i1r1
fi1r1 = fii1;
i1r1 = I1 * r1 * exp(fi1r1 * 1i);
quiver(0, U1, -real(i1r1), -imag(i1r1), 0, 'g', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)

% Вектор U1`
u1p = u1 - i1r1;
quiver(0, 0, real(u1p), imag(u1p), 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)

% Вектор i1x1
ax1r1 = real(u1p);
bx1r1 = imag(u1p);
fi1x1 = (180 - fi1) * deg;
i1x1 = I1 * x1 * al * exp(fi1x1 * 1i);
quiver(ax1r1, bx1r1, -real(i1x1), -imag(i1x1), 0, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)

% Вектор E1
e1 = u1 - i1r1 - i1x1;
E1 = abs(e1);
quiver(0, 0, real(e1), imag(e1), 0, 'c', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)

% Вектор Iu !Выбрать тип расчета!
iupr = 0; % 0-значение берется из Starter, 1- значение высчитывается

tga = imag(e1) / real(e1);
ae1 = atan(tga) / deg;
if ae1 < 0
    fiu = (ae1 + 90) * deg;
else 
    fiu = (ae1 - 90) * deg;
end  

if iupr == 0
    Iu = 8;      % Ток намагничивания, рад/с
    iu = Iu * exp(fiu * 1i);
    quiver(0, 0, real(iu), imag(iu), 0, 'g', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)
else 
    ru = 0;
    Iu = abs(e1) / (xu * al + ru);
    iu = Iu * exp(fiu * 1i);
    quiver(0, 0, real(iu), imag(iu), 0, 'g', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)
end

% Вектор I2 !Выбрать тип расчета!
i2pr = 0; % 0-по построению, 1 - по расчету

if i2pr == 0 
    i2 = iu - i1;
    I2 = abs(i2);
    ai2p = real(i1);
    bi2p = imag(i1);
    quiver(ai2p, bi2p, real(iu)-ai2p, imag(iu)-bi2p, 0, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)
else
    I2 = abs(e1) / (x2p * al + r2p / s);
    ali2 = atan(x2p * al * s / r2p) / deg;
    fi2 = (90 - ali2) * deg;
    i2 = I2 * exp(fi2 * 1i);
    ai2 = real(i1);
    bi2 = imag(i1);
    quiver(ai2, bi2, -real(i2), -imag(i2), 0, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)
end

% Вектор I2`x2
ai2x2 = real(e1);
bi2x2 = imag(e1);
ali2x2 = real(i2) / imag(i2);
fi2px2 = -atan(ali2x2);
i2px2 = I2 * x2p * exp(fi2px2);
quiver(ai2x2, bi2x2, real(i2px2), imag(i2px2), 0, 'y', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)

% Вектор U2`
u2p = e1 + i2px2;
quiver(0, 0, real(u2p), imag(u2p), 0, 'm', 'LineWidth', 1.5, 'MaxHeadSize', 0.05)

% Настройка графика
grid on
axis equal
xlabel('Re')
ylabel('Im')
title('Векторная диаграмма ПЧ-АД');

% Подписи векторов
text(real(iu)-0.5, imag(iu)-1.5, 'Iu', 'color', 'g', 'FontSize', 10)
text(real(iu)+0.2, imag(iu)-imag(i2)/2, 'I2`', 'color', 'r', 'FontSize', 10)
text(real(i1)-0.5, imag(i1)*1.4, 'I1', 'color', 'b', 'FontSize', 10)
text(real(e1), imag(e1), '-E1', 'color', 'c', 'FontSize', 10)
text(real(e1)+real(i2px2)/2, imag(e1)+imag(i2px2)/2, 'I2`x2', 'color', 'y', 'FontSize', 10)
text(real(u2p), imag(u2p), 'U2`', 'color', 'm', 'FontSize', 10)
text(real(u1p), imag(u1p)*0.9, 'U1`', 'color', 'k', 'FontSize', 10)
text(real(u1)*0.9, imag(u1)*0.85, 'U1', 'color', 'r', 'FontSize', 10)
text(-real(i1r1)*0.5, imag(u1), 'I1r1', 'color', 'g', 'FontSize', 10)
text(ax1r1-real(i1x1)/2, bx1r1-imag(i1x1)/2, 'I1x1', 'color', 'r', 'FontSize', 10)

% Легенда (опционально)
legend('U1', 'I1', 'I1r1', 'U1`', 'I1x1', 'E1', 'Iu', 'I2', 'I2x2', 'U2`', ...
       'Location', 'bestoutside');
hold off