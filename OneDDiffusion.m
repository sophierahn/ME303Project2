%Clears everything from before
clear all
clc


% Dquail = 24mm, Rchicken = 54mm, Rostritch = 126mm
Diameter = 24/1000;
radius = Diameter/2;

%Discretizing x to be 100 points between 0 and 1
x=linspace(0,Diameter,10);

%For reference, if Quail dx = 0.0026. If Chicken dx = 0.0060
%If Ostritch dx = 0.0139

dx=x(2)-x(1);

dt = 0.000001;
%time steps will be handled in the while loop

%: means all elements in that dimension

%initializing
T = ones(10,10000);
T_guess = ones(10,100000);


%Setting up initial conditions
%We take the egg out of the fridge
T(:,1)= 10;

%lol gotta be sure to set up boundary conditions AFTER initial conditions

%Setting boundary conditions
%We put the egg in the water
T(1,:) = 100;
T(10,:)= 100;



%choosing the egg type
%Choose 1 for quail, 2 for chicken, and 3 for ostrich
%Data from https://www.sciencedirect.com/science/article/pii/S0260877405001330
%alpha is in units Watts/meter*Kelvin
% egg_type = 1;
% if egg_type == 1
%     water_content = 0.518;
%     alpha = 0.407;
%     
% else if egg_type == 2
%         water_content = 0.736;
%         alpha = 0.493;
%         
%     else if egg_type == 3
%             water_content = 0.882;
%             alpha = 0.554;
%         else 
%             printf("This isn't going to work if you don't pick an egg type you turkey");
%         end
%     end
% end


alpha = 1;

k = 1;
Middle = 0;
time = 0;
endTime = 100000;
checked = 0;

F = (alpha*dt)/(dx^2);

check = 1-(2*F);

if check > 0
    %We let it cook
    while k <= endTime

        for i = 2:9
            %with each time step, the insides change somewhat
            T(i,k+1)=((1-(2*F))*T(i,k))+(F*T(i+1,k))+(F*T(i-1,k));
            

        end
        %but I reset them here anyway just incase
        T(1,:) = 100;
        T(100,:)= 100;
        
        %checking the center
        Middle = T(5,k);
        if Middle >= 80 && checked == 0
            time = k*dt;
            checked = 1;%need to turn the center checker off
            endTime = k + (10/dt);
        end
            
        
        k = k+1;
             
    end
else 
    error = "Your time or x step is bad, fix it";
    disp(error)
end
disp(time)





        



