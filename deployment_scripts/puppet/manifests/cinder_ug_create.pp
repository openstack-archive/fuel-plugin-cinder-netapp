notice('MODULAR: netapp-cinder-ug-create')

group {'cinder':
  ensure => present,
  gid => '902'
} ->

user {'cinder':
  ensure => present,
  uid => '902',
  gid => '902',
}
