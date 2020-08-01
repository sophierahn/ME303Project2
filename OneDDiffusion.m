%Clears everything from before
clear all
clc


% Dquail = 24mm, Rchicken = 54mm, Rostritch = 126mm
Diameter = 24;
radius = Diameter/2;

%Each step in x will be one millimeter
dx = 1;

dt = 0.1;
%time steps will be handled in the while loop

%: means all elements in that dimension
x_slots = Diameter/dx;
%initializing
T = ones(x_slots,1000);


%Setting up initial conditions
%We take the egg out of the fridge
T(:,1)= 10;

%lol gotta be sure to set up boundary conditions AFTER initial conditions

%Setting boundary conditions
%We put the egg in the water
T(1,:) = 100;
T(x_slots,:)= 100;



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
Middle = x_slots/2;
endTime = 100000;
checked = 0;

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
        T(100,:)= 100;
            
        
        k = k+1;
             
    end
else 
    error = "Your time or x step is bad, fix it";
    disp(error)
end

time = k*dt;
total_time = time +10;

plot(T)

% Don't really need to, I mean the center isn't going to cool in the water
% %We cook it for 10 more seconds
%     while extra_time < 10
% 
%         for i = 2:9
%             %with each time step, the insides change somewhat
%             T(i,k+1)=((1-(2*F))*T(i,k))+(F*T(i+1,k))+(F*T(i-1,k));
%             
% 
%         end
%         %but I reset them here anyway just incase
%         T(1,:) = 100;
%         T(100,:)= 100;
%         
%         extra_time = w*dt;
%         w = w+1;
%         
%         k = k+1;
%              
%     end

    
    
        



