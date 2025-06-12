%           ���� ���������� ����������
I1=9.27;     % ������ ��� �������
U1=200;    % ���������� �� �������
fi1=49;    % ���� ����� ����� � ���������� ������� (� ��������)
w=48.5;      % �������� � ���/�
f=25;      % ������� ���������� �������
Ip=4.4;     % ��� ������, �

%         ���� ������������ ����������
        % ���������� ������
%r1=2.1;  % ������������� �������� ������������� �������, ��
%x1=2.45; % ������������� ����������� ������������� �������, ��
%r2=0.6;  % ������������� �������� ������������� ������, ��
%x2=0.76; % ������������� ����������� ������������� ������, ��
%xu=40;
           % ���������� ������
r1=1.8;  % ������������� �������� ������������� �������, ��
x1=2.33; % ������������� ����������� ������������� �������, ��
r2=0.5;  % ������������� �������� ������������� ������, ��
x2=0.6; % ������������� ����������� ������������� ������, ��
xu=0.35;          
Kr=3.92;
r2p=r2*Kr;
x2p=x2*Kr;

%         ����������� �������
W0n=2*pi*50/3;   % ���������� ��������, ���/�
al=f/50;
W0=al*W0n;
Ke=sqrt(Kr); % ����������� ������������� �� ���
s=(W0-w)/W0; % ���������� ����������
deg=pi/180;

% ������ U1
fu1=90*deg;
u1=U1*exp(fu1*j);
plot ([0 0],[0 U1],'r')
hold on
%axis([-10 10 0 20])  

% ������ I1
fii1=(90-fi1)*deg;
i1=I1*exp(fii1*j);
plot([0 real(i1)],[0 imag(i1)],'b')

% ������ i1r1
fi1r1=fii1;
i1r1=I1*r1*exp(fi1r1*j);
plot ([0 real(-i1r1)],[U1 imag(-i1r1)+U1],'g')

% ������ U1`
u1p=u1-i1r1;
plot([0 real(u1p)],[0 imag(u1p)],'k')

% ������ i1x1
ax1r1=real(u1p);
bx1r1=imag(u1p);
fi1x1=(180-fi1)*deg;
i1x1=I1*x1*al*exp(fi1x1*j);
plot([ax1r1 real(-i1x1)+ax1r1],[bx1r1 imag(-i1x1)+bx1r1],'r')

% ������ E1
e1=u1-i1r1-i1x1;
E1=abs(e1);
plot([0 real(e1)],[0 imag(e1)],'c')



              % ������ Iu !������� ��� �������!
iupr=0; % 0-�������� ������� �� Starter, 1- �������� �������������

tga=imag(e1)/real(e1);
ae1=atan(tga)/deg;
if ae1<0
fiu=(ae1+90)*deg;
else 
fiu=(ae1-90)*deg;
end  
    
if iupr==0
Iu=8;      % ��� ��������������, ���/�
iu=Iu*exp(fiu*j);
plot([0 real(iu)],[0 imag(iu)],'g')
else 
    ru=0;
    Iu=abs(e1)/(xu*al+ru);
    iu=Iu*exp(fiu*j);
    plot([0 real(iu)],[0 imag(iu)],'g')
end
       
             
             % ������ I2 !������� ��� �������!`
i2pr=0; % 0-�� ����������, 1 - �� �������

if i2pr==0 
    i2=iu-i1;
    I2=abs(i2);
    ai2p=real(i1);
    bi2p=imag(i1);
    plot([ai2p real(iu)],[bi2p imag(iu)],'r')
else
    I2=abs(e1)/(x2p*al+r2p/s);
    %I2=Ip/Kr;
    ali2=atan(x2p*al*s/r2p)/deg;
    fi2=(90-a1i2)*deg;
    i2=I2*exp(fi2*j);
    ai2=real(i1);
    bi2=imag(i1);
    plot([ai2 real(-i2)+ai2],[bi2 imag(-i2)+bi2],'r')
end

% ������ I2`x2
ai2x2=real(e1);
bi2x2=imag(e1);
ali2x2=real(i2)/imag(i2);
fi2px2=-atan(ali2x2);
i2px2=I2*x2p*exp(fi2px2);
plot([ai2x2 real(i2px2)+ai2x2],[bi2x2 imag(i2px2)+bi2x2],'y')

% ������ U2`
u2p=e1+i2px2;
plot([0 real(u2p)],[0 imag(u2p)],'m')

% ������ E2
%plot([0 -real(e1)],[0 -imag(e1)])

title('��������� ��������� ��-��');
text(Iu-0.5, -1.5,'Iu','color','g')
text(Iu+0.2, -imag(i2),'I2`','color','r')
text(real(i1)-0.5, imag(i1)*1.4,'I1','color','b')
text(real(e1),imag(e1),'-E1','color','c')
text(I2*x2p*0.5,imag(u2p)+5,'I2`x2','color','y')
text(real(u2p),imag(u2p),'U2`','color','m')
text(real(u1p),imag(u1p)*0.9,'U1`','color','k')
text(real(u1)*0.9,imag(u1)*0.85,'U1','color','r')
text(-real(i1r1)*0.5,imag(u1),'I1r1','color','g')
%text(0,-E1,'E2`','color','m')
text(real(u1p)+2,E1+4,'I1x1','color','r')
