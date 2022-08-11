#!/usr/bin/env perl

use warnings;
use strict;

use ExtUtils::Packlist;
use ExtUtils::Installed;

my($installed) = undef;
my($version) = '';
my(@dirs) = ();

print "Finding all installed modules...\n";
$installed = ExtUtils::Installed->new();
foreach my $module (grep(!/^Perl$/, $installed->modules())) {
  $version = $installed->version($module) || '???';
  @dirs = $installed->directories($module);
  print "$module v. $version";
  if (! scalar(@dirs)) {
    print ' NO DIRECTORIES';
  }
  print "\n";
}
