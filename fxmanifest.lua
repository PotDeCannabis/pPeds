fx_version 'cerulean'
games { 'gta5' };

shared_script 'shared/*'

server_scripts {
  'server/*',
  'shared/*',
  '@mysql-async/lib/MySQL.lua',
}

client_scripts {
  'shared/*',
  'client/*'
}