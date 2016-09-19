#测量丢包率的awk代码
#针对out.tr的分析
 
BEGIN {
     #初始化， 设置变量以记录 packet 被 drop 的数目
    dropNum=0;
    totalNum=0;
    i=0;
  }
  {
  action=$1;
  time=$2;
  scr_node=$3;
  dst_node=$4;
  type=$5;
  pktsize=$6;
  flow_id=$8;
  src=$9;
  dst=$10;
  seq_no=$11;
  packet_id=$12;
  
  if (scr_node==0 && dst_node==1 && action=="+")
  { 
	totalNum++;
       timeArr[i]=time;
	lossrate[i]=(float)(dropNum/totalNum);
	i++;
  }
 
  if (action =="d")
      dropNum++;
    }
    END {
   printf("#number of packet sent:%d,lost:%d\n",totalNum,dropNum);
   printf("#lost rate of packets:%f\n",dropNum/totalNum);
   for(j=0;j<i;j++)
   printf("%f\t%f\n",timeArr[j],lossrate[j]);
    }
