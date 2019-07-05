%function y=fussy()
M_ori = load('data_ori.txt');
M_std = load('data_std.txt');
shape=size(M_ori);
maxx_ori=linspace(0,0,45);
minn_ori=linspace(100,100,45);
maxx_std=linspace(0,0,45);
minn_std=linspace(100,100,45);
e_ori=linspace(0,0,3);%original entropy
g_ori=linspace(0,0,3);%original one minus entropy
e_std=linspace(0,0,3);%std entropy
g_std=linspace(0,0,3);%std one minus entropy
%w=linspace(0,0,3);
B=linspace(0,0,3)';%worst degree vector
G=linspace(1,1,3)';%best degree vector
u_ori=linspace(0,0,1046);%optimum degree of each work under original score
u_std=linspace(0,0,1046);%optimum degree of each work under std score
a=zeros(1046,3);%original score
b=zeros(1046,3);%standardized score
p_ori=zeros(1046,3);%weight of jth work under ith expert in one line(original)
p_std=zeros(1046,3);%weight of jth work under ith expert in one line(std)
re_ori=zeros(1046,3);%normalization matrix original form
re_std=zeros(1046,3);%normalization matrix std form


for i=1:shape(1)
    for j=1:3%traverse the whole matrix
        a(i,j)=M_ori(i,j*2);
        b(i,j)=M_std(i,j*2);
        if(a(i,j)>maxx_ori(M_ori(i,j*2-1)))
            maxx_ori(M_ori(i,j*2-1))=a(i,j);
        end
        if(a(i,j)<minn_ori(M_ori(i,j*2-1)))
            minn_ori(M_ori(i,j*2-1))=a(i,j);
        end
        if(b(i,j)>maxx_std(M_ori(i,j*2-1)))
            maxx_std(M_ori(i,j*2-1))=b(i,j);
        end
        if(b(i,j)<minn_std(M_ori(i,j*2-1)))
            minn_std(M_ori(i,j*2-1))=b(i,j);
        end        
    end
end

k=1/log(3);%factor of 1/ln n

for i=1:shape(1)
    %sum_row=0;
    for j=1:3
        %M(i,j*2-1)
        re_ori(i,j)=(a(i,j)-minn_ori(M_ori(i,j*2-1)))/(maxx_ori(M_ori(i,j*2-1))-minn_ori(M_ori(i,j*2-1)));
        re_std(i,j)=(b(i,j)-minn_std(M_std(i,j*2-1)))/(maxx_std(M_std(i,j*2-1))-minn_std(M_std(i,j*2-1)));
        %sum_row=sum_row+ori(i,j);
    end
    for j=1:3
        p_ori(i,j)=a(i,j)/sum(a(:,j));%sum_row;
        p_std(i,j)=b(i,j)/sum(b(:,j));%sum_row;
        e_ori(j)=e_ori(j)+p_ori(i,j)*log(p_ori(i,j));
        e_std(j)=e_std(j)+p_std(i,j)*log(p_std(i,j));
    end
end

for j=1:3
    e_ori(j)=abs(k*e_ori(j));
    g_ori(j)=1-e_ori(j);
    e_std(j)=abs(k*e_std(j));
    g_std(j)=1-e_std(j);
end

w_ori=g_ori/sum(g_ori);%weight in the end, summation is 1
w_std=g_std/sum(g_std);%weight in the end, summation is 1
%re_sum=sum(w);

for i=1:1046
    u_ori(i)=1/(1+sqrt(w_ori*(-re_ori(i,:)+1)'/(w_ori*re_ori(i,:)')));
    u_std(i)=1/(1+sqrt(w_std*(-re_std(i,:)+1)'/(w_std*re_std(i,:)')));
end

u_ori=u_ori*100;
fid=fopen('out_ori.txt','wt');
fprintf(fid,'%g\n',u_ori);
fclose(fid);

u_std=u_std*100;
fid=fopen('out_std.txt','wt');
fprintf(fid,'%g\n',u_std);
fclose(fid);
%save('output.txt','re_u','-ascii')


