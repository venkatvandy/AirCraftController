function ASorted = path_finder( xcurr,ycurr,xdst,ydst,theta,message,aircraft_no)

    %distancePoints = [xdst,ydst;xcurr,ycurr];
    %currentDistance = pdist(distancePoints,'euclidean');
    ASorted = zeros(3,2);
    ASortedOpposite = zeros(3,2);
	currentDistance = (xdst-xcurr) + (ydst-ycurr);
	
    % Calculates the next coordinates based on the theta and current coordinates
    if( ~(currentDistance == 0))
        
        if( theta == 0 || theta == 360)
            xf = 1;
            yf = 0;
            xr = 0;
            yr = -1;
            xl = 0;
            yl = 1;
            
        elseif(theta == 90)
            xf = 0;
            yf = 1;
            xr = 1;
            yr = 0;
            xl = -1;
            yl = 0;            
        elseif(theta == 180)
            xf = -1;
            yf = 0;
            xr = 0;
            yr = 1;
            xl = 0;
            yl = -1;
        elseif(theta == 270)
            xf = 0;
            yf = -1;
            xr = -1;
            yr = 0;
            xl = 1;
            yl = 0;
        end
		
        %Calculating step distance from current position to the destination
        currentDistanceF = abs(xdst-(xcurr+xf))+abs(ydst-(ycurr+yf));
        currentDistanceL = abs(xdst-(xcurr+xl))+abs(ydst-(ycurr+yl));
        currentDistanceR = abs(xdst-(xcurr+xr))+abs(ydst-(ycurr+yr));
			
		ASorted(1,1) = currentDistanceL;
		ASorted(2,1) = currentDistanceR;
		ASorted(3,1) = currentDistanceF;
        
		ASorted(1,2) = 1 ; 
		ASorted(2,2) = -1 ; 
		ASorted(3,2) = 0; 
    
        
		%Sorting the distances to find the minimum possible distance and if step distances are equal then we check for euclidean distances
        
            for i=1:3
                for j=(i+1):3
                    if ( ASorted(i,1) > ASorted(j,1))
                        temp=ASorted(i,1);
                        ASorted(i,1)=ASorted(j,1);
                        ASorted(j,1) = temp;
                    
                        temp=ASorted(i,2);
                        ASorted(i,2)=ASorted(j,2);
                        ASorted(j,2) = temp;
                    end
                end
            end
        
            if( ~isempty(message) && aircraft_no==2)
                if( message.theta == 0 || message.theta == 360)
                    xf = 1;
                    yf = 0;
                    xr = 0;
                    yr = -1;
                    xl = 0;
                    yl = 1;
            
                elseif(message.theta == 90)
                    xf = 0;
                    yf = 1;
                    xr = 1;
                    yr = 0;
                    xl = -1;
                    yl = 0;            
                elseif(message.theta == 180)
                    xf = -1;
                    yf = 0;
                    xr = 0;
                    yr = 1;
                    xl = 0;
                    yl = -1;
                elseif(message.theta == 270)
                    xf = 0;
                    yf = -1;
                    xr = -1;
                    yr = 0;
                    xl = 1;
                    yl = 0;
            end
		
        %Calculating step distance from current position to the destination
        oppDistanceF = abs(message.xd-(message.x+xf))+abs(message.y-(message.y+yf));
        oppDistanceL = abs(message.xd-(message.x+xl))+abs(message.yd-(message.y+yl));
        oppDistanceR = abs(message.xd-(message.x+xr))+abs(message.yd-(message.y+yr));
        
        ASortedOpposite(1,1) = oppDistanceL;
		ASortedOpposite(2,1) = oppDistanceR;
		ASortedOpposite(3,1) = oppDistanceF;
        
        
		ASortedOpposite(1,2) = 1 ; 
		ASortedOpposite(2,2) = -1 ; 
		ASortedOpposite(3,2) = 0; 
            
                for i=1:3
                    for j=(i+1):3
                        if ( ASortedOpposite(i,1) > ASortedOpposite(j,1))
                            temp=ASortedOpposite(i,1);
                            ASortedOpposite(i,1)=ASortedOpposite(j,1);
                            ASortedOpposite(j,1) = temp;
                    
                            temp=ASortedOpposite(i,2);
                            ASortedOpposite(i,2)=ASortedOpposite(j,2);
                            ASortedOpposite(j,2) = temp;
                        end
                    end
                end
            
                % calculate position of plane 1
                
                position_plane1= message;
             theta_plane1 = wrapTo360(ASortedOpposite(1,2)*90 + message.theta);
    
            if(message.x == message.xd && message.y == message.yd)
                position_plane1.x = message.x;
                position_plane1.y = message.y;
            elseif(theta_plane1 == 0 || theta_plane1 == 360)
                position_plane1.x = message.x + 1;
            elseif(theta_plane1 == 90)
                position_plane1.y = message.y + 1;
            elseif(theta_plane1 == 180)
                position_plane1.x = message.x - 1;
            elseif(theta_plane1 == 270)
                position_plane1.y = message.y - 1;
            end
            position_plane1.theta = theta_plane1;
            
            % choose left/right/front of plane2 based on new position of
            % plane1
              
            % take - 1st choice of plane2- if it collides with plane1
            % choose 2nd option 
            position_plane2.x = xcurr;
            position_plane2.y = ycurr;
            position_plane2.xd= xdst;
            position_plane2.yd= ydst;
            
            theta_plane2 = wrapTo360(ASorted(1,2)*90 + theta);
            
                if(theta_plane2 == 0 || theta_plane2 == 360)
                    position_plane2.x = position_plane2.x + 1;
                elseif(theta_plane2 == 90)
                    position_plane2.y = position_plane2.y + 1;
                elseif(theta_plane2 == 180)
                    position_plane2.x = position_plane2.x - 1;
                elseif(theta_plane2 == 270)
                    position_plane2.y = position_plane2.y - 1;
                end
                
                position_plane2.theta = theta_plane2;
                
                %choose 2nd option
                if((position_plane2.x== position_plane1.x) && (position_plane2.y== position_plane1.y))
                            temp=ASorted(1,1);
                            ASorted(1,1)=ASorted(2,1);
                            ASorted(2,1) = temp;
                            
                            temp=ASorted(1,2);
                            ASorted(1,2)=ASorted(2,2);
                            ASorted(2,2) = temp;
                end
       end
end