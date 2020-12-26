clear all
clc

% Initialization
S=1; M=2; N=3; C=4; A=5; G=6;O=9;
s=11;m=12;n=13;c=14;a=15;g=16;o=19;
piece_list={'£Ó'  '£Í' '£Î' '£Ã' '£Á' '£Ç' 0 0 '£Ï' 0 '£ó' '£í' '£î' '£ã' '£á' '£ç' 0 0 '£ï' '¡«' '£«'};

s_group=[S M N C A G O];
n_group=[s m n c a g o];
n_S4=1;n_S6=1;
n_N4=1;n_N6=1;
s_p4=zeros(1,14);s_p6=zeros(1,14);
n_p4=zeros(1,14);n_p6=zeros(1,14);
board_init=[
    c n m 21 g 21 m n c;...
    0 a 0 0 0 0 0 a 0;...
    s 0 s 0 s 0 s 0 s;...
    0 0 0 0 0 0 0 0 0;...
    20 20 20 20 20 20 20 20 20 ;...
    0 0 0 0 0 0 0 0 0;...
    S 0 S 0 S 0 S 0 S;...
    0 A 0 0 0 0 0 A 0;...
    C N M 21 G 21 M N C
    ];

board_num=board_init;
lft_indx={'£±' '£ü';'£²' '£ü'; '£³' '£ü' ;'£´' '£ü' ;'£µ' '£ü' ;'£¶' '£ü' ; '£·' '£ü'; '£¸' '£ü' ;'£¹' '£ü'};
up_indx={'£±' '£²' '£³' '£´' '£µ' '£¶' '£·' '£¸' '£¹';'£º' '£º' '£º' '£º' '£º' '£º' '£º' '£º' '£º'  };
lft_up_crnr={'£°' '£ü';'£º'  '£ü' };
%===================================================================
while(1)
    % Initialize the board
    for row=1:9
        for col=1:9
            piece_num=board_num(row,col);
            switch piece_num
                case 0
                    piece='£­';
                otherwise
                    piece=piece_list{piece_num};
            end
            board_raw{row,col}=piece;
        end
    end
    board=[lft_up_crnr up_indx;lft_indx board_raw];
    % Print N_prison
    if sum(n_p4)==0
        fprintf('North 4 Prison: N/A \n')
    else
        fprintf('North 4 Prison:')
        for n_np=1:(n_N4-1)
            fprintf('%s ',piece_list{n_p4(n_np)})
        end
        fprintf('\n')
    end
    if sum(n_p6)==0
        fprintf('North 6 Prison: N/A \n')
    else
        fprintf('North 6 Prison:')
        for n_np=1:(n_N6-1)
            fprintf('%s ',piece_list{n_p6(n_np)})
        end
        fprintf('\n')
    end
    fprintf('\n')
    % Print the board
    for row=1:11
        for col=1:11
            fprintf('%s',board{row,col})
        end
        fprintf('\n')
    end
    fprintf('\n')
    % Print S_prison
    if sum(s_p4)==0
        fprintf('South 4 Prison: N/A \n')
    else
        fprintf('South 4 Prison:')
        for n_sp=1:(n_S4-1)
            fprintf('%s ',piece_list{s_p4(n_sp)})
        end
        fprintf('\n')
    end
    if sum(s_p6)==0
        fprintf('South 6 Prison: N/A \n')
    else
        fprintf('South 6 Prison:')
        for n_sp=1:(n_S6-1)
            fprintf('%s ',piece_list{s_p6(n_sp)})
        end
        fprintf('\n')
    end
    fprintf('\n')
    
    % Winning check
    flag_S=0; flag_N=0;
    for row=1:9
        for col =1:9
            if board_num(row,col)==G
                flag_S=1;
            end
            if board_num(row,col)==g
                flag_N=1;
            end
        end
    end
    if flag_S==0
        fprintf('==North win==\n')
        break
    elseif flag_N==0
        fprintf('==South win==\n')
        break
    end
    %===================================================================
    while(1)
        % Input
        fprintf('=====================\n')
        fprintf('E.g.  S (7,1) to (6,1) >>> [S 7 1 6 1]\n')
        fprintf('Quit: >>> 1001.\n')
        result_general= input('>>>  ');
        flag_move=0;
        flag_break=0;
        R=0;
        
        % Quit check
        if result_general==1001
            break
        end
        % GOLDEN FINGER
        if length(result_general)==4 && result_general(4)==1029
            board_num(result_general(2),result_general(3))=result_general(1);
            break
        end
        %  Insufficient check
        if length(result_general)==5 ;
            p=result_general(1); i1=result_general(2);j1=result_general(3);i2=result_general(4); j2=result_general(5);
            % Out-of-board and double-place check
            if i1>=1 && i1<=9 && i2>=1 && i2<=9 && board_num(i1,j1)==p && ...
                    ( (ismember(p,s_group)==1 && ismember(board_num(i2,j2),s_group)==1)==0 ||...
                    (ismember(p,n_group)==1 && ismember(board_num(i2,j2),n_group)==1)==0)
                switch p
                    case 1  % S
                        if ((i1-i2)==1 && (j2-j1)==0) || ((i2-i1)==0 && abs(j2-j1)==1)
                            flag_move=1;
                        end
                    case 2  % M
                        if (abs(i2-i1)==abs(j2-j1)) && ((i2-5)*(i1-5)>=0)
                            % - Check no block
                            l_i=abs(i2-i1)+1; l_j=abs(j2-j1)+1;
                            if i1==i2
                                p1=i1*ones(1,l_j);
                            else
                                p1=i1:(i2-i1)/(l_i-1):i2;
                            end
                            if j1==j2
                                q1=j1*ones(1,l_i);
                            else
                                q1=j1:(j2-j1)/(l_j-1):j2;
                            end
                            for n_R=1:length(p1)
                                R(n_R)=board_num(p1(n_R),q1(n_R));
                            end
                            if sum(R)==(board_num(i1,j1)+board_num(i2,j2));
                                flag_move=1;
                            end
                        end
                    case 3  % N
                        if (abs(i2-i1)==2 && abs(j1-j2)==1) || (abs(i2-i1)==1 && abs(j1-j2)==2)
                            flag_move=1;
                        end
                    case 4  % C
                        if ((((i1-i2)==0 && abs(j1-j2)>=1) || (abs(i1-i2)>=1 && (j1-j2)==0)) && ((i2-5)*(i1-5)>=0) && i1~=5)||...
                                ((((i1-i2)==0 && abs(j1-j2)==1) || (abs(i1-i2)>=1 && (j1-j2)==0)) && i1==5)
                            % - Check no block
                            l_i=abs(i2-i1)+1; l_j=abs(j2-j1)+1;
                            if i1==i2
                                p1=i1*ones(1,l_j);
                            else
                                p1=i1:(i2-i1)/(l_i-1):i2;
                            end
                            if j1==j2
                                q1=j1*ones(1,l_i);
                            else
                                q1=j1:(j2-j1)/(l_j-1):j2;
                            end
                            for n_R=1:length(p1)
                                R(n_R)=board_num(p1(n_R),q1(n_R));
                            end
                            if sum(R)==(board_num(i1,j1)+board_num(i2,j2));
                                flag_move=1;
                            end
                        end
                    case 5  % A
                        if (((abs(i1-i2)>=1 && abs(i1-i2)<=3 && (j1-j2)==0)||(abs(j1-j2)>=1 && abs(j1-j2)<=3 && (i1-i2)==0) || (abs(i2-i1)==abs(j2-j1) && abs(j1-j2)>=1 && abs(j1-j2)<=3)) && ((i2-5)*(i1-5)>=0) && i1~=5) ||...
                                (((abs(i1-i2)>=1 && abs(i1-i2)<=3 && (j1-j2)==0)||(abs(j1-j2)==1  && (i1-i2)==0) || (abs(i2-i1)==abs(j2-j1) && abs(j1-j2)>=1 && abs(j1-j2)<=3)) && i1==5)
                            % - Check no block
                            l_i=abs(i2-i1)+1; l_j=abs(j2-j1)+1;
                            if i1==i2
                                p1=i1*ones(1,l_j);
                            else
                                p1=i1:(i2-i1)/(l_i-1):i2;
                            end
                            if j1==j2
                                q1=j1*ones(1,l_i);
                            else
                                q1=j1:(j2-j1)/(l_j-1):j2;
                            end
                            for n_R=1:length(p1)
                                R(n_R)=board_num(p1(n_R),q1(n_R));
                            end
                            if sum(R)==(board_num(i1,j1)+board_num(i2,j2));
                                flag_move=1;
                            end
                        end
                    case 6  % G
                        if (abs(j2-j1)==1  || abs(i2-i1)==1)  && i2>=7
                            flag_move=1;
                        end
                    case 9  % O
                        if (abs(j2-j1)==1 && (i2-i1)==0) || ((j2-j1)==0 && abs(i2-i1)==1)
                            flag_move=1;
                        end
                    case 11 % s
                        if ((i2-i1)==1 && (j2-j1)==0) || ((i2-i1)==0 && abs(j2-j1)==1)
                            flag_move=1;
                        end
                    case 12 % m
                        if (abs(i2-i1)==abs(j2-j1)) && ((i2-5)*(i1-5)>=0)
                            flag_move=1;
                        end
                    case 13 % n
                        if (abs(i2-i1)==2 && abs(j1-j2)==1) || (abs(i2-i1)==1 && abs(j1-j2)==2)
                            % - Check no block
                            l_i=abs(i2-i1)+1; l_j=abs(j2-j1)+1;
                            if i1==i2
                                p1=i1*ones(1,l_j);
                            else
                                p1=i1:(i2-i1)/(l_i-1):i2;
                            end
                            if j1==j2
                                q1=j1*ones(1,l_i);
                            else
                                q1=j1:(j2-j1)/(l_j-1):j2;
                            end
                            for n_R=1:length(p1)
                                R(n_R)=board_num(p1(n_R),q1(n_R));
                            end
                            if sum(R)==(board_num(i1,j1)+board_num(i2,j2));
                                flag_move=1;
                            end
                        end
                    case 14 % c
                        if ((((i1-i2)==0 && abs(j1-j2)>=1) || (abs(i1-i2)>=1 && (j1-j2)==0)) && ((i2-5)*(i1-5)>=0) && i1~=5)||...
                                ((((i1-i2)==0 && abs(j1-j2)==1) || (abs(i1-i2)>=1 && (j1-j2)==0)) && i1==5)
                            % - Check no block
                            l_i=abs(i2-i1)+1; l_j=abs(j2-j1)+1;
                            if i1==i2
                                p1=i1*ones(1,l_j);
                            else
                                p1=i1:(i2-i1)/(l_i-1):i2;
                            end
                            if j1==j2
                                q1=j1*ones(1,l_i);
                            else
                                q1=j1:(j2-j1)/(l_j-1):j2;
                            end
                            for n_R=1:length(p1)
                                R(n_R)=board_num(p1(n_R),q1(n_R));
                            end
                            if sum(R)==(board_num(i1,j1)+board_num(i2,j2));
                                flag_move=1;
                            end
                        end
                    case 15 % a
                        if  (((abs(i1-i2)>=1 && abs(i1-i2)<=3 && (j1-j2)==0)||(abs(j1-j2)>=1 && abs(j1-j2)<=3 && (i1-i2)==0) || (abs(i2-i1)==abs(j2-j1) && abs(j1-j2)>=1 && abs(j1-j2)<=3)) && ((i2-5)*(i1-5)>=0) && i1~=5) ||...
                                (((abs(i1-i2)>=1 && abs(i1-i2)<=3 && (j1-j2)==0)||(abs(j1-j2)==1  && (i1-i2)==0) || (abs(i2-i1)==abs(j2-j1) && abs(j1-j2)>=1 && abs(j1-j2)<=3)) && i1==5)
                            % - Check no block
                            l_i=abs(i2-i1)+1; l_j=abs(j2-j1)+1;
                            if i1==i2
                                p1=i1*ones(1,l_j);
                            else
                                p1=i1:(i2-i1)/(l_i-1):i2;
                            end
                            if j1==j2
                                q1=j1*ones(1,l_i);
                            else
                                q1=j1:(j2-j1)/(l_j-1):j2;
                            end
                            for n_R=1:length(p1)
                                R(n_R)=board_num(p1(n_R),q1(n_R));
                            end
                            if sum(R)==(board_num(i1,j1)+board_num(i2,j2));
                                flag_move=1;
                            end
                        end
                    case 16 % g
                        if (abs(j2-j1)==1  || abs(i2-i1)==1)&& i2<=3
                            flag_move=1;
                        end
                    case 19 % o
                        if (abs(j2-j1)==1 && (i2-i1)==0) || ((j2-j1)==0 && abs(i2-i1)==1)
                            flag_move=1;
                        end
                end
            end
        end
        %===================================================================
        if flag_move==1
            % Promotion
            if p==1 && i2==1
                p=9;
            elseif p==11 && i2==9
                p=19;
            end
            % Capture
            if (ismember(board_num(i2,j2),n_group)==1) && (ismember(p,s_group)==1)
                while(1)
                    result_sp=input('South 4 or 6 Prison? ');
                    if result_sp==4
                        s_p4(n_S4)=board_num(i2,j2);
                        n_S4=n_S4+1;
                        break
                    elseif result_sp==6
                        s_p6(n_S6)=board_num(i2,j2);
                        n_S6=n_S6+1;
                        break
                    else
                        fprintf('Invalid input. Please type again.\n')
                    end
                end
                
            elseif (ismember(board_num(i2,j2),s_group)==1) && (ismember(p,n_group)==1)
                while(1)
                    result_np=input('North 4 or 6 Prison? ');
                    if result_np==4
                        n_p4(n_N4)=board_num(i2,j2);
                        n_N4=n_N4+1;
                        break
                    elseif result_np==6
                        n_p6(n_N6)=board_num(i2,j2);
                        n_N6=n_N6+1;
                        break
                    else
                        fprintf('Invalid input. Please type again.\n')
                    end
                end
            end
            % Move piece
            if i1==5
                board_num(i1,j1)=20;
            elseif (i1==1 && j1==4) || (i1==1 && j1==6) || (i1==9 && j1==4) || (i1==9 && j1==6)
                board_num(i1,j1)=21;
            else
                board_num(i1,j1)=0;
            end
            board_num(i2,j2)=p;
            flag_break=1;
            
            % Liberate check
            if ismember(board_num(1,4),s_group)==1 && sum(n_p4)~=0
                for n_l=(n_N4-1):-1:1
                    while(1)
                        fprintf('Place %s in:  \n',piece_list{n_p4(n_l)})
                        result_l=input('>>> ([i j]): ');
                        if length(result_l)==2
                            i3=result_l(1);j3=result_l(2);
                            if board_num(i3,j3)==0 && i3>=6 && i3<=9 && j3<=9 && j3>=1
                                board_num(i3,j3)=n_p4(n_l);
                                n_p4(n_l)=0;
                                n_N4=n_N4-1;
                                break
                            end
                        end
                        fprintf('Invalid placement. Please type again.\n')
                    end
                end
            end
            if ismember(board_num(1,6),s_group)==1 && sum(n_p6)~=0
                for n_l=(n_N6-1):-1:1
                    while(1)
                        fprintf('Place %s in:  \n',piece_list{n_p6(n_l)})
                        result_l=input('>>> ([i j]): ');
                        if length(result_l)==2
                            i3=result_l(1);j3=result_l(2);
                            if board_num(i3,j3)==0 && i3>=6 && i3<=9 && j3<=9 && j3>=1
                                board_num(i3,j3)=n_p6(n_l);
                                n_p6(n_l)=0;
                                n_N6=n_N6-1;
                                break
                            end
                        end
                        fprintf('Invalid placement. Please type again.\n')
                    end
                end
            end
            if ismember(board_num(9,4),n_group)==1 && sum(s_p4)~=0
                for n_l=(n_S4-1):-1:1
                    while(1)
                        fprintf('Place %s in:  \n',piece_list{s_p4(n_l)})
                        result_l=input('>>> ([i j]): ');
                        if length(result_l)==2
                            i3=result_l(1);j3=result_l(2);
                            if board_num(i3,j3)==0 && i3>=1 && i3<=4 && j3<=9 && j3>=1
                                board_num(i3,j3)=s_p4(n_l);
                                s_p4(n_l)=0;
                                n_S4=n_S4-1;
                                break
                            end
                        end
                        fprintf('Invalid placement. Please type again.\n')
                    end
                end
            end
            if ismember(board_num(9,6),n_group)==1 && sum(s_p6)~=0
                for n_l=(n_S6-1):-1:1
                    while(1)
                        fprintf('Place %s in:  \n',piece_list{s_p6(n_l)})
                        result_l=input('>>> ([i j]): ');
                        if length(result_l)==2
                            i3=result_l(1);j3=result_l(2);
                            if board_num(i3,j3)==0 && i3>=1 && i3<=4 && j3<=9 && j3>=1
                                board_num(i3,j3)=s_p6(n_l);
                                s_p6(n_l)=0;
                                n_S6=n_S6-1;
                                break
                            end
                        end
                        fprintf('Invalid placement. Please type again.\n')
                    end
                end
            end
            
        else
            fprintf('Invalid input. Please type again.\n')
        end
        
        if flag_break==1
            break
        end
        
    end
    
    if result_general==1001 
        break
    end
    clc
end
fprintf('\n+++Game end+++\n\n')