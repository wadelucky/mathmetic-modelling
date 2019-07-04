function y=fussy()
M = load('data_ori.txt');
shape=size(M);
maxx=linspace(0,0,45);
minn=linspace(100,100,45);
re_e=linspace(0,0,3);
re_g=linspace(0,0,3);
re_w=linspace(0,0,3);
re_bb=linspace(0,0,3)';
re_gg=linspace(1,1,3)';
re_u=linspace(0,0,1046);

for i=1:shape(1)
    for j=1:3%only considering the original score
        ori(i,j)=M(i,j*2);
        if(ori(i,j)>maxx(M(i,j*2-1)))
            maxx(M(i,j*2-1))=ori(i,j);
        end
        if(ori(i,j)<minn(M(i,j*2-1)))
            minn(M(i,j*2-1))=ori(i,j);
        end
    end
end

k=1/log(3);%1/ln n
sum_g=0;

for i=1:shape(1)
    %sum_row=0;
    for j=1:3
        %M(i,j*2-1)
        re_ori(i,j)=(ori(i,j)-minn(M(i,j*2-1)))/(maxx(M(i,j*2-1))-minn(M(i,j*2-1)));
        %sum_row=sum_row+ori(i,j);
    end
    for j=1:3
        re_p(i,j)=ori(i,j)/sum(ori(:,j));%sum_row;
        re_e(j)=re_e(j)+re_p(i,j)*log(re_p(i,j));
    end
end

for j=1:3
    re_e(j)=abs(k*re_e(j));
    re_g(j)=1-re_e(j);
end

re_w=re_g/sum(re_g);
re_sum=sum(re_w);
re_w;

for i=1:1046
    re_u(i)=1/(1+sqrt(re_w*(-re_ori(i,:)+1)'/(re_w*re_ori(i,:)')));
end

re_u=re_u*100;
fid=fopen('out.txt','wt');
fprintf(fid,'%g\n',re_u);
fclose(fid);
%save('output.txt','re_u','-ascii')


