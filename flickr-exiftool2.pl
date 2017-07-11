#!/opt/local/bin/perl -w

use WWW::Mechanize;
use HTML::TreeBuilder;
use Getopt::Long;
use Data::Dumper;

my $flickr_image_url = "http://www.flickr.com/photos/emry/3561573722"; # argument
my $size='l'; # option
my $verbose=0;
my $debug=0;

sub msg {
  print shift, "\n" if $verbose;
}

sub debug {
  print shift, "\n" if $debug;
}

my $set_option_result=GetOptions(
				 'size'=>\$size,
				 'verbose|v'=>\$verbose,
				 'debug'=>\$debug
);


my $mech = WWW::Mechanize->new();
$mech->agent_alias( 'Mac Mozilla' );
$mech->cookie_jar(HTTP::Cookies->new());
$mech->get($flickr_image_url);
# get the title
$doc = HTML::TreeBuilder->new_from_content($mech->content);
$doc->elementify;

# title is inside an <h1>...</h1>
$title = $doc->look_down('_tag','h1')->content->[0];
msg "Title: $title";

# all sizes link
$all_sizes_url = $doc->look_down('_tag','a','alt','All sizes')->attr('href');
msg "All sizes url: $all_sizes_url";

debug "Getting $all_sizes_url";
$doc->delete;
$mech->get($all_sizes_url);
debug "status: " . $mech->status;

$doc = HTML::TreeBuilder->new_from_content($mech->content);
$doc->elementify;

$identifier =$doc->look_down('_tag','div','class','DownloadThis')
  ->look_down('_tag','p')
  ->look_down('_tag','b')
  ->look_down('_tag','a')
  ->attr('href');
msg "Identifer: $identifier";

$creator_element= $doc->look_down('_tag','div','class','Owner');
$creator_URL = $creator_element
  ->look_down('_tag','a') # gets the first link
  ->attr('href');
$creator_URL = 'http://www.flickr.com' . $creator_URL unless ($creator_URL =~ m/https?/);
msg "Creator: $creator_URL";

$creator_name = $doc->

$doc->delete;



# look for available sizes


msg "Done";

