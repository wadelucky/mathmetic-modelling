#include <iostream>
#include <bits/stdc++.h>
using namespace std;

int main()
{
    ifstream in;
    in.open("data_ori.txt");//only considering original score now
    //in.open("data_std.txt");//now is the previous std score
    //in.open("data_new_std.txt");//now is the updated std score
    double dat[1050][6];
    //double exp_ori[46];
    //double exp_std[46];
    double full[1050][46];
    double avg_ori[1050];
    int people=0;
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

    ofstream out;
    out.open("new_ranking.txt");
    //double temp[46];
    //double weight[1050][46];
    double ref_weight[46];
    double sum_weight=0;
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
    for(int j=1;j<=45;j++){
        //cout<<"ref_weight "<<ref_weight[j]<<endl;
        ref_weight[j]=ref_weight[j]/sum_weight;
        cout<<ref_weight[j]<<endl;
    }

    double work_revised[1050];
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

//    for (int j=1;j<=45;j++){
//        for(int i=1;i<=1046;i++){
//            if(full[i][j]!=0){//not zero
//                temp[j]+=(avg_ori[i]-full[i][j])*(avg_ori[i]-full[i][j]);
//            }
//        }
//        temp[j]=sqrt(temp[j]);
//        out<<temp[j]<<endl;
//    }

    //cout << "Hello world!" << endl;
    return 0;
}
