%ME 303 Project 2
%Question 2 part 1
%Cooling flatbread with DBCs
%Written by Sophia Rahn


%Clear everything
clc
clear all;

%Dimensional Limits
y_limit = 1;
x_limit = 1;
t_limit = 0.1; % but also as long as we want

%Time step
dt = 0.00001;

%Number of discrete samples
y_slots = 100;
x_slots = 100;
t_slots = round(t_limit/dt,0);

%Creating linearly spaced dimensional vectors
x = linspace(0,x_limit, x_slots);
y = linspace(0,y_limit,y_slots);

%Done to improve readibility of the final array print
y = transpose(y);


%Dimensional steps
dx = x(2)-x(1);
dy = y(2)-y(1);

%Initializing T(x,y,t)for the number of samples
T = ones(x_slots,y_slots,t_slots);

%Doing some math before it's needed
X = pi.*x;
Y = (4*pi).*y;

%ICs
T(:,:,1) = T(:,:,1).*sin(X).*sin(Y);

%Transposing dimensional vectors for proper array multiplication
X = transpose(X);
X2 = (2*pi).*x;
X2 = transpose(X2);

%BCs
T(1,:,:) = 0;
T(end,:,:) = 0;
T(:,1,:) = T(:,1,:).*sin(X);
T(:,end,:) = T(:,end,:).*(cos(X2)-1);
    
%Constants
F = dt/(dx^2);
G = dt/(dy^2);



%Iterative calculation of T(i,j,k)
for k=1:t_slots %iterating through time
    for i = 2:(x_slots-1) %iterating through x
        for j = 2:(y_slots-1) %iterating through y
            T(i,j,k+1) = (F*(T(i+1,j,k)-(2*T(i,j,k))+T(i-1,j,k)))+(G*(T(i,j+1,k)-(2*T(i,j,k))+T(i,j-1,k)))+T(i,j,k);
        end
    end
    
%BCs to ensure they were not overwritten
T(1,:,:) = 0;
T(end,:,:) = 0;
T(:,1,k+1) = sin(X);
T(:,end,k+1) = (cos(X2)-1);

%Plotting the temperature array
surf(T(:,:,k+1));
title('Temperature vs Space iterating through Time');
xlabel('X');
ylabel('Y');
zlabel('Temperature');
pause(0.1);

end
