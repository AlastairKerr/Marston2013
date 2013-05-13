#!/usr/bin/perl -w
#use strict;

open(A, "../CENTROMERE.gff") or die $!;

my %type;
my %start;
my %end;
my %chr;
my %chr2id;
my %feature;
my %total;
my %typec;
#my $root = shift;
my $BOXLEN = 100;
my $imax=0;

while(<A>){
    chomp;
    next unless /ID=/;
    my ($chr, undef, $type, $start, $end, undef, undef, undef, $id) = split;
    $total{$type} += $end - $start + 20000;
    next if $type =~ /chromosome/;
    next unless $id =~ /^ID=/;
    $id =~ s/^ID=//;
    $id =~ s/;.*//;
    my $mid = int(($end-$start)/2) + $start;
    $type{$id} = $type;
    $start{$id} = $mid - 25000;
    $end{$id} = $mid +25000;
    $chr{$id} = $chr;
    push(@{$chr2id{$chr}}, $id);
}

#load each file,  cycle through  ids by their chr 
# Store overlap, more? 

foreach my $file (@ARGV){
    open(F, $file) or die "cannot open $file";
    open(O, ">$file-cenboxplot50k") or die $!;
 
    #for each bg file 
   while(<F>){
	chomp;
	my ($chr, $start, $stop, $value) = split;
#	$total{$file} += $stop - $start;
	M: foreach my $id ( @ {$chr2id{$chr}}  ){
	    next if $stop <  $start{$id};
	    next if $start >  $end{$id};

	    my $i =0;
	    my $boxstart = $start{$id};	    
 	    while( ($boxstart + $BOXLEN)  <  $end{$id} ){

		if (&overlap($boxstart, $boxstart + $BOXLEN,  $start, $stop)){
		    $feature[$i]{$id} ||= 0;
		    $feature[$i]{$id} = $value if $value > $feature[$i]{$id};
		}
		$boxstart += $BOXLEN;
		$i++;
		$imax = $i if $i > $imax;
		next M if $boxstart > $stop;
	    }
	}
   }
    

    foreach my $i (0..$imax){
	my @bin;
	foreach my $id (keys %{$feature[$i]}){
	    push(@bin, $feature[$i]{$id});
	}
	print O join("\t", @bin), "\n";
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

    
