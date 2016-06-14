#!/bin/perl
my $html = '';

while (<>) {
    $html .= $_;
}
$html =~ s/.*<div id="content">//s;
$html =~ s/<div class="notecontainer">.*//s;
if ($html =~ s@<a href="/web/.*/http://mspandrew.tumblr.com/post/.*/(.*)">@<a href="#$1">@) {
    my $anchor = $1;
    $html =~ s/<div class="post">/<div class="post" id="$anchor">/;
}
$html =~ s/\n//g;
$html =~ s/\r//g;
$html .= '</div><div class="bottom"></div>';

open my $fh, '<', './tumblr.html';
my $tumblr = '';
while (<$fh>) {
    s/<!-- ADD HERE -->/<!-- ADD HERE -->\n$html/;
    $tumblr .= $_;
}
close $fh;
open $fh, '>', './tumblr.html';
say $fh $tumblr;
#print $html;