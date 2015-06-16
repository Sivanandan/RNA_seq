#!/usr/bin/perl
#processes and libraries implemented
# Modified from Gowthaman Ramasamy's original code.
use strict;
use warnings;
use Bio::SeqIO;
use Data::Dumper;
use Bio::SearchIO;
#operators
my $oFile= shift;
&getFirstHitId_fromBlast($oFile);

sub getFirstHitId_fromBlast()
{
    my $oFile = shift;
    my $in = new Bio::SearchIO( -format => 'blast',
                                 -file   =>  $oFile);
    
    while ( my $result = $in->next_result )
    {
    	my $fHitName; my $fHitDes; my $seen_anyhit = "NO";
        my ($queryName, $queryLen, $query_description) = ($result->query_name, $result->query_length, $result->query_description);
        my $isFirstHit = "YES";  my $hitCount = "0";
        while(my $hit = $result->next_hit)
        {
            my $hitName = $hit->accession;
            my $hitDes = $hit->description;
            $fHitName = $hitName if($isFirstHit eq "YES");
            $fHitDes = $hitDes if($isFirstHit eq "YES");
            $isFirstHit ="NO";++$hitCount;
            $seen_anyhit = 'YES';
        }
        $fHitName= 'NO_HITS_FOUND' if($seen_anyhit eq 'NO');
        $fHitDes= 'NO_HITS_FOUND' if($seen_anyhit eq 'NO');
        print "$queryName\t$fHitName\t$fHitDes\n";
    }
