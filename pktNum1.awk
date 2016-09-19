BEGIN {pktDrops=0;numPkt=0;}
    {
    action=$1;
    time=$2;
    scr_node=$3;
    dst_node=$4;
    type = $5;
    pktsize=$6;
    flow_id=$8;
    node_1_address=$9;
    node_2_address=$10;
    seq_no=$11;
    packet_id=$12;
    #发包总数：
	if(scr_node==0 && dst_node==1 && action=="r" && type == "tcp")  
	numPkt++;
}
END{
	printf("packet number =%d",numPkt);
}
