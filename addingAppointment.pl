#!C:\xampp\perl\bin\perl
use DBI;
use DBI;
use strict;
use warnings;
use CGI qw(:standard);

#database connection
my $driver   = "SQLite"; 
my $database = "AtntProject.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
                      or die $DBI::errstr;
my $cgi = CGI->new();
     
	my $date_param = $cgi->param('txt_date');
	my $time_param = $cgi->param('txt_time');
	my $desc_param = $cgi->param('txt_desc');

	#checking condition where their are inputs or not
	if($date_param ne '' && $time_param ne '' && $desc_param ne ''){
		addFormInput($date_param, $time_param, $desc_param);
	}

	#redirecting back to index.html
	print redirect(-url=>'http://localhost/a/index.html');

	#insertion operation
	sub addFormInput{
		my $date = @_[0];
		my $time = @_[1];
		my $desc = @_[2];
		
		my $dateandtime = $date." ".$time; 
		my $query = qq(INSERT INTO appointment VALUES ('$dateandtime', '$desc'));
		my $sth = $dbh->prepare($query);
		my $rv = $sth->execute()  or die $DBI::errstr;
		
		$dbh->disconnect();	
	}
     



