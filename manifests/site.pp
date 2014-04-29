# This is the root manifest that's loaded by Puppet at the start of
# processing.  It includes the other files required to bootstrap the complete
# Puppet manifests.

# Global defaults.
File { backup => false }
Exec { path => '/usr/bin:/usr/sbin:/bin:/sbin' }

# Set the default package provider.
Package {
  provider => $::operatingsystem ? {
    'debian' => 'aptitude',
    'redhat' => 'yum',
    'ubuntu' => 'aptitude',
  }
}

# Definitions for all of the systems and their root classes.
import 'nodes.pp'

# The default node to catch unconfigured nodes.
node default {
  fail("node not configured in Puppet")
}
