%% initialization
gamma=0.5;
alpha=1;
p_s_a=ones(6,2).*(1/2);
ep=50;
V=zeros(1,6);
s=3;
%% the loop for episode
for episode_no=1:ep,
    s=randi([2 5],1,1);
    state=s;
    episode=s;
    %% the loop for each step of the episode
    while(state~=1 && state~=6)      
       action=randi([1 2],1,1);
       [nextstate,reward]=garbageEnv(action,state);
       episode=[episode,nextstate];
       V(state)=V(state)+alpha*(reward+(gamma*V(nextstate))-V(state));
       state=nextstate;
       
    end
    disp(['Episode #' num2str(episode_no) ':']);
    disp(episode);
    disp(['Values in Episode #' num2str(episode_no) ':']);
    disp(V);
end
