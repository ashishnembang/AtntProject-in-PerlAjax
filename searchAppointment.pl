#!C:\xampp\perl\bin\perl
print header('application/json');
use DBI;
use strict;
use warnings;
use JSON;
use CGI qw(:standard);

my $row;
my $driver   = "SQLite"; 
my $database = "AtntProject.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
                      or die $DBI::errstr;
my $cgi = new CGI;

	my $searchField = $cgi->param('txt_search'); 

	#searching operation                     
	my $query = qq(select * from appointment where description like '$searchField%');
	my $sth = $dbh->prepare($query);
	$sth->execute()  or die $DBI::errstr;
	
	my @finalArray;
	while($row=$sth->fetchrow_hashref){
		push @finalArray,$row;
	}
	
	#json conversion
	print to_json(\@finalArray);
	$dbh->disconnect();