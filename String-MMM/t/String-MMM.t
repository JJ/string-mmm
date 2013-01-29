# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl String-MMM.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use lib qw(../lib lib 
	   /home/jmerelo/proyectos/CPAN/string-mmm/String-MMM/blib/lib 
	   /home/jmerelo/proyectos/CPAN/string-mmm/String-MMM/blib/arch);

use Test::More tests => 31;
BEGIN { use_ok('String::MMM', qw(:all)) };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $tests = [ [ 'AAAB', 'BAAA', 6, 2, 2 ],
	      ['AAAA','BBBB',3,0,0],
	      ['AAAA','AAAA',3,4,0],
	      ['ABCDEFGHIJKLM','M'x13, 15,1,0],
	      ['ABCDEFG','GFEDCBA', 10, 1, 6]];

for my $t ( @$tests ) {
  my @this_test = @$t;
  my @result = match_strings($this_test[0], $this_test[1], $this_test[2]);
  is( $result[0], $this_test[3], 'OK blacks');
  is( $result[1], $this_test[4], 'OK whites');
  @result =  match_strings_a(lc($this_test[0]), lc($this_test[1]));
  is( $result[0], $this_test[3], 'OK blacks a');
  is( $result[1], $this_test[4], 'OK whites a');
  my @first_array = to_arr($this_test[0]);
  my @second_array = to_arr($this_test[1]);
  @result =  match_arrays(\@first_array, \@second_array, 18);
  is( $result[0], $this_test[3], 'OK blacks array ' . $this_test[0] . " " . $this_test[1]);
  is( $result[1], $this_test[4], 'OK whites array '. $this_test[0] . " " . $this_test[1]);
}

sub to_arr {
  my $str = shift;
  return map( ord($_)-ord('A'), split(//, $str ));
}
