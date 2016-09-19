#混合通讯时使用
#        s1                   d1
#            \                   /
# 20Mb,15ms \               / 20Mb,15ms
#           r0 --------- r1
# 20Mb,15ms /    15ms       \ 20Mb,15ms
#            /                   \
#        s2                   d2 


#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red

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

#Create six nodes
set node_(r0) [$ns node]
set node_(r1) [$ns node]
set node_(s1) [$ns node]
set node_(s2) [$ns node]
set node_(d1) [$ns node]
set node_(d2) [$ns node]

#Create links between the nodes
$ns duplex-link $node_(r0) $node_(r1) 12Mb 15ms DropTail
$ns duplex-link $node_(s1) $node_(r0) 20Mb 15ms DropTail
$ns duplex-link $node_(s2) $node_(r0) 20Mb 15ms DropTail
$ns duplex-link $node_(d1) $node_(r1) 20Mb 15ms DropTail
$ns duplex-link $node_(d2) $node_(r1) 20Mb 15ms DropTail

#Set Queue Size of link (r0-r1) to 30
$ns queue-limit $node_(r0) $node_(r1) 30

#Give node position (for NAM)
$ns duplex-link-op $node_(s1) $node_(r0) orient right-down
$ns duplex-link-op $node_(s2) $node_(r0) orient right-up
$ns duplex-link-op $node_(r0) $node_(r1) orient right
$ns duplex-link-op $node_(r1) $node_(d2) orient right-down
$ns duplex-link-op $node_(r1) $node_(d1) orient right-up

#Monitor the queue for link (r0-r1). (for NAM)
$ns duplex-link-op $node_(r0) $node_(r1) queuePos 0.5

#Setup TCP connection
set tcp1 [$ns create-connection TCP/Newreno $node_(s1) TCPSink $node_(d1) 0]
#This is the NormalJust algorithm
$tcp1 set windowOption_ 10
$tcp1 set window_ 65536
$tcp1 set packetSize_ 1000
$tcp1 set fid_ 1

set tcp2 [$ns create-connection TCP/Newreno $node_(s2) TCPSink $node_(d2) 0]
#set tcp2 [$ns create-connection TCP/Vegas $node_(s2) TCPSink $node_(d2) 0]
#This is the standard algorithm
$tcp2 set windowOption_ 1
#This is the Njust algorithm
#$tcp2 set windowOption_ 9
#This is the NormalJust algorithm
#$tcp2 set windowOption_ 10
$tcp2 set window_ 65536
$tcp2 set packetSize_ 1000
$tcp2 set fid_ 2

#Setup FTP Application
set ftp1 [$tcp1 attach-source FTP]
set ftp2 [$tcp2 attach-source FTP]

#Simulation Scenario
$ns at 0.0 "$ftp1 start"
$ns at 0.0 "$ftp2 start"
$ns at 100.0 "finish"


$ns run



