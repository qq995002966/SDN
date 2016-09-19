#获得不同节点，不同链路速率的数据包个数
#ns mytcl1.tcl
#gawk -f pktNum1.awk out.tr

#画队列 测丢包率
ns mytcl1.tcl
gawk -f loss.awk out.tr 
#gawk -f queue_length.awk out.tr > queue 
#gnuplot
#set xlabel "Time(s)"
#set ylabel "Queue_length(packets)"
#set title "Queue_length-Time"
#set output 'length.jpg'
#plot "queue" with line smooth cspline


#与vegas,newreno比较
#ns mytcl2.tcl
#gawk -f pktNum1.awk out.tr

#混合通讯
#ns mytcl-mix.tcl
#gawk -f pktNum2.awk out.tr
#gawk -f throughtput.awk out.tr > Vegasthroughput
#gawk -f throughtput.awk out.tr > SJustthroughput
#gnuplot
#set xlabel "Time(s)"
#set ylabel "Throughtput(packets)"
#set title "Throughtput-Time"
#plot 'SJustthroughput'  title "SJust" with line smooth cspline, "Vegasthroughput"  title "Vegas" with line smooth cspline



#指数分布函数画图分析代码，为什么选择数值0.36
#set ylabel "Probability density function"
#set title "Exponential distribution"
#plot 'zhishu3' u 1:2  title "E(x)=0.6" with line smooth cspline, "zhengtai" u 1:2  title "E(x)=0.5" with line smooth cspline, "zhishu4" u 1:2  title "E(x)=0.4" with line smooth cspline,'zhishu2' u 1:2  title "E(x)=0.36" with line smooth cspline
#plot 'zhishu5' u 1:2  title "E(x)=0.36" with line smooth cspline, "zhishu6" u 1:2  title "E(x2)=0.36" with line smooth cspline

#画出参数为0.52，0.12和0.3,0.074的正态分布图，解释为什么不能用指数分布替代
#set ylabel "Probability density function"
#set title "Normal distribution"
#plot 'zhishu' u 1:2  title "E(x)=0.52,D(x)=0.12" with line smooth cspline, "zhengtai2" u 1:2  title "E(x)=0.3,D(x)=0.0174" with line smooth cspline
#plot 'zhengtai3' u 1:2 title "E(x)=0.32,D(x)=0.12"with line smooth cspline
#plot "test" with line smooth cspline,"test2" with line smooth cspline


