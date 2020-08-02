%Clears everything from before
clc
clear all

% Limits
y_limit = 1;
x_limit = 1;
t_limit = 0.1; % but also infinity

dt = 0.001;

y_slots = 10;
x_slots = 10;
t_slots = round(t_limit/dt,0);

x = linspace(0,x_limit, x_slots);
y = linspace(0,y_limit,y_slots);
y = transpose(y);

dx = x(2)-x(1);
dy = y(2)-y(1);

%T(x,y,t)
T = ones(x_slots,y_slots,t_slots);

%doing some math ahead of time
X = pi.*x;
Y = (4*pi).*y;

%ICs
T(:,:,1) = T(:,:,1).*sin(X).*sin(Y);

X = transpose(X);
X2 = (2*pi).*x;
X2 = transpose(X2);

%BCs
T(:,1,:) = 1;
T(:,end,:) = -1;
    
%constants
F = dt/(dx^2);
G = dt/(dy^2);
N1 = 0;
N2 = 2;



%Iterative calculation of T(i,j)
for k=1:t_slots
    for i = 1:(x_slots)
        for j = 2:(y_slots-1)
            if i == x_slots
                T(i,j,k+1) = (F*(((2*N2*dx)+T(i-1,j,k))-(2*T(i,j,k))+T(i-1,j,k)))+(G*(T(i,j+1,k)-(2*T(i,j,k))+T(i,j-1,k)))+T(i,j,k);
            
            elseif i == 1
                    T(i,j,k+1) = (F*(((2*N1*dx)+T(i+1,j,k))-(2*T(i,j,k))+T(i+1,j,k)))+(G*(T(i,j+1,k)-(2*T(i,j,k))+T(i,j-1,k)))+T(i,j,k);
          
                
            else
                T(i,j,k+1) = (F*(T(i+1,j,k)-(2*T(i,j,k))+T(i-1,j,k)))+(G*(T(i,j+1,k)-(2*T(i,j,k))+T(i,j-1,k)))+T(i,j,k);
            
            end
       end
    end
    
%BCs
    T(:,1,k+1) =1;
    T(:,end,k+1) = -1;

surf(T(:,:,k+1));
pause(0.1);

end
% j= ones(x_slots,y_slots);
% j(:,:) = T(:,:,1);
% heatmap(j,'colormap', hot)

% surf(T(:,:,end));