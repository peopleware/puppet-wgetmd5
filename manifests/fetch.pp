define wgetmd5::fetch (
  $destination,
  $source             = $title,
  $timeout            = '0',
  $verbose            = false,
  $redownload         = false,
  $nocheckcertificate = false,
  $execuser           = undef,
  $user               = undef,
  $password           = undef,
  $cache_dir          = undef,
  $cache_file         = undef,
  $checksum,
) {

  exec { "check_md5_$destination":
    command => "/bin/rm -f $destination",
    unless  => "/bin/echo '${checksum}  ${destination}' | /usr/bin/md5sum -c --quiet",
    notify  => Wget::Fetch[$name],
  }

  wget::fetch { $name:
    source             => $source,
    destination        => $destination,
    timeout            => $timeout,
    verbose            => $verbose,
    redownload         => $redownload,
    nocheckcertificate => $nocheckcertificate,
    execuser           => $execuser,
    user               => $user,
    password           => $password,
    cache_dir          => $cache_dir,
    cache_file         => $cache_file,
  }

}
