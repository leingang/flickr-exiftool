#!/opt/local/bin/perl -w

# Idea: parse flickr pages and extract metadata

use LWP::Simple;
# use HTML::Tidy;

use XML::XPath;
use XML::XPath::XMLParser;


use Data::Dumper; # debugging

$html = get("http://www.flickr.com/photos/emry/3561573722/sizes/l/");
$html =~ s/<![^>]*>//;

my $xp = XML::XPath->new(xml => $html);

print $xp->getNodeText('//div[@class="Owner"]')
