function selected_value = path_finder( in,message,aircraft_no)

    ASorted = zeros(3,2);
    ASortedOpposite = zeros(3,2);
    points = [in.xd,in.yd;in.x,in.y];
    distance = pdist(points,'euclidean');
    selected_value=0;
	
    % Calculates the next coordinates based on the theta and current coordinates
    if( ~(distance == 0))
        
        if( in.theta == 0 || in.theta == 360)
         
			 currentDistanceF = abs(in.xd-(in.x+1))+abs(in.yd-in.y);
			 currentDistanceR = abs(in.xd-in.x)+abs(in.yd-(in.y-1));
			 currentDistanceL = abs(in.xd-in.x)+abs(in.yd-(in.y+1));
				 
        elseif(in.theta == 90)
       	
			currentDistanceF = abs(in.xd-in.x)+abs(in.yd-(in.y+1));
			currentDistanceR = abs(in.xd-(in.x+1))+abs(in.yd-in.y);
			currentDistanceL = abs(in.xd-(in.x-1))+abs(in.yd-in.y);
		 
        elseif(in.theta == 180)
       	
			currentDistanceF = abs(in.xd-(in.x-1))+abs(in.yd-in.y);
			currentDistanceR = abs(in.xd-in.x)+abs(in.yd-(in.y+1));
			currentDistanceL = abs(in.xd-in.x)+abs(in.yd-(in.y-1));
        
		elseif(in.theta == 270)
       
			currentDistanceF = abs(in.xd-in.x)+abs(in.yd-(in.y-1));
			currentDistanceR = abs(in.xd-(in.x-1))+abs(in.yd-in.y);
			currentDistanceL = abs(in.xd-(in.x+1))+abs(in.yd-in.y);
		 
        end
		    
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
        
            if( ~isempty(message) && mod(aircraft_no,2)==0)
                if( message.theta == 0 || message.theta == 360)
        			
					oppDistanceF = abs(message.xd-(message.x+1))+abs(message.yd - message.y);
					oppDistanceR = abs(message.xd - message.x)+abs(message.yd-(message.y-1));
					oppDistanceL = abs(message.xd - message.x)+abs(message.yd-(message.y+1));

            
                elseif(message.theta == 90)
        			oppDistanceF = abs(message.xd - message.x)+abs(message.yd-(message.y+1));
					oppDistanceR = abs(message.xd-(message.x+1))+abs(message.yd-message.y);
					oppDistanceL = abs(message.xd-(message.x-1))+abs(message.yd-message.y);

                elseif(message.theta == 180)
        			
					oppDistanceF = abs(message.xd-(message.x-1))+abs(message.yd - message.y);
					oppDistanceR = abs(message.xd - message.x)+abs(message.yd-(message.y+1));
					oppDistanceL = abs(message.xd - message.x)+abs(message.yd-(message.y-1));

                elseif(message.theta == 270)
        			
					oppDistanceF = abs(message.xd - message.x)+abs(message.yd-(message.y-1));
					oppDistanceR = abs(message.xd-(message.x-1))+abs(message.yd - message.y);
					oppDistanceL = abs(message.xd-(message.x+1))+abs(message.yd - message.y);

            end
		
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
 
               for i=1:3
                   
                   	if(find_possible_path(ASorted(i,2),in,ASortedOpposite(i,2),in.m))
						selected_value = ASorted(i,2);
                        break;
                    end
                   
               end
              
       end
end