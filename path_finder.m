function selected_value = path_finder( xcurr,ycurr,xdst,ydst,theta,message,in)

    %distancePoints = [xdst,ydst;xcurr,ycurr];
    %currentDistance = pdist(distancePoints,'euclidean');
    ASorted = zeros(3,2);
    ASortedOpposite = zeros(3,2);
	currentDistance = (xdst-xcurr) + (ydst-ycurr);
    selected_value=0;
	
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
			selected_value = ASorted(1,2); 
        
            if( ~isempty(message))
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
        oppDistanceF = abs(message.xd-(message.x+xf))+abs(message.yd-(message.y+yf));
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
            
                % calculate position of other plane
               flag=false;
               for i=1:3
                   for j=1:3
						if(find_possible_path(ASorted(i,2),in,ASortedOpposite(j,2),in.m))
							selected_value = ASorted(i,2);
                            flag=true;
                            break;
                        end
                   end
                   if(flag)
                       break;
                   end
               end
              
       end
end