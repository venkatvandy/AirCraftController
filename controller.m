 function [ out, state ] = controller( in, state,aircraft_no )
% Takes flight parameters of an aircraft and outputs the direction control

% in: Data Structure that stores input information for the aircraft
% controller. 
%       (in.x, in.y): Current Location of the aircraft
%       (in.xd, in.yd): Destination of aircraft
%       in.theta: Current direction of motion
%       in.m: Message from neighbouring aircraft 
%           - empty if aircraft not in neighbourhood
%           - (x, y, xd, yd, theta) of other aircraft if non-empty
%           - To access data (say x) from in.m, use in.m.x
%
% out : Data Structure that stores the output information from the aircraft
%       out.val: +1, 0, -1 ( +1 - turn left, 0 - go straight, -1 - turn right)
% 
% state: 
%       any state used by the controller

% out1= zeros(4,3);
% 
% [out1,flag1] = nextMove(in.x,in.y,in.xd,in.yd,in.theta);
% 
% out.val = out1(1,1);
% state.mode = out1(1,1);

out.val = path_finder(in.x,in.y,in.xd,in.yd,in.theta,in.m,in,aircraft_no);

state.mode = out.val;


%[out2,flag2] = nextMove(in(2).x,in(2).y,in(2).xd,in(2).yd,in(2).theta);

% % Initialize state
% if (isempty(state))
%     state.mode = 0; 
% end
% 
% % Code to generate controller output
% if (state.mode == 0)
%     out.val = +1;
%     state.mode = 1;
% elseif (state.mode == 1)
%     out.val = 0;
%     state.mode = 0;
% end