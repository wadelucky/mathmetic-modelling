#include <iostream>
#include <bits/stdc++.h>
using namespace std;

int main()
{
    ifstream in;
    in.open("data_ori.txt");//only considering original score now
    ofstream out;
    out.open("new_ori(评判系数).txt");
    double dat[1050][6];//原始数据
    double full[1050][46];//第j个专家给第i个作品的评分
    double avg_ori[1050];//dat里每一行的平均值（原始分或标准分）
    int people=0;//专家标号
    double work_revised[1050];//由评判系数确定权重后对每个作品的回加权
    double ref_weight[46];//每个专家的权重
    double sum_weight=0;//总权重，方便归一化
    double temp[46];//用来计算欧氏距离
    //double weight[1050][46];
    for (int i=1;i<=1046;i++){
        for (int j=0;j<6;j++){
            in>>dat[i][j];
            //cout<<dat[i][j]<<endl;
        }
        for (int j=0;j<6;j=j+2){
            //cout<<dat[i][j]<<endl;
            people=dat[i][j];
            full[i][people]=dat[i][j+1];//full[i][j] is work i's score given by expert j
            avg_ori[i]+=dat[i][j+1];
        }
        avg_ori[i]=avg_ori[i]/3;//adjust average
    }

    for(int i=1;i<=1046;i++){
        for(int j=1;j<=45;j++){
            if(full[i][j]!=0){
                //weight[i][j]=1/(1+(full[i][j]-avg_ori[i])*(full[i][j]-avg_ori[i]));
                ref_weight[j]+=1/(1+(full[i][j]-avg_ori[i])*(full[i][j]-avg_ori[i]));
                sum_weight+=1/(1+(full[i][j]-avg_ori[i])*(full[i][j]-avg_ori[i]));
            }
        }
    }
    //cout<<"sum_weight "<<sum_weight<<endl;
    out<<"45位专家根据原始分权重情况(顺序)"<<endl;
    for(int j=1;j<=45;j++){
        //cout<<"ref_weight "<<ref_weight[j]<<endl;
        ref_weight[j]=ref_weight[j]/sum_weight;
        out<<ref_weight[j]<<endl;
    }

    out<<"1046个作品根据原始分加权后情况(顺序)"<<endl;

    for(int i=1;i<=1046;i++){
        double temp_sum=0;//calculating current weight sum for these 3 out of 45 referees
        for(int j=1;j<=45;j++){
            work_revised[i]+=ref_weight[j]*full[i][j];
            if(full[i][j]!=0){
                temp_sum+=ref_weight[j];
            }
        }
        out<<work_revised[i]/temp_sum<<endl;
    }
    out.close();

    out.open("new_ori(欧氏距离).txt");
    out<<"45位专家根据原始分欧式距离(顺序)"<<endl;
    for (int j=1;j<=45;j++){
        for(int i=1;i<=1046;i++){
            if(full[i][j]!=0){//not zero
                temp[j]+=(avg_ori[i]-full[i][j])*(avg_ori[i]-full[i][j]);
            }
        }
        temp[j]=sqrt(temp[j]);
        out<<temp[j]<<endl;
    }
    out.close();

    out.open("new_std(评判系数).txt");
    in.open("data_std.txt");//only considering std score now
    sum_weight=0;//renew
    for (int i=1;i<=1046;i++){//renew
            avg_ori[i]=0;
            work_revised[i]=0;
    }
    for (int j=1;j<=45;j++)ref_weight[j]=0;//renew
    for (int i=1;i<=1046;i++){
        for (int j=0;j<6;j++){
            in>>dat[i][j];
            //cout<<dat[i][j]<<endl;
        }
        for (int j=0;j<6;j=j+2){
            //cout<<dat[i][j]<<endl;
            people=dat[i][j];
            full[i][people]=dat[i][j+1];//full[i][j] is work i's score given by expert j
            avg_ori[i]+=dat[i][j+1];
        }
        avg_ori[i]=avg_ori[i]/3;//adjust average
    }


    //out.open("new_std.txt");
    //double temp[46];
    //double weight[1050][46];

    for(int i=1;i<=1046;i++){
        for(int j=1;j<=45;j++){
            if(full[i][j]!=0){
                //weight[i][j]=1/(1+(full[i][j]-avg_ori[i])*(full[i][j]-avg_ori[i]));
                ref_weight[j]+=1/(1+(full[i][j]-avg_ori[i])*(full[i][j]-avg_ori[i]));
                sum_weight+=1/(1+(full[i][j]-avg_ori[i])*(full[i][j]-avg_ori[i]));
            }
        }
    }
    //cout<<"sum_weight "<<sum_weight<<endl;
    out<<"45位专家根据标准分权重情况(顺序)"<<endl;
    for(int j=1;j<=45;j++){
        //cout<<"ref_weight "<<ref_weight[j]<<endl;
        ref_weight[j]=ref_weight[j]/sum_weight;
        out<<ref_weight[j]<<endl;
    }

    out<<"1046个作品根据标准分加权后情况(顺序)"<<endl;

    for(int i=1;i<=1046;i++){
        double temp_sum=0;//calculating current weight sum for these 3 out of 45 referees
        for(int j=1;j<=45;j++){
            work_revised[i]+=ref_weight[j]*full[i][j];
            if(full[i][j]!=0){
                temp_sum+=ref_weight[j];
            }
        }
        out<<work_revised[i]/temp_sum<<endl;
    }
    out.close();

    out.open("new_std(欧氏距离).txt");
    out<<"45位专家根据标准分欧式距离(顺序)"<<endl;
    for (int j=1;j<=45;j++){
        for(int i=1;i<=1046;i++){
            if(full[i][j]!=0){//not zero
                temp[j]+=(avg_ori[i]-full[i][j])*(avg_ori[i]-full[i][j]);
            }
        }
        temp[j]=sqrt(temp[j]);
        out<<temp[j]<<endl;
    }
    out.close();


    return 0;
}

