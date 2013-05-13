#!/usr/bin/perl -w
use strict;

open(A, "../CENTROMERE.bed") or die $!;

my %type;
my %start;
my %end;
my %chr;
my %chr2id;
my @feature;
my @ids;
my %total;
my %typec;
#my $root = shift;
my $BOXLEN = 100;
my $imax=0;
my $SIZE = 20000;
my $FLANK = $SIZE/2;

#Get the geature of the cntromere and add 20kbp to each end 
while(<A>){
    chomp;
    my ($chr, $start, $end) = split;
#    $total{$type} += $end - $start + $SIZE;    
    my $mid = int(($end-$start)/2) + $start;
    my $id = "CEN" . $chr;
    $id =~ s/chr//;
    push(@ids, $id);
    $start{$id} = $mid - $FLANK;
    $end{$id} = $mid + $FLANK;
    $chr{$id} = $chr;
    push(@{$chr2id{$chr}[int($start/1000000)]}, $id);
}

#load each file,  cycle through  ids by their chr 
# Store overlap, more? 

foreach my $file (@ARGV){
    open(F, $file) or die "cannot open $file";
    open(O, ">$file-cenboxplot-2-50k") or die $!;
 
    #for each bg file 
   while(<F>){
	chomp;
	my ($chr, $start, $stop, $value) = split;
#	$total{$file} += $stop - $start;
	M: foreach my $id ( @{$chr2id{$chr}[int($start/1000000)]}  ){
	    next if $stop <  $start{$id};
	    next if $start >  $end{$id};

	    my $i =0;
	    my $boxstart = $start{$id};	    
	    #record max count if overlap feature
 	    while( ($boxstart + $BOXLEN)  <=  $end{$id} ){

		if (&overlap($boxstart, $boxstart + $BOXLEN,  $start, $stop)){
		    $feature[$i]{$id} ||= 0;
#		    print "Found $id at $i at  $start, $stop with $value";
		    $feature[$i]{$id} = $value if $value > $feature[$i]{$id};
		}
		$boxstart += $BOXLEN;
		$imax = $i if $i > $imax;
		$i++;
		next M if $boxstart > $stop;
	    }
	}
   }
    


#This is plotting by each chromosome a column    
    print O join ("\t", "Position", @ids), "\n";
    foreach my $i (0..$imax){ # each position a new 
	my @bin;	
	foreach my $id ( @ids ){
	    push(@bin,  $feature[$i]{$id}||0);
	}
	print O join("\t", ($i * $BOXLEN) -$FLANK,  @bin), "\n";
   }
}



sub overlap{
    my ($s1, $e1, $s2, $e2) = @_;
    my $intersect = 0;

    if(($e2 >= $s1)  and ($e2 < $e1)){ 
	$intersect = $e2-$s1 if ($s2 <= $s1); # 5' overlap 
	$intersect = $e2-$s2 if ($s2 > $s1);  # Internal
	 die "$intersect # ($e2 >= $s1)  and ($e2 < $e1))  $s1, $e1, $s2, $e2" if ($intersect < 0);

    }elsif(($s2 >= $s1)  and ($s2 < $e1)){
	$intersect = $e1-$s2; # 3' Overlap
	    die "$intersect # HERE # ($s2 >= $s1)  ($s2 < $e2)  $s1, $e1, $s2, $e2" if ($intersect < 0);
    }elsif(($e1 < $e2) and ($s1 > $s2)){ 
	$intersect = $e1 - $s1; # feature internal
	    die "$intersect # ($e1 < $e2) and ($s1 > $s2)  $s1, $e1, $s2, $e2" if ($intersect < 0);
    }
    die "$intersect ### $s1, $e1, $s2, $e2" if ($intersect < 0);
    return($intersect);
}

    
