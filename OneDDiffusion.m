%Clears everything from before
clear all;
clc


% Dquail = 24mm, Dchicken = 54mm, Dostritch = 126mm
Diameter = 54;
radius = Diameter/2;

%Each step in x will be one millimeter
dx = 1;

dt = 1;
%time steps will be handled in the while loop

%: means all elements in that dimension
x_slots = Diameter/dx;
%initializing
T = ones(x_slots,25000);

%Setting up initial conditions
%We take the egg out of the fridge
%T(r,t)
T(:,1)= 10;

%lol gotta be sure to set up boundary conditions AFTER initial conditions

%Setting boundary conditions
%We put the egg in the water
T(1,:) = 100;
T(end,:)= 100;




alpha = 0.146;


k = 1;
Middle = x_slots/2;

F = (alpha*dt)/(dx^2);

check = 1-(2*F);


if check > 0
    %We let it cook until it reaches 80C
    while T(Middle,k) < 80

        for i = 2:(x_slots-1)
            %with each time step, the insides change somewhat
            T(i,k+1)=((1-(2*F))*T(i,k))+(F*T(i+1,k))+(F*T(i-1,k));
            

        end
        %but I reset them here anyway just incase
        T(1,:) = 100;
        T(end,:)= 100;
        
        hold on
        plot(T(:,k))
%         pause(0.5);
            
        
        k = k+1;
        
%         b = mod(k,10);
%         TF = isinteger(b);

             
    end
else 
    error = "Your time or x step is bad, fix it";
    disp(error)
end

time = k*dt;
total_time = time +10;



        









        



