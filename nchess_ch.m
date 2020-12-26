clear all
clc

% Initialization
B=1; X=2; M=3; J=4; G=5; S=6;XX=9;
z=11;x=12;m=13;j=14;n=15;jj=16;w=19;
piece_list={'兵'  '相' '馬' '車' '弓' '帅' 0 0 '校' 0 '卒' '象' '傌' '俥' '弩' '将' 0 0 '尉' '～' '＋'};
S_group=[B X M J G S XX];
N_group=[z x m j n jj w];
n_S4=1;n_S6=1;
n_N4=1;n_N6=1;
S_prison4=zeros(1,14);S_prison6=zeros(1,14);
N_prison4=zeros(1,14);N_prison6=zeros(1,14);
board_init=[
    j m x 21 jj 21 x m j;...
    0 n 0 0 0 0 0 n 0;...
    z 0 z 0 z 0 z 0 z;...
    0 0 0 0 0 0 0 0 0;...
    20 20 20 20 20 20 20 20 20 ;...
    0 0 0 0 0 0 0 0 0;...
    B 0 B 0 B 0 B 0 B;...
    0 G 0 0 0 0 0 G 0;...
    J M X 21 S 21 X M J
    ];

board_num=board_init;
lft_indx={'１' '｜';'２' '｜'; '３' '｜' ;'４' '｜' ;'５' '｜' ;'６' '｜' ; '７' '｜'; '８' '｜' ;'９' '｜'};
up_indx={'１' '２' '３' '４' '５' '６' '７' '８' '９';'：' '：' '：' '：' '：' '：' '：' '：' '：'  };
lft_up_crnr={'０' '｜';'：'  '｜' };
%===================================================================
while(1)
    % Initialize the board
    for row=1:9
        for col=1:9
            piece_num=board_num(row,col);
            switch piece_num
                case 0
                    piece='－';
                otherwise
                    piece=piece_list{piece_num};
            end
            board_raw{row,col}=piece;
        end
    end
    board=[lft_up_crnr up_indx;lft_indx board_raw];
    % Print N_prison
    if sum(N_prison4)==0
        fprintf('北4囚：无 \n')
    else
        fprintf('北4囚：')
        for n_np=1:(n_N4-1)
            fprintf('%s ',piece_list{N_prison4(n_np)})
        end
        fprintf('\n')
    end
    if sum(N_prison6)==0
        fprintf('北6囚：无 \n')
    else
        fprintf('北6囚：')
        for n_np=1:(n_N6-1)
            fprintf('%s ',piece_list{N_prison6(n_np)})
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
    if sum(S_prison4)==0
        fprintf('南4囚：无 \n')
    else
        fprintf('南4囚：')
        for n_sp=1:(n_S4-1)
            fprintf('%s ',piece_list{S_prison4(n_sp)})
        end
        fprintf('\n')
    end
    if sum(S_prison6)==0
        fprintf('南6囚：无 \n')
    else
        fprintf('南4囚：')
        for n_sp=1:(n_S6-1)
            fprintf('%s ',piece_list{S_prison6(n_sp)})
        end
        fprintf('\n')
    end
    fprintf('\n')
    
    % Winning check
    flag_S=0; flag_N=0;
    for row=1:9
        for col =1:9
            if board_num(row,col)==S
                flag_S=1;
            end
            if board_num(row,col)==jj
                flag_N=1;
            end
        end
    end
    if flag_S==0
        fprintf('==北胜==\n')
        break
    elseif flag_N==0
        fprintf('==南胜==\n')
        break
    end
    %===================================================================
    while(1)
        % Input
        fprintf('=====================\n')
        fprintf('例：兵（7 一）至（6 一） >>> [B 7 1 6 1]\n')
        fprintf('退出： >>> 1001.\n')
        result_general= input('>>> ');
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
                    ( (ismember(p,S_group)==1 && ismember(board_num(i2,j2),S_group)==1)==0 ||...
                    (ismember(p,N_group)==1 && ismember(board_num(i2,j2),N_group)==1)==0)
                switch p
                    case 1  %兵
                        if ((i1-i2)==1 && (j2-j1)==0) || ((i2-i1)==0 && abs(j2-j1)==1)
                            flag_move=1;
                        end
                    case 2  %相
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
                    case 3  %馬
                        if (abs(i2-i1)==2 && abs(j1-j2)==1) || (abs(i2-i1)==1 && abs(j1-j2)==2)
                            flag_move=1;
                        end
                    case 4  %車
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
                    case 5  %弓
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
                    case 6  %帅
                        if (abs(j2-j1)==1  || abs(i2-i1)==1)  && i2>=7
                            flag_move=1;
                        end
                    case 9  %校
                        if (abs(j2-j1)==1 && (i2-i1)==0) || ((j2-j1)==0 && abs(i2-i1)==1)
                            flag_move=1;
                        end
                    case 11 %卒
                        if ((i2-i1)==1 && (j2-j1)==0) || ((i2-i1)==0 && abs(j2-j1)==1)
                            flag_move=1;
                        end
                    case 12 %象
                        if (abs(i2-i1)==abs(j2-j1)) && ((i2-5)*(i1-5)>=0)
                            flag_move=1;
                        end
                    case 13 %傌
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
                    case 14 %俥
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
                    case 15 %弩
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
                    case 16 %将
                        if (abs(j2-j1)==1  || abs(i2-i1)==1)&& i2<=3
                            flag_move=1;
                        end
                    case 19 %尉
                        if (abs(j2-j1)==1 && (i2-i1)==0) || ((j2-j1)==0 && abs(i2-i1)==1)
                            flag_move=1;
                        end
                end
            end
        end
        %===================================================================
        if flag_move==1
            % Promption
            if p==1 && i2==1
                p=9;
            elseif p==11 && i2==9
                p=19;
            end
            % Capture
            if (ismember(board_num(i2,j2),N_group)==1) && (ismember(p,S_group)==1)
                while(1)
                    result_sp=input('南4或6囚？');
                    if result_sp==4
                        S_prison4(n_S4)=board_num(i2,j2);
                        n_S4=n_S4+1;
                        break
                    elseif result_sp==6
                        S_prison6(n_S6)=board_num(i2,j2);
                        n_S6=n_S6+1;
                        break
                    else
                        fprintf('输入无效，请重试。\n')
                    end
                end
                
            elseif (ismember(board_num(i2,j2),S_group)==1) && (ismember(p,N_group)==1)
                while(1)
                    result_np=input('北4或6囚？ ');
                    if result_np==4
                        N_prison4(n_N4)=board_num(i2,j2);
                        n_N4=n_N4+1;
                        break
                    elseif result_np==6
                        N_prison6(n_N6)=board_num(i2,j2);
                        n_N6=n_N6+1;
                        break
                    else
                        fprintf('输入无效，请重试。\n')
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
            if ismember(board_num(1,4),S_group)==1 && sum(N_prison4)~=0
                for n_l=(n_N4-1):-1:1
                    while(1)
                        fprintf('置 %s 于:  \n',piece_list{N_prison4(n_l)})
                        result_l=input('>>> ([i j]): ');
                        if length(result_l)==2
                            i3=result_l(1);j3=result_l(2);
                            if board_num(i3,j3)==0 && i3>=6 && i3<=9 && j3<=9 && j3>=1
                                board_num(i3,j3)=N_prison4(n_l);
                                N_prison4(n_l)=0;
                                n_N4=n_N4-1;
                                break
                            end
                        end
                        fprintf('输入无效，请重试。\n')
                    end
                end
            end
            if ismember(board_num(1,6),S_group)==1 && sum(N_prison6)~=0
                for n_l=(n_N6-1):-1:1
                    while(1)
                        fprintf('置 %s 于:  \n',piece_list{N_prison6(n_l)})
                        result_l=input('>>> ([i j]): ');
                        if length(result_l)==2
                            i3=result_l(1);j3=result_l(2);
                            if board_num(i3,j3)==0 && i3>=6 && i3<=9 && j3<=9 && j3>=1
                                board_num(i3,j3)=N_prison6(n_l);
                                N_prison6(n_l)=0;
                                n_N6=n_N6-1;
                                break
                            end
                        end
                        fprintf('输入无效，请重试。\n')
                    end
                end
            end
            if ismember(board_num(9,4),N_group)==1 && sum(S_prison4)~=0
                for n_l=(n_S4-1):-1:1
                    while(1)
                        fprintf('置 %s 于:  \n',piece_list{S_prison4(n_l)})
                        result_l=input('>>> ([i j]): ');
                        if length(result_l)==2
                            i3=result_l(1);j3=result_l(2);
                            if board_num(i3,j3)==0 && i3>=1 && i3<=4 && j3<=9 && j3>=1
                                board_num(i3,j3)=S_prison4(n_l);
                                S_prison4(n_l)=0;
                                n_S4=n_S4-1;
                                break
                            end
                        end
                        fprintf('输入无效，请重试。\n')
                    end
                end
            end
            if ismember(board_num(9,6),N_group)==1 && sum(S_prison6)~=0
                for n_l=(n_S6-1):-1:1
                    while(1)
                        fprintf('置 %s 于:  \n',piece_list{S_prison6(n_l)})
                        result_l=input('>>> ([i j]): ');
                        if length(result_l)==2
                            i3=result_l(1);j3=result_l(2);
                            if board_num(i3,j3)==0 && i3>=1 && i3<=4 && j3<=9 && j3>=1
                                board_num(i3,j3)=S_prison6(n_l);
                                S_prison6(n_l)=0;
                                n_S6=n_S6-1;
                                break
                            end
                        end
                        fprintf('输入无效，请重试。\n')
                    end
                end
            end
            
        else
            fprintf('输入无效，请重试。\n')
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
fprintf('\n+++本局结束+++\n\n')