#        s1                   d1
#            \                   /
# 20Mb,15ms \               / 20Mb,15ms
#           r0 --------- r1
# 20Mb,15ms /    15ms       \ 20Mb,15ms
#            /                   \
#        s2                   d2 


#Create a simulator object
set ns [new Simulator]

#Open the nam trace file
set nf [open out.nam w]
set tf [open out.tr w]
$ns namtrace-all $nf
$ns trace-all $tf

#Define a 'finish' procedure
proc finish {} {
        global ns nf tf
        $ns flush-trace
        #Close the trace file
        close $nf
        close $tf
        #Execute nam on the trace file
        exec nam out.nam &
        exit 0
}

#defining the topology
set R0 [$ns node]
set R1 [$ns node]
$ns duplex-link $R0 $R1 12Mb 15ms DropTail
$ns queue-limit $R0 $R1 30

#Number of sources
set NodeNb 4

#Create links between the nodes
for {set i 1} {$i <= $NodeNb} {incr i} {
	set S($i) [$ns node]
	set D($i) [$ns node]
	$ns duplex-link $S($i) $R0 20Mb 15ms DropTail
	$ns duplex-link $D($i) $R1 20Mb 15ms DropTail
}

#Setup TCP connection
for {set i 1} {$i <= $NodeNb} {incr i} {
	set tcp($i) [new Agent/TCP/Newreno]
	$ns attach-agent $S($i) $tcp($i)
	set sink($i) [new Agent/TCPSink]
	$ns attach-agent $D($i) $sink($i)
	$ns connect $tcp($i) $sink($i)
	#This is the standard algorithm
	#$tcp($i) set windowOption_ 1
	#This is the Njust algorithm
	$tcp($i) set windowOption_ 9
	#This is the NormalJust algorithm
	#$tcp($i) set windowOption_ 10
	$tcp($i) set window_ 65536
	$tcp($i) set packetSize_ 1000
	#$tcp($i) set fid_ $i
}

#Setup FTP Application
for {set i 1} {$i <= $NodeNb} {incr i} {
	set ftp($i) [new Application/FTP]
	$ftp($i) attach-agent $tcp($i) 
	$ns at 0.0 "$ftp($i) start"
}

$ns at 100.0 "finish"

$ns run

