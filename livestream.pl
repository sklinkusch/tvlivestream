#!/usr/bin/perl -w

# Skript zum einfachen Empfang von Internet-Livestreams diverser Fernsehsender

use strict;
use warnings;
no warnings "experimental";
use diagnostics;
use FindBin;

my %mpvOptions = ("none" => "", "mute" => "-mute");
my %mpv = ("player" => "mpv", "options" => \%mpvOptions);
my %player = ("mpv" => \%mpv);

printExit() if($#ARGV < 0);

my $mute = "-mute" ~~ @ARGV ? 1 : 0;
my @args = grep { !/-mute/ } @ARGV;
my $sender = lc($args[0]);
my %senderliste;
my @allSender;
my @allSenderSorted;
my @linkliste;

if ($sender eq "list") {
	%senderliste = getSenderliste();
	@allSender = keys(%senderliste);
	@allSenderSorted = sort { $a cmp $b } @allSender;
	print join(" ", @allSenderSorted);
	print "\n";
	exit;
} elsif ($sender eq "query") {
	%senderliste = getSenderliste();
	@allSender = keys(%senderliste);
	@allSenderSorted = sort { $a cmp $b } @allSender;
	print join("\n", @allSenderSorted);
	print "\n";
	exit;
} elsif ($sender eq "fulllist") {
	%senderliste = getSenderliste();
	@allSender = keys(%senderliste);
	@allSenderSorted = sort { $a cmp $b } @allSender;
	foreach my $nr (0..$#allSenderSorted) {
		my $currentSender = $allSenderSorted[$nr];
		print "$currentSender => $senderliste{$currentSender}\n";
	}
	exit;
} elsif ($sender eq "number") {
	@linkliste = getUrls();
	print scalar @linkliste;
	print "\n";
	exit;
} else {
	switchSender($sender);
}


sub printExit {
	print "Gebrauch: livestream.pl sender/list/query/number\n";
	exit;
}


sub switchSender {
	my $str = shift;
	my %senderliste = getSenderliste();
	if (exists $senderliste{$str}) {
		my $url = $senderliste{$str};
		my $currentPlayer = $player{mpv}{player};
		my $currentOptions = $mute == 1 ? $player{mpv}{options}{mute} : $player{mpv}{options}{none};
		system("$currentPlayer $currentOptions $url");
	} else {
		printExit();
	}
}


sub getSenderliste {
	my %res;
	my $listfile = "$FindBin::RealBin/livestream.list";
	open(LIST, $listfile) || die "Kann Senderliste nicht öffnen!\n";
	while (my $line = <LIST>){
		chomp($line);
		if($line !~ /^#/){
			my @linearray = split(/[\t ]+/, $line);
			foreach my $nr (1..$#linearray){
				$res{$linearray[$nr]} = $linearray[0];
			}
		}
	}
	close(LIST);
	return %res;
}


sub getUrls {
	my @res;
	my $listfile = "$FindBin::RealBin/livestream.list";
	open(LIST, $listfile) || die "Kann Senderliste nicht öffnen!\n";
	while (my $line = <LIST>){
		chomp($line);
		if($line =~ /^#/){
			my @linearray = split(/[\t ]+/, $line);
			push(@res, $linearray[0]);
		}
	}
	close(LIST);
	return @res;
}
