function f=jhfp()
clc
%clear all
m=input('num of referees:');
k=input('num of schools:');
p=input('请输入每份试卷需评委数目 P:'); 
n=input('请输入参赛人数 N:');
ss=input('需要筛选的随机矩阵数ss:');
d11=input('输入对d1的约束上限：'); %not used?
d22=input('输入对d2的约束上限:');  %not used?
d33=input('输入对d3的约束上限:');  %I add this
xp=0;%建立学校与评委间的联系
chushibianhao(1)=0; 
for i=1:k%学校编号
    l(i)=input('请按学校编号依次输入参赛人数:');
    ml(i)=input('若该学校有老师参与评卷，请输入1,否则输入0:'); 
    chushibianhao(i+1)=chushibianhao(i)+l(i);%i+1对应---i 
    if(ml(i)==1)
        xp=xp+1;%评委编号
        pingweino(xp)=i;%pingweino存储评委对应的学校编号 
    end
end
sizeconfirm=size(pingweino);
if sizeconfirm(2)~=m
    disp('输入有误，关闭程序重新输入') 
end
%average=n*p/m;
a=zeros(ss,n,m);
for i=1:m%评委/此循环是为了制造条件 
    %刻画该评委不能评的试卷编号组
    %与下面的nrand...保证某学校试卷不被该学校老师评/建立评委与学校间的约束
    sum1(i)=0;
    sum2(i)=0;
    for r=1:pingweino(i)
        sum2(i)=sum2(i)+l(r);
    end
%next line?
    sum1(i)=sum2(i)-l(r)+1; %每一个评委对应一个不可及范围--第sum1+1到第sum2号试卷 
end


for x=1:ss%生成_个矩阵
    for j=1:n%试卷按学校顺序编号，同一份试卷只对应p个评委 ，产生对第
        %随机生成一个不重复数序（1-n），保证刚好被第k个评委评到 
        nrand=randperm(m);%产生一个1到m的随机顺序
        for s=1:p%n选前p个或p+1个%选试卷的评委
            a(x,j,nrand(s))=1;%此位置与对应评委位置为1，先概全，再剔除 
            flag1=0;
            flag2=0;%为了控制第i个评委为0,查询位置 
            for i=1:m
                if(sum1(i)<=j&&sum2(i)>=j)%对于一份试卷j，每一次都你能找到不多于一个范围并对应一个评委i，记为jl 
                    flag1=1;
                    jl=i;
                end%I add this
                if nrand(s)==jl %检验随机获取的前p个数据中是否包含评委jl 
                    flag2=1;
                end
            end
        end
    d=nrand(s); 
    if flag1
        a(x,j,jl)=0;%利用查询位置做处理，此位置必须为0（可以覆盖前面的0)
    end
    if flag1&&flag2%若包含jl
        %v=nrand(p+1);
        a(x,j,nrand(p+1))=1;%取编号不为i的评委，即随机数中的下一个数据号作为第p个评委编号 end
    end
    end
end
for x=1:ss 
    for j=1:n
        for i=1:m
            b(x,i,j)=a(x,j,i); %行列置换随机矩阵数/评委号/试卷号 
        end
    end
end
%至此回避原则已解决
%统计各老师评卷工作量并求D1 
for x=1:ss 
    for i=1:m
        %average2(x)=0; 
        pwl(x,i)=0; 
        for j=1:n
            if( b(x,i,j) ==1)
                pwl(x,i)=pwl(x,i)+1; 
            end
        end
    end
end
for x=1:ss
    d1(x)=var(pwl(x,:));
end

%处理试卷分配均衡分散(1.各学校的试卷在评委中应均衡分配；2.任意两份试卷尽量不被相同的评委评到） %实现1
%统计评委i评学校k试卷数
for x=1:ss 
    for i=1:m
        for r=1:k
            px(i,r)=0;
            for j=chushibianhao(r+1):chushibianhao(r+1)+l(r)-1 
                %disp(i)
                %disp(j)
                %disp(l(r))
                %disp(r)
                %disp(px(i,r))
                %disp(b(x,i,j))
                %px(i,r)=px(i,r)+b(x,i,j); 
            end
            pxaverage(i,r)=px(i,r)/l(r);%统计评委i评学校k试 
        end
        d2(i)=var(pxaverage(i));
    end
%sum3(x)=sum(pxaverage);
d3(x)=var(d2); 
end
%选出符合标准的矩阵 
d=0;
for x=1:ss
    if(d1(x)<d11&&d3(x)<d33)
        for i=1:m
            for j=1:n
                sc(i,j)=b(x,i,j); 
            end
        end
            d=d+1; 
            disp(sc) 
    end
end
disp(['共筛选出的随机矩阵数' blanks(4) num2str(d)])
