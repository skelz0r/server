define vhost_rails(
  $hostname
)
{
	# vHost
	file {
		"/etc/apache2/sites-enabled/rails":
			content => template("passenger/rails.erb"),
			mode		=> 644,
      owner   => root,
      group   => root,
      alias   => "passenger_vhost",
      notify  => Service["apache2"];
	}
}
