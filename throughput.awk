#测量数据包的平均吞吐率的awk代码
#针对out.tr的分析
 
BEGIN {
       init=0;
       i=0;
  }
  {
  #将out.tr文件的相应字段赋值给变量
  action=$1;
  time=$2;
  scr_node=$3;
  dst_node=$4;
  type=$5;
  pktsize=$6;
  flow_id=$8;
  node_1_address=$9;
  node_2_address=$10;
  seq_no=$11;
  packet_id=$12;
  
#Vegas
 if (action=="r" && scr_node==0 && dst_node==1 && flow_id==2) {
#NormalJust
 #if (action=="r" && scr_node==0 && dst_node==1 && flow_id==1) {
#mytcl1.tcl
 #if (action=="r" && scr_node==0 && dst_node==1) {
      pkt_byte_sum[i+1]=pkt_byte_sum[i]+pktsize;
   
   if (init==0) {
       start_time=time;
    init=1;
  }
  end_time[i]=time;
  i=i+1;
       }
    }
    END {
      #第一笔记录的Throughput设置为零， 以表示传输开始, 为了绘图的美观
      printf("%.2f\t %.2f\n", end_time[0],0);
    
   for (j=1; j<i; j++) {
   #单位为 kbps
       th=pkt_byte_sum[j]/(end_time[j] - start_time) *8/1000;
    printf("%.2f\t%.2f\n", end_time[j], th);
  }
  
  #最后一笔记录的Throughput设置为零， 以表示传输结束, 为了绘图的美观
      printf("%.2f\t%.2f\n", end_time[i-1],0);
    }
