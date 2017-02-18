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
                      
my @finalArray;                    
                 
    #selecting datas from appointment table     
	my $query = qq(SELECT * FROM appointment);
	my $sth = $dbh->prepare($query);
	$sth->execute()  or die $DBI::errstr;
	
	while($row=$sth->fetchrow_hashref){
		push @finalArray,$row;
	}
	
	#converting into json
	print to_json(\@finalArray);
	$dbh->disconnect();