clear all
clc
%% initialization
gamma=0.5;
alpha=1;
beta=1;
epsilon=0.1;
p_s_a=ones(6,2).*(1/2);
ep=50;
Q=zeros(6,2); %Q(s,a)
V=zeros(6,1);
visited=zeros(6,2);
%% the loop for episode
for episode_no=1:ep,
    state=randi([2 5],1,1);    
    if(rand>epsilon)
        [value,action]=max(Q(state,:));
    else
        action=randi([1 2],1,1);    
    end    
    episode=state;
    steps(episode_no)=0;
    %% the loop for each step of the episode
    while(state~=1 && state~=6)       
       [nextstate,reward]=garbageEnv(action,state);
       steps(episode_no)=steps(episode_no)+1;
       if(rand>epsilon)
           [value,nextaction]=max(Q(nextstate,:));
       else
           nextaction=randi([1 2],1,1);
       end
       episode=[episode,nextstate];       
       Q(state,action)=Q(state,action)+alpha*(reward+(gamma*V(nextstate))-Q(state,action));
       V(state)=V(state)+beta*(reward+(gamma*V(nextstate))-V(state));       
       state=nextstate;
       action=nextaction;
       visited(state,action)=visited(state,action)+1;           
    end
    epsilon=0.99*epsilon;
    disp(['Episode #' num2str(episode_no) ':']);
    disp(episode);
    disp(['Qs in Episode #' num2str(episode_no) ':']);
    disp(Q);
    disp(['values in Episode #' num2str(episode_no) ':']);
    disp(V);
end
%% the achieved policy
for i=1:6,
    [value,policy(i)]=max(Q(i,:));
end
disp('policy:');
disp(policy(2:end-1));
disp('average steps:');
disp(sum(steps)/ep);
%% steps after training 
for test_s=2:5,
    Teststeps(test_s)=0;
    s=test_s;
    while(s~=6 && s~=1)
        Teststeps(test_s)=Teststeps(test_s)+1;
        [next_s,~]=garbageEnv(policy(s),s);
        s=next_s;
    end
end
disp('test steps:');
disp(Teststeps(2:end));
