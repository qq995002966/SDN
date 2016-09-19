#将out.tr文件用awk分析队列长度变化情况后获得的结果保存到queue_length.tr中
BEGIN {
	highest_packet_id = -1;
	packet_count = 0;
	q_len = 0;
	}

{
	action = $1;
	time = $2;
	scr_node = $3;
	dst_node = $4;
	type = $5;
	flow_id = $8;
	seq_no = $11;
	packet_id = $12;
#源节点为0，目的节点为1
if(src_node == 0 && dst_node == 1){
	if(packet_id>highest_packet_id){
		highest_packet_id = packet_id;
			}


#入队
if(action == "+"){
	q_len++;
	print time,q_len;
	}
#出队或丢包
else if(action == "-"||action == "d"){
	q_len--;
	print time,q_len;
	}
}
}




