function f=jhfp()
clc
%clear all
m=input('num of referees:');
k=input('num of schools:');
p=input('������ÿ���Ծ�����ί��Ŀ P:'); 
n=input('������������� N:');
ss=input('��Ҫɸѡ�����������ss:');
d11=input('�����d1��Լ�����ޣ�'); %not used?
d22=input('�����d2��Լ������:');  %not used?
d33=input('�����d3��Լ������:');  %I add this
xp=0;%����ѧУ����ί�����ϵ
chushibianhao(1)=0; 
for i=1:k%ѧУ���
    l(i)=input('�밴ѧУ������������������:');
    ml(i)=input('����ѧУ����ʦ��������������1,��������0:'); 
    chushibianhao(i+1)=chushibianhao(i)+l(i);%i+1��Ӧ---i 
    if(ml(i)==1)
        xp=xp+1;%��ί���
        pingweino(xp)=i;%pingweino�洢��ί��Ӧ��ѧУ��� 
    end
end
sizeconfirm=size(pingweino);
if sizeconfirm(2)~=m
    disp('�������󣬹رճ�����������') 
end
%average=n*p/m;
a=zeros(ss,n,m);
for i=1:m%��ί/��ѭ����Ϊ���������� 
    %�̻�����ί���������Ծ�����
    %�������nrand...��֤ĳѧУ�Ծ�����ѧУ��ʦ��/������ί��ѧУ���Լ��
    sum1(i)=0;
    sum2(i)=0;
    for r=1:pingweino(i)
        sum2(i)=sum2(i)+l(r);
    end
%next line?
    sum1(i)=sum2(i)-l(r)+1; %ÿһ����ί��Ӧһ�����ɼ���Χ--��sum1+1����sum2���Ծ� 
end


for x=1:ss%����_������
    for j=1:n%�Ծ�ѧУ˳���ţ�ͬһ���Ծ�ֻ��Ӧp����ί �������Ե�
        %�������һ�����ظ�����1-n������֤�պñ���k����ί���� 
        nrand=randperm(m);%����һ��1��m�����˳��
        for s=1:p%nѡǰp����p+1��%ѡ�Ծ����ί
            a(x,j,nrand(s))=1;%��λ�����Ӧ��ίλ��Ϊ1���ȸ�ȫ�����޳� 
            flag1=0;
            flag2=0;%Ϊ�˿��Ƶ�i����ίΪ0,��ѯλ�� 
            for i=1:m
                if(sum1(i)<=j&&sum2(i)>=j)%����һ���Ծ�j��ÿһ�ζ������ҵ�������һ����Χ����Ӧһ����ίi����Ϊjl 
                    flag1=1;
                    jl=i;
                end%I add this
                if nrand(s)==jl %���������ȡ��ǰp���������Ƿ������ίjl 
                    flag2=1;
                end
            end
        end
    d=nrand(s); 
    if flag1
        a(x,j,jl)=0;%���ò�ѯλ����������λ�ñ���Ϊ0�����Ը���ǰ���0)
    end
    if flag1&&flag2%������jl
        %v=nrand(p+1);
        a(x,j,nrand(p+1))=1;%ȡ��Ų�Ϊi����ί����������е���һ�����ݺ���Ϊ��p����ί��� end
    end
    end
end
for x=1:ss 
    for j=1:n
        for i=1:m
            b(x,i,j)=a(x,j,i); %�����û����������/��ί��/�Ծ�� 
        end
    end
end
%���˻ر�ԭ���ѽ��
%ͳ�Ƹ���ʦ������������D1 
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

%�����Ծ��������ɢ(1.��ѧУ���Ծ�����ί��Ӧ������䣻2.���������Ծ���������ͬ����ί������ %ʵ��1
%ͳ����ίi��ѧУk�Ծ���
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
            pxaverage(i,r)=px(i,r)/l(r);%ͳ����ίi��ѧУk�� 
        end
        d2(i)=var(pxaverage(i));
    end
%sum3(x)=sum(pxaverage);
d3(x)=var(d2); 
end
%ѡ�����ϱ�׼�ľ��� 
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
disp(['��ɸѡ�������������' blanks(4) num2str(d)])
